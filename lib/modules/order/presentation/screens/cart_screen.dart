// ignore_for_file: must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/presentation/widgets/build_action_for_cart.dart';
import 'package:store/modules/order/presentation/widgets/build_button_order_now.dart';
import 'package:store/modules/order/presentation/widgets/build_fallback_cart.dart';
import 'package:store/modules/order/presentation/widgets/build_list_view_cart.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/glowing_button/glowing_button.dart';

class CartScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Text(
                    'السلة',
                  ),
                  actions: [
                    if (OrderCubit.get(context).product.length > 0)
                      BuildActionForCart(),
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        builder: (context) =>
                            BuildListViewCart(),
                        fallback: (context) => BuildFallBackCart(),
                        condition: OrderCubit.get(context).product.length > 0,
                      ),
                    ),
                    if (OrderCubit.get(context).product.length > 0&&token!=null)
                      BuildButtonOrderNow(),
                    if(token==null&&OrderCubit.get(context).product.length > 0)
                      GlowingButton(),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ));
          },
        ));
  }
}
