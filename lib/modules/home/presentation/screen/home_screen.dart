
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/home/domain/entity/get_home_entity.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/home/presentation/widgets/build_new_products.dart';
import 'package:store/modules/home/presentation/widgets/build_top_sailing.dart';
import 'package:store/modules/home/presentation/screen/more_product_screen.dart';
import 'package:store/modules/home/presentation/screen/more_top_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

import '../widgets/build_categories.dart';

class HomeScreen extends StatelessWidget {
  final RefreshController refreshController =
      RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is StoreHomeErrorState&&state is StoreCategoriesErrorState)
          {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(state.error),
                ));
          }
        if (state is ConnectFalseState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('no connection'),
                    content: Text('please check'),
                    actions: [TextButton(onPressed: () {}, child: Text('ok'))],
                  ));
        }
        if (state is StoreHomeSuccessState) {
          if (state.homeEntity.statusProfile != null) {
            if (!state.homeEntity.statusProfile!) {
              logOut(context);
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                  Text('نم حظرك مؤقتاً'),
                  Colors.amber,
                  Duration(seconds: 5)));
            }
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              FavoriteAndCategoryCubit.get(context).categoryEntity != null,
          builder: (context) {
            if (HomeCubit.get(context).homeModel!.allProducts.length == 0) {
              return Center(
                child: Text(
                  'لا يوجد اي منتجات',
                  style: TextStyle(fontSize: 26, color: Colors.grey[300]),
                ),
              );
            } else
              return SmartRefresher(
                enablePullUp: true,
                  physics: BouncingScrollPhysics(),
                  controller: refreshController,
                  onRefresh: (){
                  try {
                    HomeCubit.get(context).getHomeWithoutToken(isRefresh: true);
                    if (state is GetHomeWithoutTokenSuccessState) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  }catch(e){
                    refreshController.refreshFailed();
                  }
                  },
                  onLoading: (){
                  try {
                    if (token == null) {
                      HomeCubit.get(context).getHomeWithoutToken();
                      if (state is GetHomeWithoutTokenSuccessState) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                      }
                    }
                    else {
                      HomeCubit.get(context).getHome();
                      if (state is StoreHomeSuccessState) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                      }
                    }
                  }catch(e){
                    refreshController.loadFailed();
                  }
                  },
                  child: buildProduct(
                      context, HomeCubit.get(context).homeModel!, state));
          },
          fallback: (context) => SpinKitFadingCircle(
            color: primaryColor,
          ),
        );
      },
    );
  }

  Widget buildProduct(context, HomeEntity model, HomeState state) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.banner
                  .map((e) => CachedNetworkImage(
                        /*cacheManager: HomeCubit.get(context).cacheManager,*/
                        key: UniqueKey(),
                        imageUrl: '${e.image}',
                        imageBuilder: (context, imageProvider) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              clipBehavior: Clip.antiAlias,
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        ),
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            clipBehavior: Clip.antiAlias,
                            child: ShimmerWidget.rectangular(height: 300),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          width: double.infinity,
                          child: Icon(Icons.refresh_outlined),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  viewportFraction: 0.9,
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            ),

            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'الأقسام',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 125.32.h,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => BuildCategories(
                      context: context,
                      model: FavoriteAndCategoryCubit.get(context)
                          .categoryEntity!
                          .cateData[index],
                      index: index),
                  separatorBuilder: (context, index) => SizedBox(width: 15.0),
                  itemCount: FavoriteAndCategoryCubit.get(context)
                      .categoryEntity!
                      .cateData
                      .length),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'الأكثر مبيعا',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: TextButton(
                        onPressed: () {
                          navigateTo(context, MoreTopScreen());
                        },
                        child: Text(
                          'المزيد',
                          style: TextStyle(color: Colors.deepOrange),
                        )),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => BuildTopSailing(
                      context: context,
                      products:
                          HomeCubit.get(context).homeModel!.top[index],
                      index: index),
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  itemCount:
                      HomeCubit.get(context).homeModel!.top.length >= 10
                          ? 10
                          : HomeCubit.get(context).homeModel!.top.length),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'المنتجات',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        navigateTo(context, MoreProductsScreen());
                      },
                      child: Text(
                        'المزيد',
                        style: TextStyle(color: Colors.deepOrange),
                      ))
                ],
              ),
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) => BuildNewProducts(
                  context: context,
                  products:
                      HomeCubit.get(context).homeModel!.allProducts[index],
                  index: index),
              itemCount: HomeCubit.get(context).homeModel!.allProducts.length,
            ),
          ],
        ),
      );

  buildDialog(context, StoreAppStates state) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('No Inernet Connection'),
            content: Text('Turn on the WiFi or Mobil Data'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (state is ConnectionErrorState) {
                      buildDialog(context, state);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Ok'))
            ],
          ));
}
