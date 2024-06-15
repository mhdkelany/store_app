import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/manage_product/presentation/screens/uploade_wish_screen.dart';
import 'package:store/modules/order/presentation/screens/cart_screen.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
import 'package:store/modules/profile/presentation/screens/edit_profile_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../modules/manage_product/presentation/screens/search_screen.dart';

class LayoutScreen extends StatelessWidget {
  final keyOne = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {

          if (state is OpenWishScreenState)
            navigateTo(context, UploadWishScreen());
          if (state is ConnectionErrorState) {
            buildDialog(context, state);
          }
          if (state is ConnectionSuccessState) {
            ProfileCubit.get(context).getProfile(NoParameters(),context);
            FavoriteAndCategoryCubit.get(context).getCategories(NoParameters());
          }
          if (state is CheckSocketState) {
            buildDialog(context, state);
          }
        },
        builder: (context, state) {
          return BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () => onBack(context),
                child: Scaffold(
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      child: GNav(
                        tabs: [
                          GButton(
                            icon: Icons.home_outlined,
                            text: 'الرئيسية',
                          ),
                          GButton(
                            icon: IconBroken.Category,
                            text: 'الاقسام',
                          ),
                          GButton(
                            icon: IconBroken.Paper_Upload,
                            text: 'الأمنيات',
                          ),
                          GButton(
                            icon: Icons.favorite_outline,
                            text: 'المفضلة',
                          ),
                          GButton(
                            icon: Icons.person_outline_sharp,
                            text: 'حسابي',
                          ),
                        ],
                        tabBackgroundColor: secondColor,
                        padding: EdgeInsets.all(8),
                        activeColor: Colors.white,
                        textStyle:
                            TextStyle(fontSize: 14.sp, color: Colors.white),
                        selectedIndex: StoreAppCubit.get(context).currentIndex,
                        onTabChange: (value) {
                          StoreAppCubit.get(context)
                              .changeBottomNav(value, context);
                        },
                      ),
                    ),
                  ),
                  body: SafeArea(
                    child: NestedScrollView(
                      floatHeaderSlivers: true,
                      headerSliverBuilder:(BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: StoreAppCubit.get(context).currentIndex==4?primaryColor:Colors.white
                        ),
                        floating: true,
                        snap: true,
                        leading: IconButton(
                          icon: Icon(Icons.menu_sharp),
                          onPressed: () {
                            ZoomDrawer.of(context)!.toggle();
                          },
                        ),
                        actions: [
                          if (StoreAppCubit.get(context).currentIndex == 4 &&
                              token != '')
                            IconButton(
                              onPressed: () {
                                navigateTo(context, EditProfileScreen());
                              },
                              icon: Icon(
                                Icons.edit,
                              ),
                            ),
                          IconButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SearchScreen(),
                                );
                              },
                              icon: Icon(IconBroken.Search)),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      navigateTo(context, CartScreen());
                                      OrderCubit.get(context).priceTotal = 0.0;
                                      OrderCubit.get(context).getTotalBill();
                                    },
                                    icon: Icon(IconBroken.Buy)),
                                if (OrderCubit.get(context).product.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor:
                                          Colors.red.withOpacity(0.9),
                                      child: Text(
                                        '${OrderCubit.get(context).i}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                        backgroundColor:
                            StoreAppCubit.get(context).currentIndex == 4
                                ? primaryColor
                                : Colors.white,
                      ),
                    
                    ],
                      body: StoreAppCubit.get(context)
                          .screens[StoreAppCubit.get(context).currentIndex],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> onBack(context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: Text('اغلاق التطبيق'),
                content: Text(OrderCubit.get(context).product.length > 0
                    ? 'سوف يتم حذف عناصر السلة'
                    : 'هل تريد اغلاق التطبيق؟'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('لا')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('نعم')),
                ],
              ),
            ));
    return exitApp ?? false;
  }
}
