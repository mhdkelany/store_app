import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/map_change_screen.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

class BuildButtonOrderNow extends StatelessWidget {
  const BuildButtonOrderNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<OrderCubit, OrderState>(
  listener: (context, state) {
    if (state is CheckSocketState) {
      ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
          Text('لا يوجد اتصال باﻷنترنت'),
          Colors.amber,
          Duration(seconds: 5)));
    }
    if (state is SendOrderSuccessState)
      ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
          Text('تمت العملية بنجاح سوف نرسل طلبك بأسرع وقت'),
          Colors.greenAccent,
          Duration(seconds: 3)));
  },
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${OrderCubit.get(context).priceTotal.toStringAsFixed(2)} د.أ ',
            style: TextStyle(
                fontFamily: 'tajawal-light',
                fontSize: 18,
                color: Colors.grey),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: state is SendOrderLoadingState
                  ? null
                  : () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      title: Directionality(
                        textDirection:
                        TextDirection.rtl,
                        child: Text(
                          'معلومات الفاتورة',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily:
                              'tajawal-bold'),
                        ),
                      ),
                      content: Directionality(
                          textDirection:
                          TextDirection.rtl,
                          child: Column(
                            mainAxisSize:
                            MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'الموقع:',
                                      style:
                                      TextStyle(
                                        color: Colors
                                            .black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'الموقع االذي تم ادخاله مسبقاً',
                                      style: Theme.of(
                                          context)
                                          .textTheme
                                          .caption!
                                          .copyWith(),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed:
                                            () {
                                          StoreAppCubit.get(
                                              context)
                                              .myMarker = [];
                                          StoreAppCubit.get(
                                              context)
                                              .initialMap();
                                          StoreAppCubit.get(
                                              context)
                                              .isBill = true;
                                          navigateTo(
                                              context,
                                              MapChangeScreen());
                                        },
                                        child: Text(
                                            'تغيير')),
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
                                        color: Colors
                                            .black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${OrderCubit.get(context).priceTotal}',
                                    style: TextStyle(
                                        color:
                                        primaryColor,
                                        fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          )),
                      actions: [
                        TextButton(
                            onPressed: () {
                              // StoreAppCubit.get(context).removeAllCartItem();
                              OrderCubit.get(
                                  context)
                                  .addOrder(context);
                              Navigator.pop(context);
                            },
                            child: Text('نعم')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('لا')),
                      ],
                    ));
                // OrderCubit.get(context).addOrder(context);
              },
              child: Row(
                children: [
                  Text(state is SendOrderLoadingState
                      ? 'جاري الطلب..'
                      : 'اطلب الان'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.arrow_circle_left_outlined)
                ],
              )),
        ],
      ),
    );
  },
);
  }
}
