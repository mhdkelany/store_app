import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';

import '../screens/categories_for_home_screen.dart';

class BuildListOfProducts extends StatelessWidget {
   BuildListOfProducts({required this.context,required this.index,Key? key}) : super(key: key);
  int index;
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '$imageUrl${CategoriesAndFavoriteCubit.get(context).categoryIncludeProduct!.products[index].image}'),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                    text: '${CategoriesAndFavoriteCubit.get(context).categoryIncludeProduct!.products[index].name}',
                    lines: 2,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'tajawal-light',
                      fontSize: 12.sp,
                    )),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildText(
                        text: 'د.أ ${double.tryParse(CategoriesAndFavoriteCubit.get(context).categoryIncludeProduct!.products[index].price)!.toStringAsFixed(2)}',
                        textStyle: TextStyle(
                          color: Colors.red,
                          fontFamily: 'tajawal-light',
                          fontSize: 12.sp,
                        )),
                    GestureDetector(
                      onTap: () {
                        var generationFromCubit=CategoriesAndFavoriteCubit.get(context)
                            .categoryIncludeProduct!
                            .products[index];
                        bool isExit=false;
                        print(inTheCart);
                        for(int i=0;i<OrderCubit.get(context).product.length;i++)
                        {
                          if(generationFromCubit.idProduct==OrderCubit.get(context).product[i].idProduct) {
                            isExit = true;
                            break;
                          }
                        }
                        for(int i=0;OrderCubit.get(context).product.isEmpty||i<OrderCubit.get(context).product.length;i++)
                        {
                          if(OrderCubit.get(context).product.isEmpty||!isExit)
                          {
                            OrderCubit.get(context).addToCart(
                                quantity: 1,
                                price: (double.tryParse(generationFromCubit
                                    .price))!,
                                quantityProduct:int.parse(generationFromCubit.quantity!) ,
                                productName: generationFromCubit
                                    .name!,
                                image: generationFromCubit
                                    .image!,
                                result:(double.tryParse(generationFromCubit
                                    .price))! ,
                                idProduct: generationFromCubit
                                    .idProduct!);
                            isExit=true;
                            OrderCubit.get(context).plus();
                            inTheCart!.addAll({generationFromCubit.idProduct!:isExit});
                          }
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_shopping_cart,
                                size: 14.7,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'أضف إلى السلة',
                                style: TextStyle(fontSize: 9.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
