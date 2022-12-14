import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/update_product_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/style/color.dart';

import '../shared/components/constansts/shimmer_widget.dart';

class MainMerchantScreen extends StatelessWidget {
  const MainMerchantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state)
      {
        if(state is GetProductForUserSuccessState)
          StoreAppCubit.get(context).getNotification(context);
        if(state is GetProductForUserSuccessState)
          {
            if(state.productForUserModel.status!=null)
            if(!state.productForUserModel.status!)
              if(state.productForUserModel.message=='No active user')
                {
                  logOut(context);
                  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('حسابك محظور مؤقتأ'), Colors.amber, Duration(seconds: 3)));
                }
          }
      },
      builder: (context,state)
      {
        return  Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(
            builder: (BuildContext context)
            {
              return AnimatedContainer(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(StoreAppCubit.get(context).isOpenDrawer?40:0.0)
                ),
                transform: Matrix4.translationValues(StoreAppCubit.get(context).xOffset, StoreAppCubit.get(context).yOffset, 0)..scale(StoreAppCubit.get(context).scaleFactor),
                duration: Duration(milliseconds: 250),

                child: Column(

                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        StoreAppCubit.get(context).isOpenDrawer?IconButton(onPressed: (){
                          StoreAppCubit.get(context).changeDrawer();
                          }, icon: Icon(Icons.arrow_back_ios)):IconButton(onPressed: ()
                        {
                          StoreAppCubit.get(context).changeDrawer();
                          StoreAppCubit.get(context).notification=[];
                            StoreAppCubit.get(context).getNotification(context);
                        }, icon: Icon(Icons.menu)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'منتجاتي',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'tajawal-light'
                          ),
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                      builder: (context)
                        {
                                if(StoreAppCubit.get(context).productForUserModel!.productForUser.length==0)
                            return Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text('لا يوجد منتجات لعرضها',style: TextStyle(fontSize: 26,color: Colors.grey[300]),),
                            );
                          return Expanded(
                            child: ListView.separated(
                                itemBuilder: (context,index){

                                  return InkWell(
                                    onTap: ()
                                    {
                                      navigateTo(context, UpdateProductScreen(products: StoreAppCubit.get(context).productForUserModel!.productForUser[index],));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.29,
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child:CachedNetworkImage(
                                              cacheManager: StoreAppCubit.get(context).cacheManager,
                                              key: UniqueKey(),
                                              imageUrl:'https://ibrahim-store.com/api/images/${StoreAppCubit.get(context).productForUserModel!.productForUser[index].image}',
                                              imageBuilder: (context,imageProvider)=>Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image(
                                                  height:  MediaQuery.of(context).size.height*0.30,
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                // margin: EdgeInsets.only(top: 5),

                                              ),
                                              placeholder: (context,url)=>Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.30,width:MediaQuery.of(context).size.width*0.19 ,),
                                              ),
                                              errorWidget: (context,url,error)=>Container(
                                                width: MediaQuery.of(context).size.width*0.19,
                                                height: MediaQuery.of(context).size.height*0.30,
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.refresh_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),


                                          ),
                                          Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(top: 20,bottom: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomLeft: Radius.circular(20)
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${StoreAppCubit.get(context).productForUserModel!.productForUser[index].name}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'tajawal-light',
                                                            fontSize: 20
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        '${StoreAppCubit.get(context).productForUserModel!.productForUser[index].price}',
                                                        style: TextStyle(
                                                            color: fourColor,

                                                            fontSize: 15
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        '${StoreAppCubit.get(context).productForUserModel!.productForUser[index].longDescription}',
                                                        style: Theme.of(context).textTheme.caption,
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'تعديل',
                                                                style: TextStyle(
                                                                    color: Colors.grey[300],
                                                                    fontSize: 14,
                                                                    fontFamily: 'tajawal-light'
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 3,
                                                              ),
                                                              Icon(
                                                                Icons.arrow_forward_ios,
                                                                color: Colors.grey[300],
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context,index)=>SizedBox(height: 15,),
                                itemCount: StoreAppCubit.get(context).productForUserModel!.productForUser.length
                            ),
                          );
                        },
                      fallback: (context)=>Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: CircularProgressIndicator(),
                      ),
                      condition:state !=GetProductForUserLoadingState&&StoreAppCubit.get(context).productForUserModel!=null,

                    )
            //       if(StoreAppCubit.get(context).productForUserModel!.productForUser.length==0)
            //   return Column(
            //   children: [
            //   Center(child: Text('لا يوجد منتجات لعرضها',style: TextStyle(fontSize: 30,color: Colors.black),),),
            // ],
            // );
                  ],
                ),
              );
            },

          ),
        );
      },
    );
  }
}
