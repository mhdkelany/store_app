import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/order/presentation/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

class MoreProductsScreen extends StatelessWidget {
  MoreProductsScreen({Key? key}) : super(key: key);
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text(
                  'المنتجات',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'tajawal-light',
                  ),
                ),
                titleSpacing: 0,
              ),
              body: ConditionalBuilder(
                builder: (context) => SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  onLoading: () {
                    if (token == null) {
                      HomeCubit.get(context).getHomeWithoutToken();
                      if (state is GetHomeWithoutTokenSuccessState) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                      }
                    } else {
                      HomeCubit.get(context).getHome();
                      if (state is StoreHomeSuccessState) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                      }
                    }
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  ProductDetailsScreen(
                                    model: HomeCubit.get(context)
                                        .homeModel!
                                        .allProducts[index],
                                    index: index,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 13),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      cacheManager: StoreAppCubit.get(context)
                                          .cacheManager,
                                      key: UniqueKey(),
                                      imageUrl:
                                          'https://ibrahim-store.com/api2/images/${HomeCubit.get(context).homeModel!.allProducts[index].image}',
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        fit: BoxFit.cover,
                                      ),
                                      placeholder: (context, url) => Container(
                                        child: ShimmerWidget.rectangular(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        child: Icon(
                                          Icons.refresh_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${HomeCubit.get(context).homeModel!.allProducts[index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'tajawal-light',
                                                fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            '${HomeCubit.get(context).homeModel!.allProducts[index].shortDescription}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: Text(
                                      '${double.tryParse(HomeCubit.get(context).homeModel!.allProducts[index].price)!.toStringAsFixed(2)}د.أ',
                                      style: TextStyle(
                                          fontFamily: 'tajawal-bold',
                                          color: primaryColor,
                                          fontSize: 18.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 2.h,
                          ),
                      itemCount:
                          HomeCubit.get(context).homeModel!.allProducts.length),
                ),
                condition: HomeCubit.get(context).homeModel != null,
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        },
      ),
    );
  }
}
