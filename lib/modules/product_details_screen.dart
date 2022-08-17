import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/category_product_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/cart_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../shared/components/constansts/shimmer_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
 Products? model;
 var key1=GlobalKey();
int ?index;
int i=0;
ProductDetailsScreen({this.model,this.index});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>[
              SliverAppBar(
                leading:Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    radius: 18.0,
                    child: IconButton(
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      icon: Icon(IconBroken.Arrow___Right_2,color: Colors.black,size: 18,),
                    ),
                  ),
                ),
                floating: false,
                backgroundColor: forAppBar ,
                toolbarHeight: 50,

                title: Row(
                  children: [
                    Spacer(),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          radius: 18.0,
                          child: IconButton(
                            onPressed: ()
                            {
                              if(StoreAppCubit.get(context).product.length>0) {
                                StoreAppCubit.get(context).priceTotal=0.0;
                                StoreAppCubit.get(context).getTotalBill();
                              }
                              navigateTo(context, CartScreen(index2: index,));
                            },
                            icon: Icon(IconBroken.Buy,color: Colors.black,size: 18,),
                          ),
                        ),
                        if(StoreAppCubit.get(context).product.length>0)
                        CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.red.withOpacity(0.9),
                          child: Text('${StoreAppCubit.get(context).i}',style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ],
                ),
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        )
                    ),
                    padding: EdgeInsets.only(top: 5,bottom: 10),
                    width: double.infinity,
                    // child: Center(
                    //   child: Text(
                    //     'Sliver app bar',
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontFamily: 'tajawal-light'
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.height*0.50,
                flexibleSpace: CachedNetworkImage(
                  cacheManager: StoreAppCubit.get(context).cacheManager,
                  key: UniqueKey(),
                  imageUrl:'https://ibrahim-store.com/api/images/${model!.image}',
                  imageBuilder: (context,imageProvider)=>FlexibleSpaceBar(
                    background: Image(image: imageProvider,fit: BoxFit.cover,),
                  ),
                  placeholder: (context,url)=>Container(
                    child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.53,
                    ),
                  ),
                  errorWidget: (context,url,error)=>Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.53,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.refresh_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),

              ),
            ], body:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          '${model!.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'tajawal-light'
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: MediaQuery.of(context).size.width*0.35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: (){
                          StoreAppCubit.get(context).changeFavorites(model!.idProduct!);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: StoreAppCubit.get(context).isFavorite[model!.idProduct]!?Colors.red[50]:Colors.grey[300]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.favorite,
                              size: 18,
                              color: StoreAppCubit.get(context).isFavorite[model!.idProduct]!?Colors.red:Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width*0.23,
                        child: Text(
                          '${model!.price} د.أ ',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                      '${model!.shortDescription}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ExpandableText(
                        '${model!.longDescription}',
                        expandText: 'المزيد',
                        collapseText: 'اقل',
                        animationCurve: Curves.slowMiddle,
                        maxLines: 3,
                        linkColor: primaryColor,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                        )
                    ),
                  ),
                ) ,
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ElevatedButton(
                                onPressed:StoreAppCubit.get (context).buttonAddToCartShow&&StoreAppCubit.get(context).countQuantity!=0?()
                                {
                                 bool iss=false;
                                  StoreAppCubit.get(context).changeButtonAddToCartShow();
                                  for(int i=0;i<StoreAppCubit.get(context).product.length;i++)
                                    {
                                      if(StoreAppCubit.get(context).product[i].idProduct==model!.idProduct)
                                        {
                                          print(StoreAppCubit.get(context).product.length);
                                          print(i);
                                          iss=true;
                                        }

                                    }
                                  if(StoreAppCubit.get(context).product.isEmpty||!iss) {
                                    StoreAppCubit.get(context).addToCart(
                                      quantityProduct: int.tryParse(model!.quantity!)!,
                                        quantity: StoreAppCubit
                                            .get(context)
                                            .countQuantity,
                                        productName: '${model!.name}',
                                        image: '${model!.image}',
                                        result: StoreAppCubit.get(context).countQuantity*double.tryParse(model!.price)!,
                                        idProduct: '${model!.idProduct}',
                                      price: double.tryParse(model!.price)!
                                    );
                                    StoreAppCubit.get(context).plus();
                                    print('ssssssss');
                                  }
                                  else{
                                    for(int i=0;i<StoreAppCubit.get(context).product.length;i++) {
                                      if(StoreAppCubit.get(context).product[i].idProduct==model!.idProduct)
                                      StoreAppCubit.get(context)
                                          .editProductIncludeCart(
                                          quantity: StoreAppCubit
                                              .get(context)
                                              .countQuantity,
                                          priceTotal: StoreAppCubit
                                              .get(context)
                                              .countQuantity *
                                              double.tryParse(model!.price)!,
                                          index: i);
                                      print('ffffff');
                                    }
                                  }
                                }:null,
                              style: ElevatedButton.styleFrom(
                                onSurface: secondColor
                              ),
                              child: Text(
                                'إضافة إلى السلة | ${StoreAppCubit.get(context).countQuantity*double.tryParse(model!.price)!} د.أ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: ()
                                  {
                                    if(int.tryParse(model!.quantity!)!>StoreAppCubit.get(context).countQuantity)
                                    StoreAppCubit.get(context).addQuantityToCart(index: index,isCart: false);
                                    else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('عذراً لقد تجاوزت الكمية المتاحة'), Colors.red, Duration(seconds: 5),key: Key('1')));
                                      }
                                  },
                                  icon: Icon(
                                      Icons.add,
                                  color: Colors.grey,
                                    size: 18,
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  '${StoreAppCubit.get(context).countQuantity}',
                                  style: TextStyle(
                                    fontFamily: 'tajawal-light',
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: ()
                                  {
                                    StoreAppCubit.get(context).removeQuantityFromCart(index: index,isCart: false);
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.grey,
                                    size: 18,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
              physics: BouncingScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}
