import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/models/products_cart_model.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

class BuildItemCart extends StatelessWidget {
  CartProducts model;
  int index;
   BuildItemCart({Key? key,required this.model,required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: '$imageUrl${model.image}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      )),
                  height: 60,
                  width: 60,
                ),
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  width: 60,
                  height: 60,
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 25,
                  child: Icon(
                    Icons.refresh_outlined,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.productName}',
                      style: TextStyle(
                          fontFamily: 'tajawal-light',
                          fontSize: 12.0.sp,
                          color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${model.result.toStringAsFixed(2)} د.أ ',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: primaryColor),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (OrderCubit.get(context)
                            .product[index]
                            .quantityProduct! >
                            OrderCubit.get(context)
                                .product[index]
                                .quantity)
                          OrderCubit.get(context).addQuantityToCart(
                              isCart: true,  index: index);
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              buildSnackBar(
                                  Text('عذراً لقد تجاوزت الكمية المتاحة'),
                                  Colors.red,
                                  Duration(seconds: 5)));
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.grey,
                        size: 18,
                      )),
                  Text(
                    '${model.quantity}',
                    style: TextStyle(
                      fontFamily: 'tajawal-light',
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        OrderCubit.get(context).removeQuantityFromCart(
                            isCart: true, index: index);
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.grey,
                        size: 18,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
