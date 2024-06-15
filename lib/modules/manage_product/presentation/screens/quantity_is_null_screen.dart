import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/manage_product/presentation/screens/update_product_screen.dart';
import 'package:store/shared/components/components.dart';

import '../../../../layout/cubit/cubit.dart';
import '../../../../shared/style/color.dart';

class QuantityIsNullScreen extends StatelessWidget {
  const QuantityIsNullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Builder(
          builder: (BuildContext context) {
           // StoreAppCubit.get(context).getNotification(context);
            return AnimatedContainer(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(StoreAppCubit.get(context).isOpenDrawer?40:0.0)
              ),
              transform: Matrix4.translationValues(StoreAppCubit.get(context).xOffset, StoreAppCubit.get(context).yOffset, 0)..scale(StoreAppCubit.get(context).scaleFactor),
              duration: Duration(milliseconds: 250),
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      StoreAppCubit.get(context).isOpenDrawer?IconButton(onPressed: (){StoreAppCubit.get(context).changeDrawer(); print('s');}, icon: Icon(Icons.arrow_back_ios)):IconButton(onPressed: ()
                      {
                        StoreAppCubit.get(context).changeDrawer();
                      }, icon: Icon(Icons.menu)),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'الإشعارات',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'tajawal-light'
                        ),
                      ),
                    ],
                  ),
                  if(ManageProductCubit.get(context).notification.length>0)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>InkWell(
                            onTap: (){
                              navigateTo(context, UpdateProductScreen(products: ManageProductCubit.get(context).notification[index]));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage('https://ibrahim-store.com/api/images/${ManageProductCubit.get(context).notification[index].image}'),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${ManageProductCubit.get(context).notification[index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'tajawal-light',
                                                fontSize: 20
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${ManageProductCubit.get(context).notification[index].quantity}',
                                            style: TextStyle(
                                                color: fourColor,

                                                fontSize: 15
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios,color: Colors.grey[300],)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          itemCount: ManageProductCubit.get(context).notification.length
                      ),
                    ),
                  if(ManageProductCubit.get(context).notification.length==0)
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Icon(Icons.error_outline_sharp,size: 200,color: Colors.grey[300],),
                    )

                ],
              ),
            );
          },

        );
      },
    );
  }
}
