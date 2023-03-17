
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';
Map<String,bool> inTheCart={};
class CategoriesForHomeScreen extends StatelessWidget {
  CategoriesForHomeScreen({required this.title, Key? key}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<StoreAppCubit, StoreAppStates>(
        builder: (context, state) {
          if (StoreAppCubit.get(context).categoryIncludeProduct != null)
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: buildText(
                    text: '$title',
                    textStyle: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildListOfProducts(index, context),
                  separatorBuilder: (context, index) => Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                  itemCount: StoreAppCubit.get(context)
                      .categoryIncludeProduct!
                      .products
                      .length),
            );
          else
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        },
      ),
    );
  }

  Widget buildListOfProducts(int index, BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  '$imageUrl${StoreAppCubit.get(context).categoryIncludeProduct!.products[index].image}'),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText(
                      text: '${StoreAppCubit.get(context).categoryIncludeProduct!.products[index].name}',
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
                          text: 'د.أ ${StoreAppCubit.get(context).categoryIncludeProduct!.products[index].price}',
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontFamily: 'tajawal-light',
                            fontSize: 12.sp,
                          )),
                      GestureDetector(
                        onTap: () {
                          var generationFromCubit=StoreAppCubit.get(context)
                              .categoryIncludeProduct!
                              .products[index];
                          bool isExit=false;
                          print(inTheCart);
                          for(int i=0;i<StoreAppCubit.get(context).product.length;i++)
                            {
                              if(generationFromCubit.idProduct==StoreAppCubit.get(context).product[i].idProduct) {
                                isExit = true;
                                break;
                              }
                            }
                          for(int i=0;StoreAppCubit.get(context).product.isEmpty||i<StoreAppCubit.get(context).product.length;i++)
                            {
                              if(StoreAppCubit.get(context).product.isEmpty||!isExit)
                                {
                                  StoreAppCubit.get(context).addToCart(
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
                                  StoreAppCubit.get(context).plus();
                                  inTheCart.addAll({generationFromCubit.idProduct!:true});
                                }
                            }

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color:inTheCart[StoreAppCubit.get(context).categoryIncludeProduct!.products[index].idProduct]!?Colors.grey: Colors.blue[200],
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
