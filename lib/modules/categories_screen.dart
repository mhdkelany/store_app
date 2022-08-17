import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/categories_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

import '../shared/components/constansts/shimmer_widget.dart';
class CategoriesScreen extends StatelessWidget {
List<String> images=[
  'https://student.valuxapps.com/storage/uploads/banners/1626544896muQ0Q.best-deal-promotional-ribbon-style-green-banner-design_1017-27469.jpg'
];
bool isHome=true;
CategoriesScreen({required this.isHome});
//HomeModel ?homeModel;
//CategoriesScreen(this.homeModel);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
          }
      },
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ConditionalBuilder(
            builder: (context)=>Scaffold(
              appBar: isHome?null:AppBar(),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.24,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index)=>buildCategories1(context,index,StoreAppCubit.get(context).categoriesModel!.data[index]),
                        itemCount: StoreAppCubit.get(context).categoriesModel!.data.length,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'المنتجات',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'tajawal-light'
                        ),
                      ),
                    ),

                    if(StoreAppCubit.get(context).categoryIncludeProduct!=null)
                    Expanded(child: buildCarousel(context)),
                    if(StoreAppCubit.get(context).categoryIncludeProduct==null&&StoreAppCubit.get(context).categoryIncludeProduct!.products.length<0)
                      Text('no')

                  ],
                )
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
            condition: StoreAppCubit.get(context).categoriesModel!=null&&StoreAppCubit.get(context).categoryIncludeProduct!=null,
          ),
        );
      },
    );
  }
  // Widget buildCategories()=>InkWell(
  //   onTap: (){},
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         CachedNetworkImage(
  //           imageUrl:'https://student.valuxapps.com/storage/uploads/banners/1626544896muQ0Q.best-deal-promotional-ribbon-style-green-banner-design_1017-27469.jpg',
  //           imageBuilder: (context,imageProvider)=>Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: CircleAvatar(
  //               radius: 25.0,
  //               backgroundImage: imageProvider,
  //             ),
  //           ),
  //           placeholder: (context,url)=>CircleAvatar(
  //             radius: 30,
  //             child: ShimmerWidget.circular(height: 70,width: 70,
  //             ),
  //           ),
  //           errorWidget: (context,url,error)=>CircleAvatar(
  //             backgroundColor: Colors.grey[300],
  //             radius: 30,
  //             child: Icon(
  //               Icons.refresh_outlined,
  //               color: Colors.grey[400],
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         Text(
  //           'اسم الفئة',
  //           style: TextStyle(
  //               fontSize: 16.0,
  //               fontFamily: 'tajawal-light',
  //               color: Colors.black
  //           ),
  //         ),
  //         Spacer(
  //         ),
  //         Icon(
  //           Icons.arrow_forward_ios,
  //           color: Colors.grey,
  //         ),
  //       ],
  //     ),
  //   ),
  // );
  Widget buildCategories1(context,index,Data data)=>Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: (){
        StoreAppCubit.get(context).selectIndex(index);
        StoreAppCubit.get(context).getProductIncludeCategory(data.idCate);
        print(data.idCate);
      },
      child: Card(
        color: StoreAppCubit.get(context).selectedIndex==index?Colors.grey[200]:null,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: StoreAppCubit.get(context).selectedIndex==index? primaryColor:Colors.white,
                  ),
                  CachedNetworkImage(
                    cacheManager: StoreAppCubit.get(context).cacheManager,
                    key: UniqueKey(),
                    imageUrl:'${data.image}',
                    imageBuilder: (context,imageProvider)=>Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    placeholder: (context,url)=>CircleAvatar(
                      radius: 42,
                      child: ShimmerWidget.circular(height: 70,width: 70,
                      ),
                    ),
                    errorWidget: (context,url,error)=>CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 42,
                      child: Icon(
                        Icons.refresh_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '${data.name}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontFamily: 'tajawal-light'
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  Widget buildCarousel(context)=>
      ConditionalBuilder(
        builder: (context)=>CarouselSlider.builder(
            itemCount: StoreAppCubit.get(context).categoryIncludeProduct!.products.length,
            itemBuilder: (context,index,realIndex)
            {
              //if(StoreAppCubit.get(context).categoryIncludeProduct!.products.length>0)
                return buildImage(index,context);
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height*0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                reverse: true
            )
        ),
        fallback: (context)=>Container(
          height: MediaQuery.of(context).size.height*0.35,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 100,
                  Icons.error_outline_sharp,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'لا يوجد منتجات في هذا القسم',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 18,
                    color: Colors.grey[300]
                  )
                ),
              ],
            ),
          ),
        ),
        condition:StoreAppCubit.get(context).categoryIncludeProduct!.products.length>0 ,
      );
  Widget buildImage(index,context)=>InkWell(
    onTap: (){
      navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).categoryIncludeProduct!.products[index],index: index, ));
     print( StoreAppCubit.get(context).categoryIncludeProduct!.products[index].name);
      print(StoreAppCubit.get(context).categoryIncludeProduct!.products[index].idProduct);
    },
    child: CachedNetworkImage(
      cacheManager: StoreAppCubit.get(context).cacheManager,
      key: UniqueKey(),
      imageUrl: 'https://ibrahim-store.com/api/images/${StoreAppCubit.get(context).categoryIncludeProduct!.products[index].image!}',
      imageBuilder: (context,imageProvider)=> Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: double.infinity,
                child: Image(image: imageProvider,fit: BoxFit.cover,))
          ),
          Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.3)
            ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${StoreAppCubit.get(context).categoryIncludeProduct!.products[index].name}',

                    ),
                    Text(
                      '${StoreAppCubit.get(context).categoryIncludeProduct!.products[index].price} د.أ ',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        color: primaryColor
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
      placeholder: (context,url)=>Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ShimmerWidget.rectangular(height: 300,
        ),
      ),
      errorWidget: (context,url,error)=>Container(
        width: double.infinity,
        height: 300,
        color: Colors.grey[300],
        child: Icon(
          Icons.refresh_outlined,
          color: Colors.grey[400],
        ),
      ),
    ),
  );

}