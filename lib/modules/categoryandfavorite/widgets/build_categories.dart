import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/models/categories_model.dart';
import 'package:store/modules/categoryandfavorite/screens/categories_for_home_screen.dart';
import 'package:store/modules/categoryandfavorite/screens/product_in_cate_merchant.dart';
import 'package:store/shared/components/components.dart';

class BuildCategories extends StatelessWidget {
  BuildCategories(
      {required this.context,
      required this.index,
      required this.data,
         this.isMerchant=false,
      Key? key})
      : super(key: key);
  BuildContext context;
  int index;
  Data data;
  bool isMerchant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isMerchant) {
          CategoriesAndFavoriteCubit.get(context).getProductIncludeCategory(
              data.idCate, isRefresh: true);
          navigateTo(context, ProductOfCategoryMerchant(idCate: data.idCate,));
        }else{
          CategoriesAndFavoriteCubit.get(context).categoryIncludeProduct=null;
          CategoriesAndFavoriteCubit.get(context).getSubOfCategory(id: data.idCate);
          navigateTo(context, CategoriesForHomeScreen(title: '${data.name}',idCate: data.idCate,));
          StoreAppCubit.get(context).selectIndex(index);

        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
                height: 110.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  fadeOutDuration: Duration(milliseconds: 800),
                  imageUrl: '${data.image}',
                  imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (context, url) => Container(
                    height: 110.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.grey[200]
                    ),
                    child: Center(
                      child: Text(
                        'تحميل',
                        style: TextStyle(color: Colors.black, fontSize: 10.sp),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 110.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.grey[300]
                    ),
                    child: Center(
                      child: Text(
                        'خطأ',
                        style: TextStyle(color: Colors.black, fontSize: 10.sp),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                )),
            SizedBox(
              height: 10.h,
            ),
            buildText(
                text: '${data.name}',
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontFamily: 'tajawal-light',
                ),
                lines: 1,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
