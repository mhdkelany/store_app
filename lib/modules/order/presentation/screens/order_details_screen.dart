import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/style/color.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<OrderCubit,OrderState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text('التفاصيل'),
            ),
            body:ConditionalBuilder(
              builder: (context)=> Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,color: Colors.grey[300],),
                      itemBuilder: (context,index)=> Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '${OrderCubit.get(context).orderForMoreDetailsEntity!.orders[index].name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'tajawal-light',
                                      fontSize: 16
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                               // width: MediaQuery.of(context).size.width*0.15,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                      'الكمية : ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'tajawal-light',
                                      fontSize: 18
                                    ),
                                  ),
                                  Text(
                                    '${OrderCubit.get(context).orderForMoreDetailsEntity!.orders[index].quantity}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontFamily: 'tajawal-light',
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${OrderCubit.get(context).orderForMoreDetailsEntity!.orders[index].sum}د.أ',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      itemCount: OrderCubit.get(context).orderForMoreDetailsEntity!.orders.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,bottom: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'مجموع الفاتورة :',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'tajawal-light',
                              fontSize: 18
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${OrderCubit.get(context).totalOrder}د.أ',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              condition: OrderCubit.get(context).orderForMoreDetailsEntity!=null,
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            )

          );
        },
      ),
    );
  }
}
