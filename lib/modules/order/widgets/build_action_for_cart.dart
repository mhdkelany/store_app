import 'package:flutter/material.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/style/icon_broken.dart';

class BuildActionForCart extends StatelessWidget {
  const BuildActionForCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    'حذف',
                    style: TextStyle(),
                  ),
                ),
                content: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    'هل تريد افراغ السلة؟',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                        fontFamily: 'tajawal-light'),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        OrderCubit.get(context)
                            .removeAllCartItem();
                        Navigator.pop(context);
                        OrderCubit.get(context)
                            .countQuantity = 0;
                        OrderCubit.get(context)
                            .quantityIndex = 0;
                        OrderCubit.get(context).i = 0;
                      },
                      child: Text('نعم')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('لا')),
                ],
              ));
        },
        icon: Icon(IconBroken.Delete));
  }
}
