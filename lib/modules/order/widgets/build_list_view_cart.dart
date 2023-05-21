import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/widgets/build_Item_cart.dart';
import 'package:store/shared/style/icon_broken.dart';

class BuildListViewCart extends StatelessWidget {

  BuildListViewCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => Dismissible(
              key: Key(OrderCubit.get(context).product[index].idProduct!),
              onDismissed: (direction) {
                OrderCubit.get(context).removeFromCart(index, context);
                OrderCubit.get(context).i--;
              },
              background:backGround() ,
              secondaryBackground:secondaryBackGround() ,
              child: BuildItemCart(
                model: OrderCubit.get(context).product[index],
                index: index,
              )),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          itemCount: OrderCubit.get(context).product.length,
        );
      },
    );
  }

  Widget backGround()=>Container(
    color: Colors.red.withOpacity(0.4),
    child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(IconBroken.Delete, color: Colors.white),
        )),
  );
  Widget secondaryBackGround()=>Container(
    color: Colors.red.withOpacity(0.4),
    child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            IconBroken.Delete,
          ),
        )),
  );
}
