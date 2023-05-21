import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

// ignore: must_be_immutable
class BuildBody extends StatelessWidget {
  final Products model;
  int index = 0;

  BuildBody({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Container(
                child: Expanded(
                  child: Text(
                    '${model.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'tajawal-light'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                // width: MediaQuery.of(context).size.width*0.35,
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  StoreAppCubit.get(context).changeFavorites(model.idProduct!);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: StoreAppCubit.get(context)
                              .isFavorite[model.idProduct]!
                          ? Colors.red[50]
                          : Colors.grey[300]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.favorite,
                      size: 18,
                      color: StoreAppCubit.get(context)
                              .isFavorite[model.idProduct]!
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              // Spacer(),
              SizedBox(
                width: 20.w,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.23,
                child: Text(
                  '${double.tryParse(model.price)!.toStringAsFixed(2)} د.أ ',
                  style: TextStyle(
                      color: primaryColor, fontFamily: 'tajawal-light'),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            '${model.shortDescription}',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ExpandableText('${model.longDescription}',
                expandText: 'المزيد',
                collapseText: 'اقل',
                animationCurve: Curves.slowMiddle,
                maxLines: 3,
                linkColor: primaryColor,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 16.sp,
                    )),
          ),
        ),
        Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 55,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ElevatedButton(
                      onPressed: OrderCubit.get(context).buttonAddToCartShow &&
                              OrderCubit.get(context).countQuantity != 0
                          ? () {
                              OrderCubit.get(context)
                                  .addToCartOperation(context, model);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(onSurface: secondColor),
                      child: Text(
                        'إضافة إلى السلة | ${OrderCubit.get(context).countQuantity * double.tryParse(model.price)!} د.أ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
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
                          onPressed: () {
                            if (int.tryParse(model.quantity!)! >
                                OrderCubit.get(context).countQuantity)
                              OrderCubit.get(context).addQuantityToCart(
                                  index: index, isCart: false);
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  buildSnackBar(
                                      Text('عذراً لقد تجاوزت الكمية المتاحة'),
                                      Colors.red,
                                      Duration(seconds: 5),
                                      key: Key('1')));
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 18,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          '${OrderCubit.get(context).countQuantity}',
                          style: TextStyle(
                            fontFamily: 'tajawal-light',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            OrderCubit.get(context).removeQuantityFromCart(
                                index: index, isCart: false);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.grey,
                            size: 18,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
