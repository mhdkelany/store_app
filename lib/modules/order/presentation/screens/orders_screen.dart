import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/presentation/screens/order_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text('طلباتي'),
            ),
            body: ConditionalBuilder(
              builder: (context)
                {
                  if(OrderCubit.get(context).orderEntity!.details.length==0)
                    {
                      return Center(child: Text(
                          'لم تقم بعملية شراء بعد',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 26,
                        ),
                      ),);
                    }
                  else
                  return ListView.separated(
                      itemBuilder: (context,index)
                      {
                        return InkWell(
                          onTap: (){
                            OrderCubit.get(context).totalOrder=0.0;
                            navigateTo(context, OrderDetailsScreen());
                            OrderCubit.get(context).getOrderDetails(int.tryParse(OrderCubit.get(context).orderEntity!.details[index].idBill)!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children:
                              [
                                Text(
                                  'تاريخ الطلب :',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontFamily: 'tajawal-light'
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${OrderCubit.get(context).orderEntity!.details[index].date}',
                                  style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 16
                                  ),
                                ),
                                Spacer(
                                ),
                                Text(
                                  'التفاصيل',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith
                                    (
                                      color: Colors.grey[400]
                                  ),
                                ),
                                Icon(Icons.arrow_circle_left_outlined,color: Colors.grey[400],)
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index)=>Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      itemCount: OrderCubit.get(context).orderEntity!.details.length
                  );
                },
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              condition: OrderCubit.get(context).orderEntity!=null,
            )


          );
        },
      ),
    );
  }
}
