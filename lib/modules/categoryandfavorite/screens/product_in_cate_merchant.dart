import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

class ProductOfCategoryMerchant extends StatelessWidget {
   ProductOfCategoryMerchant({Key? key,required this.idCate}) : super(key: key);
RefreshController refreshController=RefreshController();
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
          body: CategoriesAndFavoriteCubit.get(context)
                      .categoryIncludeProduct !=
                  null
              ? BlocBuilder<CategoriesAndFavoriteCubit,
                  CategoriesAndFavoriteState>(
                  builder: (context, state) {
                    return SmartRefresher(
                      controller: refreshController,
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: (){
                        CategoriesAndFavoriteCubit.get(context).getProductIncludeCategory(idCate);
                        if(state is getProductIncludeCategorySuccessState)
                        {
                          refreshController.loadComplete();
                        }
                        else{
                          refreshController.loadFailed();
                        }
                      },
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height /
                            0.8,
                        children: List.generate(
                            CategoriesAndFavoriteCubit.get(context)
                                .categoryIncludeProduct!
                                .products
                                .length,
                            (index) => buildItems(
                                product: CategoriesAndFavoriteCubit.get(context)
                                    .categoryIncludeProduct!
                                    .products[index])),
                      ),
                    );
                  },
                )
              : Center(
                  child: SpinKitFadingCircle(
                    color: primaryColor,
                  ),
                )),
    );
  }

  Widget buildItems({required Products product}) => Card(
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
              Text(
                '${product.name}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontFamily: 'tajawal-light',
                ),
              )
            ],
          ),
        ),
      );
}
