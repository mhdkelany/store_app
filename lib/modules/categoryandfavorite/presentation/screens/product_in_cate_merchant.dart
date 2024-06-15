import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_state.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

class ProductOfCategoryMerchant extends StatelessWidget {
  ProductOfCategoryMerchant({Key? key, required this.idCate}) : super(key: key);
  RefreshController refreshController = RefreshController();
  dynamic idCate;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'المنتجات',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: 'tajawal-light',
                ),
              ),
              titleSpacing: 0.0,
            ),
            body: BlocBuilder<FavoriteAndCategoryCubit,
                FavoriteAndCategoryState>(
              builder: (context, state) {
                if (state is GetProductOfCategorySuccessState) {
                  if (!state.productsOfCategoriesEntity.status) {
                    return Column(
                      children: [
                        ChipsChoice.single(
                          value: FavoriteAndCategoryCubit.get(context).tag2,
                          onChanged: (value) {
                            FavoriteAndCategoryCubit.get(context)
                                .changeTag2(value!);
                            FavoriteAndCategoryCubit.get(context)
                                .getProductOfCategory(
                                ProductOfCategoryParameters(id: FavoriteAndCategoryCubit.get(context)
                                    .subCategoryEntity!
                                    .data[
                                FavoriteAndCategoryCubit.get(context)
                                    .tag]
                                    .id,page: FavoriteAndCategoryCubit.get(context).currentPage),
                                isRefresh: true);
                          },
                          choiceItems: C2Choice.listFrom(
                              source: FavoriteAndCategoryCubit.get(context)
                                  .subCategoryEntity!
                                  .data
                                  .map((e) => e.name)
                                  .toList(),
                              value: (i, v) => i,
                              label: (i, dynamic v) => v),
                          choiceActiveStyle: C2ChoiceStyle(
                              color: Color(0xff36a8f4),
                              borderColor: Color(0xff36a8f4),
                              labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'tajawal-ligh'),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          choiceStyle: C2ChoiceStyle(
                              color: Color(0xff1c1c1c),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'tajawal-ligh')),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/3,
                        ),
                        Text(
                          'عذراً لا يوجد منتجات في هذه الفئة',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'tajawal-light',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  }
                }
                return FavoriteAndCategoryCubit.get(context)
                                .productsOfCategoriesEntity !=
                            null &&
                        FavoriteAndCategoryCubit.get(context)
                                .subCategoryEntity !=
                            null
                    ? Column(
                        children: [
                          ChipsChoice.single(
                            value: FavoriteAndCategoryCubit.get(context).tag2,
                            onChanged: (value) {
                              FavoriteAndCategoryCubit.get(context)
                                  .changeTag2(value!);
                              FavoriteAndCategoryCubit.get(context)
                                  .getProductOfCategory(
                                  ProductOfCategoryParameters(id: FavoriteAndCategoryCubit.get(context)
                                      .subCategoryEntity!
                                      .data[
                                  FavoriteAndCategoryCubit.get(context)
                                      .tag]
                                      .id,page: FavoriteAndCategoryCubit.get(context).currentPage),
                                      isRefresh: true);
                            },
                            choiceItems: C2Choice.listFrom(
                                source: FavoriteAndCategoryCubit.get(context)
                                    .subCategoryEntity!
                                    .data
                                    .map((e) => e.name)
                                    .toList(),
                                value: (i, v) => i,
                                label: (i, dynamic v) => v),
                            choiceActiveStyle: C2ChoiceStyle(
                                color: Color(0xff36a8f4),
                                borderColor: Color(0xff36a8f4),
                                labelStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'tajawal-ligh'),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            choiceStyle: C2ChoiceStyle(
                                color: Color(0xff1c1c1c),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'tajawal-ligh')),
                          ),
                          Expanded(
                            child: SmartRefresher(
                              controller: refreshController,
                              enablePullDown: false,
                              enablePullUp: true,
                              onLoading: () {
                                FavoriteAndCategoryCubit.get(context)
                                    .getProductOfCategory(
                                    ProductOfCategoryParameters(id: FavoriteAndCategoryCubit.get(context)
                                        .subCategoryEntity!
                                        .data[
                                    FavoriteAndCategoryCubit.get(context)
                                        .tag]
                                        .id,page: FavoriteAndCategoryCubit.get(context).currentPage));
                                if (state
                                    is GetProductOfCategorySuccessState) {
                                  refreshController.loadComplete();
                                } else {
                                  refreshController.loadFailed();
                                }
                              },
                              child: GridView.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width /
                                        MediaQuery.of(context).size.height /
                                        0.8,
                                children: List.generate(
                                    FavoriteAndCategoryCubit.get(context)
                                        .productsOfCategoriesEntity!
                                        .products
                                        .length,
                                    (index) => buildItems(
                                        product: FavoriteAndCategoryCubit.get(
                                                context)
                                            .productsOfCategoriesEntity!
                                            .products[index])),
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: SpinKitFadingCircle(
                          color: primaryColor,
                        ),
                      );
              },
            )));
  }

  Widget buildItems({required Product product}) => Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: '$imageUrl${product.image}',
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  height: 80.h,
                  width: 80.w,
                ),
                placeholder: (context, url) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text(
                    'تحميل',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: 'tajawal-light',
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text(
                    'خطأ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: 'tajawal-light',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Text(
                  '${product.name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'tajawal-light',
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
