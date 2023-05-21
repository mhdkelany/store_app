import 'package:flutter/material.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/screens/cart_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/icon_broken.dart';

class BuildTitle extends StatelessWidget {
  const BuildTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.8),
              radius: 18.0,
              child: IconButton(
                onPressed: () {
                  if (OrderCubit.get(context).product.length >
                      0) {
                    OrderCubit.get(context).priceTotal = 0.0;
                    OrderCubit.get(context).getTotalBill();
                  }
                  navigateTo(
                      context,
                      CartScreen());
                },
                icon: Icon(
                  IconBroken.Buy,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
            if (OrderCubit.get(context).product.length > 0)
              CircleAvatar(
                radius: 7,
                backgroundColor: Colors.red.withOpacity(0.9),
                child: Text(
                  '${OrderCubit.get(context).i}',
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ],
    );
  }
}
