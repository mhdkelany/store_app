import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_state.dart';
import 'package:store/modules/manage_product/presentation/screens/add_product_screen.dart';
import 'package:store/modules/categoryandfavorite/presentation/widgets/build_grid_for_categories.dart';
import 'package:store/modules/manage_product/presentation/screens/update_product_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

import '../../../../shared/components/constansts/shimmer_widget.dart';

var textController = TextEditingController();

class MainMerchantScreen extends StatelessWidget {
  MainMerchantScreen({Key? key}) : super(key: key);
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageProductCubit, ManageProductState>(
      listener: (context, state) {
        if (state is GetProductForUserSuccessState)
          ManageProductCubit.get(context).getNotification(context);
        if (state is GetProductForUserSuccessState) {
          if (state.ownProductEntity.status != null) if (!state
              .ownProductEntity.status) if (state
                  .ownProductEntity.message ==
              'No active user') {
            logOut(context);
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                Text('حسابك محظور مؤقتأ'), Colors.amber, Duration(seconds: 3)));
          }
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(
            builder: (BuildContext context) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(
                        StoreAppCubit.get(context).isOpenDrawer ? 40 : 0.0)),
                transform: Matrix4.translationValues(
                    StoreAppCubit.get(context).xOffset,
                    StoreAppCubit.get(context).yOffset,
                    0)
                  ..scale(StoreAppCubit.get(context).scaleFactor),
                duration: Duration(milliseconds: 250),
                child: Scaffold(
                  backgroundColor: Colors.grey[200],
                  bottomNavigationBar: BottomAppBar(
                    surfaceTintColor: Colors.white,
                    shape: CircularNotchedRectangle(),
                    notchMargin: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              StoreAppCubit.get(context)
                                  .changeBottomForMerchant(index: 0);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  color: StoreAppCubit.get(context)
                                              .selectedIndexForMerchant ==
                                          0
                                      ? fourColor
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'منتجاتي',
                                  style: TextStyle(
                                      color: StoreAppCubit.get(context)
                                                  .selectedIndexForMerchant ==
                                              0
                                          ? fourColor
                                          : Colors.grey,
                                      fontSize: 16.sp),
                                ),
                                // Spacer(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              StoreAppCubit.get(context)
                                  .changeBottomForMerchant(index: 1);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  color: StoreAppCubit.get(context)
                                              .selectedIndexForMerchant ==
                                          1
                                      ? fourColor
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'الفئات',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: StoreAppCubit.get(context)
                                                  .selectedIndexForMerchant ==
                                              1
                                          ? fourColor
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  floatingActionButtonAnimator:
                      FloatingActionButtonAnimator.scaling,
                  floatingActionButton: FloatingActionButton(
                    shape: CircleBorder(),
                    backgroundColor: fourColor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      navigateTo(
                          context,
                          AddProductScreen(
                            isFromDrawer: false,
                          ));
                    },
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  body: Column(
                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      Row(
                        children: [
                          StoreAppCubit.get(context).isOpenDrawer
                              ? IconButton(
                                  onPressed: () {
                                    StoreAppCubit.get(context).changeDrawer();
                                  },
                                  icon: Icon(Icons.arrow_back_ios))
                              : IconButton(
                                  onPressed: () {
                                    StoreAppCubit.get(context).changeDrawer();
                                    ManageProductCubit.get(context).notification =
                                        [];
                                    ManageProductCubit.get(context)
                                        .getNotification(context);
                                  },
                                  icon: Icon(Icons.menu)),
                          SizedBox(
                            width: 15,
                          ),
                          if (!ManageProductCubit.get(context).isSearching)
                            Text(
                              StoreAppCubit.get(context)
                                          .selectedIndexForMerchant ==
                                      0
                                  ? 'منتجاتي'
                                  : 'الفئات',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontFamily: 'tajawal-light'),
                            ),
                          if (ManageProductCubit.get(context).isSearching)
                            searchTextField(context),
                          Spacer(),
                          if (StoreAppCubit.get(context)
                                  .selectedIndexForMerchant ==
                              0)
                            ManageProductCubit.get(context).appBar(context)
                        ],
                      ),
                      if (StoreAppCubit.get(context).selectedIndexForMerchant ==
                          0)
                        ConditionalBuilder(
                          builder: (context) {
                            if (ManageProductCubit.get(context)
                                    .productForUserModel!
                                    .productForUser
                                    .length ==
                                0)
                              return Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  'لا يوجد منتجات لعرضها',
                                  style: TextStyle(
                                      fontSize: 26, color: Colors.grey[300]),
                                ),
                              );
                            return Expanded(
                              child: SmartRefresher(
                                physics: BouncingScrollPhysics(),
                                enablePullUp: true,
                                controller: refreshController,
                                enablePullDown: false,
                                onLoading: () {
                                  ManageProductCubit.get(context)
                                      .getProductForUser(context);
                                  if (state is GetProductForUserSuccessState) {
                                    refreshController.loadComplete();
                                  } else {
                                    refreshController.loadFailed();
                                  }
                                },
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              UpdateProductScreen(
                                                products: ManageProductCubit.get(
                                                            context)
                                                        .textEditingController
                                                        .text
                                                        .isEmpty
                                                    ? ManageProductCubit.get(
                                                            context)
                                                        .productForUserModel!
                                                        .productForUser[index]
                                                    : ManageProductCubit.get(context)
                                                        .searchForUser[index],
                                              ));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.29,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CachedNetworkImage(
                                                  imageUrl: ManageProductCubit.get(
                                                              context)
                                                          .textEditingController
                                                          .text
                                                          .isEmpty
                                                      ? '$imageUrl${ManageProductCubit.get(context).productForUserModel!.productForUser[index].image}'
                                                      : '$imageUrl${ManageProductCubit.get(context).searchForUser[index].image}',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Image(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.30,
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    // margin: EdgeInsets.only(top: 5),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: ShimmerWidget
                                                        .rectangular(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.19,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.30,
                                                    color: Colors.grey[300],
                                                    child: Icon(
                                                      Icons.refresh_outlined,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 20, bottom: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ManageProductCubit.get(
                                                                    context)
                                                                .textEditingController
                                                                .text
                                                                .isEmpty
                                                            ? '${ManageProductCubit.get(context).productForUserModel!.productForUser[index].name}'
                                                            : '${ManageProductCubit.get(context).searchForUser[index].name}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'tajawal-light',
                                                          fontSize: 16.sp,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        ManageProductCubit.get(
                                                                    context)
                                                                .textEditingController
                                                                .text
                                                                .isEmpty
                                                            ? '${ManageProductCubit.get(context).productForUserModel!.productForUser[index].price.toStringAsFixed(2)}'
                                                            : '${ManageProductCubit.get(context).searchForUser[index].price.toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                          color: fourColor,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        ManageProductCubit.get(
                                                                    context)
                                                                .textEditingController
                                                                .text
                                                                .isEmpty
                                                            ? '${ManageProductCubit.get(context).productForUserModel!.productForUser[index].longDescription}'
                                                            : '${ManageProductCubit.get(context).searchForUser[index].longDescription}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'تعديل',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'tajawal-light'),
                                                              ),
                                                              SizedBox(
                                                                width: 3,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: Colors
                                                                    .grey[300],
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 15,
                                        ),
                                    itemCount: ManageProductCubit.get(context)
                                            .textEditingController
                                            .text
                                            .isEmpty
                                        ? ManageProductCubit.get(context)
                                            .productForUserModel!
                                            .productForUser
                                            .length
                                        : ManageProductCubit.get(context)
                                            .searchForUser
                                            .length),
                              ),
                            );
                          },
                          fallback: (context) => Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: SpinKitFadingCircle(
                              color: primaryColor,
                            ),
                          ),
                          condition: state != GetProductForUserLoadingState &&
                              ManageProductCubit.get(context)
                                      .productForUserModel !=
                                  null,
                        ),
                      if (StoreAppCubit.get(context).selectedIndexForMerchant ==
                          1)
                        Expanded(
                            child: BuildGridForCategories(
                          context: context,
                          isMerchant: true,
                        )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget searchTextField(BuildContext context) => Expanded(
        child: TextField(
          controller: ManageProductCubit.get(context).textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'بحث',
          ),
          onChanged: (value) {
            ManageProductCubit.get(context).searchOnProductOfUser(value);
          },
        ),
      );
}
