import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/maps/presentation/controller/map_cubit.dart';
import 'package:store/modules/maps/presentation/screens/map_change_screen.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/domain/order_usecase/order_usecase.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

class BuildButtonOrderNow extends StatelessWidget {
  const BuildButtonOrderNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is CheckSocketOrderState) {
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              Text('لا يوجد اتصال باﻷنترنت'),
              Colors.amber,
              Duration(seconds: 5)));
        }
        if (state is SendOrderSuccessState)
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              Text(
                'تمت العملية بنجاح سوف نرسل طلبك بأسرع وقت',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'tajawal-light',
                ),
              ),
              Colors.green,
              Duration(seconds: 3)));
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
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
                              builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        'معلومات الفاتورة',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'tajawal-bold'),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'الموقع:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  'الموقع االذي تم ادخاله مسبقاً',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    MapCubit.get(context)
                                                        .myMarker = [];
                                                    MapCubit.get(context)
                                                        .initialMap(context);
                                                    MapCubit.get(context)
                                                        .isBill = true;
                                                    navigateTo(context,
                                                        MapChangeScreen());
                                                  },
                                                  child: Text('تغيير'))
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
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${OrderCubit.get(context).priceTotal.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('لا')),
                                        TextButton(
                                            onPressed: () {
                                              // StoreAppCubit.get(context).removeAllCartItem();
                                              OrderCubit.get(context).order(
                                                  OrderParameters(
                                                      product:
                                                          OrderCubit.get(
                                                                  context)
                                                              .product,
                                                      totalBill: OrderCubit.get(
                                                              context)
                                                          .priceTotal,
                                                      lat: OrderCubit.get(
                                                              context)
                                                          .latBill,
                                                      lng: OrderCubit.get(
                                                              context)
                                                          .lngBill,
                                                      context: context));
                                              Navigator.pop(context);
                                            },
                                            child: Text('نعم')),
                                      ],
                                    ),
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
