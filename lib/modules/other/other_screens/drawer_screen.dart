import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/style/color.dart';

import '../../../layout/cubit/states.dart';

class DrawerMerchantScreen extends StatelessWidget {
List<Map> drawerItem=[
  {
    'icon':Icons.category,
    'title':'منتجاتي'
  },
  {
    'icon':Icons.add,
    'title':'إضافة منتج جديد'
  },
  {
    'icon':Icons.notifications,
    'title':'الإشعارات'
  },
  {
    'icon':Icons.person,
    'title':'حسابي'
  },
];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Container(
              color: fourColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 60,right: 10,bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text('${ProfileCubit.get(context).userInformation!=null?ProfileCubit.get(context).userInformation!.name![0]:' '}'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ProfileCubit.get(context).userInformation!=null?ProfileCubit.get(context).userInformation!.name:'جاري التحميل'}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'tajawal-light',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${ProfileCubit.get(context).userInformation!=null?ProfileCubit.get(context).userInformation!.phone:'جاري التحميل'}',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'tajawal-light',
                                    color: Colors.grey
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: drawerItem.map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ()
                          {
                            print('s');
                            StoreAppCubit.get(context).selectIndex(drawerItem.indexOf(e));

                          },
                          child: Container(
                            color:StoreAppCubit.get(context).selectedIndex==drawerItem.indexOf(e)?Colors.grey[400]:null ,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:drawerItem.indexOf(e)==2&&ManageProductCubit.get(context).isNotification?Stack(
                                children: [
                                  Row(
                                    children: [
                                      Icon(e['icon'],color: Colors.white,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${e['title']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'tajawal-light',
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.redAccent,
                                  ),
                                ],
                              ): Row(
                                children: [
                                  Icon(e['icon'],color: Colors.white,),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${e['title']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'tajawal-light',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
                    InkWell(
                      onTap: ()async{
                       await logOutDeleteToken(token: fireBaseToken, id: ProfileCubit.get(context).userInformation!.id!,context: context);
                        },
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app,color: Colors.white,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'تسجيل خروج',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
