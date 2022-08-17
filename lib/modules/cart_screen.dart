import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/products_cart_model.dart';
import 'package:store/modules/map_change_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/icon_broken.dart';

class CartScreen extends StatelessWidget {
int ?index2;
CartScreen({ this.index2});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state){
          if(state is CheckSocketState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));

            }
          if(state is SendOrderSuccessState)
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تمت العملية بنجاح سوف نرسل طلبك بأسرع وقت'), Colors.greenAccent, Duration(seconds: 3)));
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text(
                  'السلة',
              ),

              actions: [
                if(StoreAppCubit.get(context).product.length>0)
                IconButton(
                    onPressed: ()
                    {
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        title: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                              'حذف',
                            style: TextStyle(
                            ),
                          ),
                        ),
                        content: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                              'هل تريد افراغ السلة؟',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              fontFamily: 'tajawal-light'
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: ()
                          {
                            StoreAppCubit.get(context).removeAllCartItem();
                            Navigator.pop(context);
                            StoreAppCubit.get(context).countQuantity=0;
                            StoreAppCubit.get(context).quantityIndex=0;
                            StoreAppCubit.get(context).i=0;
                          },
                              child: Text('نعم')),
                          TextButton(onPressed: ()
                          {
                            Navigator.pop(context);
                          }, child: Text('لا')),
                        ],
                      ));
                    },
                    icon: Icon(IconBroken.Delete)
                )
              ],
            ),
            body:Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    builder: (context)=>ListView.separated(
                        itemBuilder: (context, index)=>Dismissible(
                            key: Key(StoreAppCubit.get(context).product[index].idProduct!),
                            onDismissed: (direction)
                            {
                              StoreAppCubit.get(context).removeFromCart(index, context);
                              StoreAppCubit.get(context).i--;
                            },
                            background: Container(

                              color: Colors.red.withOpacity(0.4),
                              child: Align(alignment:AlignmentDirectional.centerStart,child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(IconBroken.Delete,color:Colors.white),
                              )),

                            ),
                            secondaryBackground: Container(
                              color: Colors.red.withOpacity(0.4),
                              child: Align(alignment:AlignmentDirectional.centerEnd,child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(IconBroken.Delete,),
                              )),
                            ),

                            child: buildCartItem(context,StoreAppCubit.get(context).product[index],index)),
                        separatorBuilder: (context, index)=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: StoreAppCubit.get(context).product.length
                    ),
                    fallback: (context)=>Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                         Icon(
                          Icons.remove_shopping_cart,
                           color: Colors.grey[200],
                           size: 100,
                      ),
                         SizedBox(
                        height: 10,
                      ),
                      Text(
                        'السلة فارغة',
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 30
                        ),
                      ),
                    ],)),
                    condition: StoreAppCubit.get(context).product.length>0,
                  ),
                ),
                if(StoreAppCubit.get(context).product.length>0)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${StoreAppCubit.get(context).priceTotal} د.أ ',
                        style: TextStyle(
                          fontFamily: 'tajawal-light',
                          fontSize: 18,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed:state is SendOrderLoadingState?null: ()
                          {
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              title: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'معلومات الفاتورة',
                                 style: TextStyle(
                                   fontSize: 16,
                                   fontFamily: 'tajawal-bold'
                                 ),
                                ),
                              ),
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              'الموقع:',
                                            style: TextStyle(
                                              color: Colors.black,


                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                              'الموقع االذي تم ادخاله مسبقاً',
                                            style: Theme.of(context).textTheme.caption!.copyWith
                                              (

                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                              onPressed: ()
                                              {
                                                StoreAppCubit.get(context).myMarker=[];
                                                StoreAppCubit.get(context).initialMap();
                                                StoreAppCubit.get(context).isBill=true;
                                                navigateTo(context, MapChangeScreen());
                                              },
                                              child: Text('تغيير')
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                Row(
                                  children: [
                                    Text(
                                      'مجموع الفاتورة:',
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('${StoreAppCubit.get(context).priceTotal}',style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18
                                        ),),
                                  ],
                                )
                                  ],
                                )
                              ),
                              actions: [
                                TextButton(onPressed: ()
                                {
                                  // StoreAppCubit.get(context).removeAllCartItem();
                                   StoreAppCubit.get(context).addOrder(context);
                                   Navigator.pop(context);
                                },
                                    child: Text('نعم')),
                                TextButton(onPressed: ()
                                {
                                  Navigator.pop(context);
                                }, child: Text('لا')),
                              ],
                            ));
                            // StoreAppCubit.get(context).addOrder(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                  state is SendOrderLoadingState?'جاري الطلب..':'اطلب الان'
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_circle_left_outlined)
                            ],
                          )
                      ),
                    ],
                  ),
                )
              ],
            )
          );
        },
      ),
    );
  }
  Widget buildCartItem(context,CartProducts model,index)=>Container(
    margin: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(fit: BoxFit.cover,
                    image: NetworkImage('https://ibrahim-store.com/api/images/${model.image}'),
                  )
              ),
              height: 50,
              width: 50,
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model.productName}',
                  style: TextStyle(
                      fontFamily: 'tajawal-light',
                      fontSize: 18.0,
                      color: Colors.black
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model.result} د.أ ',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: primaryColor
                  ),
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: ()
                    {
                      print(StoreAppCubit.get(context).product[index].quantityProduct);
                      print(StoreAppCubit.get(context).product[index].quantity);
                      if(StoreAppCubit.get(context).product[index].quantityProduct!>StoreAppCubit.get(context).product[index].quantity)
                      StoreAppCubit.get(context).addQuantityToCart(isCart: true,index2: index2,index: index);
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('عذراً لقد تجاوزت الكمية المتاحة'), Colors.red, Duration(seconds: 5)));
                        }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: 18,
                    )
                ),
                Text(
                  '${model.quantity}',
                  style: TextStyle(
                    fontFamily: 'tajawal-light',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                    onPressed: ()
                    {
                      StoreAppCubit.get(context).removeQuantityFromCart(isCart: true,index: index);
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.grey,
                      size: 18,
                    )
                ),
              ],
            ),
          ],
        ),

      ],
    ),
  );
}
