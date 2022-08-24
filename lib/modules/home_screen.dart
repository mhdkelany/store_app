import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/categories_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/categories_screen.dart';
import 'package:store/modules/more_product_screen.dart';
import 'package:store/modules/more_top_screen.dart';
import 'package:store/modules/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/icon_broken.dart';
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
          condition: StoreAppCubit.get(context).homeModel!=null&&StoreAppCubit.get(context).categoriesModel!=null,
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
              // TextButton(
              //     onPressed: (){},
              //     child: Text(
              //         'المزيد',
              //       style: TextStyle(
              //         color: Colors.deepOrange
              //       ),
              //     )
              // )
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 120.32,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
              scrollDirection:Axis.horizontal ,
              itemBuilder:(context, index)=>buildCategories(context,StoreAppCubit.get(context).categoriesModel!.data[index],index) ,
              separatorBuilder: (context, index)=>SizedBox(width: 15.0),
              itemCount: StoreAppCubit.get(context).categoriesModel!.data.length
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
              itemBuilder: (context, index) => buildTopSailing(context,StoreAppCubit.get(context).homeModel!.top[index],index),
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
            itemBuilder: (context, index)=>buildNewProducts(context,StoreAppCubit.get(context).homeModel!.products[index],index),
          itemCount: StoreAppCubit.get(context).homeModel!.products.length>=15?15:StoreAppCubit.get(context).homeModel!.products.length,
        ),
      ],
    ),
  );

  Widget buildNewProducts(context,Products products,index)=>InkWell(
    onTap: (){
      navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).homeModel!.products[index],index: index,));
      StoreAppCubit.get(context).countQuantity=0;
      print(products.inFavorites);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
          )
        ),
        elevation: 3,
        child: Column(
          children: [
            CachedNetworkImage(
              cacheManager: StoreAppCubit.get(context).cacheManager,
              key: UniqueKey(),
              imageUrl:'https://ibrahim-store.com/api/images/${products.image}',
              imageBuilder: (context,imageProvider)=>Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:imageProvider
                    )
                ),
                clipBehavior: Clip.antiAlias,
              ),
              fit: BoxFit.cover,
              placeholder: (context,url)=>Container(
                child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.3,),
              ),
              errorWidget: (context,url,error)=>Container(
                width: double.infinity,
                height:MediaQuery.of(context).size.height*0.3 ,
                color: Colors.grey[300],
                child: Icon(
                  Icons.refresh_outlined,
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${products.name}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${products.price}د.أ ',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 18
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Spacer(),
                  // Wrap(
                  //   children: [
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.star)),
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.star)),
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.star)),
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.star)),
                  //   ],
                  // )
                  IconButton(onPressed: ()
                  {
                    StoreAppCubit.get(context).changeFavorites(products.idProduct!);
                  },
                      icon: Icon(
                      Icons.favorite,
                    color: StoreAppCubit.get(context).isFavorite[products.idProduct]!?Colors.red:Colors.grey,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildTopSailing(context,Products products,index)=>InkWell(
    onTap: ()
    {
      print(index);
      navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).homeModel!.top[index],index: index,));
      StoreAppCubit.get(context).countQuantity=0;
    },
    child: Container(
      width: MediaQuery.of(context).size.width*0.6,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CachedNetworkImage(
                cacheManager: StoreAppCubit.get(context).cacheManager,
                key: UniqueKey(),
                imageUrl:'https://ibrahim-store.com/api/images/${products.image}',
                imageBuilder: (context,imageProvider)=>Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image:imageProvider,
                    width: MediaQuery.of(context).size.width*0.19,
                    height: MediaQuery.of(context).size.height*0.10,
                    fit: BoxFit.cover,
                  ),
                ),
                placeholder: (context,url)=>Container(
                  child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.10,width:MediaQuery.of(context).size.width*0.19 ,),
                ),
                errorWidget: (context,url,error)=>Container(
                  width: MediaQuery.of(context).size.width*0.19,
                  height: MediaQuery.of(context).size.height*0.10,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.refresh_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 5,
            ),
            Container(
              height: 77,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.30,
                      child: Text(
                        '${products.name} ' ,
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.33,
                    child: Text(
                      '${products.shortDescription}',
                      style: Theme.of(context).textTheme.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width*0.30,
                    child: Text(
                      '${products.price} د.أ ',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 16
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildCategories(context,Data model,index)=>InkWell(
    onTap: (){
      StoreAppCubit.get(context).getProductIncludeCategory(model.idCate);
      navigateTo(context, CategoriesScreen(isHome: false,));
      StoreAppCubit.get(context).selectIndex(index);
      print(model.idCate);
    },
    child: Container(
      width: MediaQuery.of(context).size.width/5,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [

              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryColor,
                  ),
                  CircleAvatar(
                    radius: 33,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              CachedNetworkImage(
                cacheManager: StoreAppCubit.get(context).cacheManager,
                key: UniqueKey(),
                imageUrl:'${model.image}',
                imageBuilder: (context,imageProvider)=>CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context,url)=>CircleAvatar(
                  radius: 30,
                  child: ShimmerWidget.circular(height: 70,width: 70,
                  ),
                ),
                errorWidget: (context,url,error)=>CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.refresh_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              '${model.name}',
              style: Theme.of(context).textTheme.subtitle1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  Widget buildShimmer(context)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(20)
      ),
      clipBehavior: Clip.antiAlias,
      child: ShimmerWidget.rectangular(height: 200),
    ),
      SizedBox(
        height: 15,
      ),
      Container(
        margin: EdgeInsets.only(right: 10),
        child:ShimmerWidget.rectangular(height: 20,width:MediaQuery.of(context).size.height*0.18 ,) ,
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        height: MediaQuery.of(context).size.height*0.18,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index)=>Column(
              children: [
                Container(
                  child: ShimmerWidget.circular(height: 70, width: 70 ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ShimmerWidget.rectangular(height: 8,width: MediaQuery.of(context).size.width*0.15,),
                ),
              ],
            ),
          itemCount: 10,
          separatorBuilder: (context,index)=>SizedBox(width: 10,),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        margin: EdgeInsets.only(right: 10),
        child:ShimmerWidget.rectangular(height: 20,width:MediaQuery.of(context).size.height*0.18 ,) ,
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        height: MediaQuery.of(context).size.height*0.11 ,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=>Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
            ),
            clipBehavior: Clip.antiAlias,
            child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.11,width: MediaQuery.of(context).size.width*0.30,),
          ),
          itemCount: 10,
          separatorBuilder: (context,index)=>SizedBox(width: 10,),
        ),
      ),
    ],
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
