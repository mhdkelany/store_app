import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/auth/login/widgets/header.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ProfileCubit.get(context).userInformation != null||token==null,
          builder: (context) => Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 100.h,
                    child: HeaderWidget(100.h, false, Icons.house_rounded),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 5, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(5, 5),
                                )
                              ],
                              color: Colors.white),
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          token!=null?'${ProfileCubit.get(context).userInformation!.name}':withoutName,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'tajawal-light',
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 8.w, bottom: 4.h),
                          alignment: Alignment.topRight,
                          child: Text(
                            'المعلومات',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: 'tajawal-light',
                            ),
                          ),
                        ),
                        if (token != null)
                          Card(
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 4.h,
                                        ),
                                        subtitle: Text(
                                          '${ProfileCubit.get(context).userInformation!.address}',
                                          style: TextStyle(
                                              fontFamily: 'tajawal-light',
                                              fontSize: 14.sp),
                                        ),
                                        title: Text('العنوان'),
                                        leading:
                                            Icon(Icons.location_on_outlined),
                                      ),
                                      ListTile(
                                        subtitle: Text(
                                          '${ProfileCubit.get(context).userInformation!.phone}',
                                          style: TextStyle(
                                              fontFamily: 'tajawal-light',
                                              fontSize: 14.sp),
                                        ),
                                        title: Text('الرقم'),
                                        leading: Icon(Icons.phone_outlined),
                                      ),
                                      ListTile(
                                        subtitle: Text(
                                          ProfileCubit.get(context)             .userInformation!
                                                      .userType ==
                                                  0
                                              ? 'تاجر'
                                              : 'محل',
                                          style: TextStyle(
                                              fontFamily: 'tajawal-light',
                                              fontSize: 14.sp),
                                        ),
                                        title: Text('النوع'),
                                        leading:
                                            Icon(Icons.merge_type_outlined),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        if(token==null)
                        Container(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Text(
                            noInformation,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'tajawal-ligh',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: SpinKitFadingCircle(color: primaryColor,)),
        );
      },
    );
  }
}
