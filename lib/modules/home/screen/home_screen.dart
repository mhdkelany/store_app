import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/home/widgets/build_categories.dart';
import 'package:store/modules/home/widgets/build_new_products.dart';
import 'package:store/modules/home/widgets/build_top_sailing.dart';
import 'package:store/modules/more_product_screen.dart';
import 'package:store/modules/more_top_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context, state)
      {
        if(state is ConnectFalseState)
        {
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text('no connection'),
            content: Text('please check'),
            actions: [
              TextButton(onPressed: (){}, child: Text('ok'))
            ],
          ));
        }

      },
      builder: (context, state)
      {
        return  ConditionalBuilder(
          condition: StoreAppCubit.get(context).homeModel!=null&&CategoriesAndFavoriteCubit.get(context).categoriesModel!=null,
          builder: (context){
            if(StoreAppCubit.get(context).homeModel!.products.length==0)
              {
                return Center(child: Text('لا يوجد اي منتجات',style: TextStyle(fontSize: 26,color: Colors.grey[300]),),);
              }
            else
            return buildProduct(context,StoreAppCubit.get(context).homeModel!);
          },
          fallback: (context)=>ListView.separated(physics: NeverScrollableScrollPhysics(),itemBuilder: (context,index)=> buildShimmer(context),itemCount: 5,separatorBuilder: (context,index)=>SizedBox(height: 5,),)

        );

      },
    );
  }

  Widget buildProduct(context,HomeModel model)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.banners.map((e) =>CachedNetworkImage(
            cacheManager: StoreAppCubit.get(context).cacheManager,
            key: UniqueKey(),
            imageUrl:'${e.image}',
            imageBuilder: (context,imageProvider)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
                  clipBehavior: Clip.antiAlias,
                  child: Image(image: imageProvider,fit: BoxFit.cover,)),
            ),
            placeholder: (context,url)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                clipBehavior: Clip.antiAlias,
                child: ShimmerWidget.rectangular(height: 300),
              ),
            ),
            errorWidget: (context,url,error)=>Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: Icon(Icons.refresh_outlined),
            ),
          ) ).toList(),
          options: CarouselOptions(
              viewportFraction:0.9,
              height: 200.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                  'الأقسام',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Container(
          height: 120.32.h,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
              scrollDirection:Axis.horizontal ,
              itemBuilder:(context, index)=>BuildCategories(context: context,model: CategoriesAndFavoriteCubit.get(context).categoriesModel!.data[index],index: index) ,
              separatorBuilder: (context, index)=>SizedBox(width: 15.0),
              itemCount: CategoriesAndFavoriteCubit.get(context).categoriesModel!.data.length
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'الأكثر مبيعا',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              Container(
                height: MediaQuery.of(context).size.height*0.05,
                child: TextButton(
                    onPressed: ()
                    {
                      navigateTo(context, MoreTopScreen());
                    },
                    child: Text(
                      'المزيد',
                      style: TextStyle(
                          color: Colors.deepOrange
                      ),
                    )
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.13,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => BuildTopSailing(context:context,products: StoreAppCubit.get(context).homeModel!.top[index],index: index),
              separatorBuilder: (context, index) => SizedBox(width: 15),
              itemCount: StoreAppCubit.get(context).homeModel!.top.length>=10?10:StoreAppCubit.get(context).homeModel!.top.length
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'المنتجات',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              TextButton(
                  onPressed: ()
                  {
                    navigateTo(context, MoreProductsScreen());
                  },
                  child: Text(
                    'المزيد',
                    style: TextStyle(
                        color: Colors.deepOrange
                    ),
                  )
              )
            ],
          ),
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index)=>SizedBox(height: 5,),
            itemBuilder: (context, index)=>BuildNewProducts(context: context,products: StoreAppCubit.get(context).homeModel!.products[index],index: index),
          itemCount: StoreAppCubit.get(context).homeModel!.products.length>=15?15:StoreAppCubit.get(context).homeModel!.products.length,
        ),
      ],
    ),
  );



  buildDialog(context,StoreAppStates state)=> showDialog(context: context, builder: (context)=>AlertDialog(

    title: Text('No Inernet Connection'),
    content: Text('Turn on the WiFi or Mobil Data'),
    actions: [
      TextButton(onPressed: ()
      {
        if(state is ConnectionErrorState)
        {
          buildDialog(context, state);
          Navigator.pop(context);
        }
      }, child: Text('Ok'))
    ],
  ));
}
