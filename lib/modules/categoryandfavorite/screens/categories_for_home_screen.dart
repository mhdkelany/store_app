import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/widgets/build_list_of_products.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

Map<String, bool>? inTheCart = {};

// ignore: must_be_immutable
class CategoriesForHomeScreen extends StatelessWidget {
  CategoriesForHomeScreen({required this.title, this.idCate, Key? key})
      : super(key: key);
  String title;
  dynamic idCate;
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
          BlocBuilder<CategoriesAndFavoriteCubit, CategoriesAndFavoriteState>(
        builder: (context, state) {
          if (CategoriesAndFavoriteCubit.get(context).subCategoryModel !=
                  null &&
              CategoriesAndFavoriteCubit.get(context).categoryIncludeProduct !=
                  null)
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                title: buildText(
                    text: '$title',
                    textStyle: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
              body: Column(
                children: [
                  ChipsChoice.single(
                    value: CategoriesAndFavoriteCubit.get(context).tag,
                    onChanged: (value) {
                      CategoriesAndFavoriteCubit.get(context).changeTag(value!);
                      CategoriesAndFavoriteCubit.get(context)
                          .getProductIncludeCategory(
                              CategoriesAndFavoriteCubit.get(context)
                                  .subCategoryModel!
                                  .dataOfSubCategory[
                                      CategoriesAndFavoriteCubit.get(context)
                                          .tag]
                                  .id,
                              isRefresh: true);
                    },
                    choiceItems: C2Choice.listFrom(
                        source: CategoriesAndFavoriteCubit.get(context)
                            .subCategoryModel!
                            .dataOfSubCategory
                            .map((e) => e.name)
                            .toList(),
                        value: (i, v) => i,
                        label: (i, dynamic v) => v),
                    choiceActiveStyle: C2ChoiceStyle(
                        color: Color(0xff36a8f4),
                        borderColor: Color(0xff36a8f4),
                        labelStyle: TextStyle(
                            fontSize: 12.sp, fontFamily: 'tajawal-ligh'),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    choiceStyle: C2ChoiceStyle(
                        color: Color(0xff1c1c1c),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        labelStyle: TextStyle(
                            fontSize: 12.sp, fontFamily: 'tajawal-ligh')),
                  ),
                  Expanded(
                    child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      controller: refreshController,
                      onLoading: () {
                        CategoriesAndFavoriteCubit.get(context)
                            .getProductIncludeCategory(
                                CategoriesAndFavoriteCubit.get(context)
                                    .subCategoryModel!
                                    .dataOfSubCategory[
                                        CategoriesAndFavoriteCubit.get(context)
                                            .tag]
                                    .id);
                        if (state is getProductIncludeCategorySuccessState) {
                          refreshController.loadComplete();
                        } else {
                          refreshController.loadFailed();
                        }
                      },
                      child: ListView.separated(
                          itemBuilder: (context, index) => BuildListOfProducts(
                              index: index, context: context),
                          separatorBuilder: (context, index) => Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey[300],
                              ),
                          itemCount: CategoriesAndFavoriteCubit.get(context)
                              .categoryIncludeProduct!
                              .products
                              .length),
                    ),
                  ),
                ],
              ),
            );
          else if(!CategoriesAndFavoriteCubit.get(context).subCategoryModel!.status)
            return Scaffold(
              body: Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'tajawal-ligh',
                    fontSize: 26.sp,
                  ),
                ),
              ),
            );
          else
            return Scaffold(
              body: Center(
                child: SpinKitFadingCircle(
                  color: primaryColor,
                ),
              ),
            );
        },
      ),
    );
  }
}
