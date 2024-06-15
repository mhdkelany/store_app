import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/presentation/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';

import '../screens/categories_for_home_screen.dart';

Map<String, bool>? isInCart = {};

class BuildListOfProducts extends StatelessWidget {
  BuildListOfProducts({required this.context, required this.index, Key? key})
      : super(key: key);
  int index;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          navigateTo(context, ProductDetailsScreen(index: index,model: FavoriteAndCategoryCubit.get(context).productsOfCategoriesEntity!.products[index],));
        },
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl:
                  '$imageUrl${FavoriteAndCategoryCubit.get(context).productsOfCategoriesEntity!.products[index].image}',
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 25,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.refresh_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText(
                      text:
                          '${FavoriteAndCategoryCubit.get(context).productsOfCategoriesEntity!.products[index].name}',
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
                          text:
                              '${double.tryParse(FavoriteAndCategoryCubit.get(context).productsOfCategoriesEntity!.products[index].price)!.toStringAsFixed(2)}د.أ ',
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontFamily: 'tajawal-light',
                            fontSize: 12.sp,
                          )),
                      GestureDetector(
                        onTap: () {
                          var generationFromCubit =
                          FavoriteAndCategoryCubit.get(context)
                                  .productsOfCategoriesEntity!
                                  .products[index];
                          bool isExit = false;
                          print(inTheCart);
                          for (int i = 0;
                              i < OrderCubit.get(context).product.length;
                              i++) {
                            if (generationFromCubit.idProduct ==
                                OrderCubit.get(context).product[i].idProduct) {
                              isInCart!.addAll({
                                OrderCubit.get(context).product[i].idProduct!:
                                    isExit
                              });
                              isExit = true;
                              break;
                            }
                          }
                          for (int i = 0;
                              OrderCubit.get(context).product.isEmpty ||
                                  i < OrderCubit.get(context).product.length;
                              i++) {
                            if (OrderCubit.get(context).product.isEmpty ||
                                !isExit) {
                              OrderCubit.get(context).addToCart(
                                  quantity: 1,
                                  price: (double.tryParse(
                                      generationFromCubit.price))!,
                                  quantityProduct:
                                      int.parse(generationFromCubit.quantity!),
                                  productName: generationFromCubit.name!,
                                  image: generationFromCubit.image!,
                                  result: (double.tryParse(
                                      generationFromCubit.price))!,
                                  idProduct: generationFromCubit.idProduct!);
                              isExit = true;
                              OrderCubit.get(context).plus();
                              isInCart!.addAll(
                                  {generationFromCubit.idProduct!: isExit});
                              Fluttertoast.showToast(
                                msg: "تمت الاضافة الى السلة",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                textColor: Colors.white,
                                fontSize: 14.0.sp,
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.blue),
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
                                  style: TextStyle(
                                      fontSize: 9.sp, color: Colors.white),
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
      ),
    );
  }
}
