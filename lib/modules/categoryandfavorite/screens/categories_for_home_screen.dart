
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/widgets/build_list_of_products.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';
Map<String,bool> inTheCart={};
// ignore: must_be_immutable
class CategoriesForHomeScreen extends StatelessWidget {
  CategoriesForHomeScreen({required this.title, Key? key}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<CategoriesAndFavoriteCubit, CategoriesAndFavoriteState>(
        builder: (context, state) {
          if (CategoriesAndFavoriteCubit.get(context).categoryIncludeProduct != null)
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: buildText(
                    text: '$title',
                    textStyle: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) =>
                      BuildListOfProducts(index:index,context: context),
                  separatorBuilder: (context, index) => Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                  itemCount: CategoriesAndFavoriteCubit.get(context)
                      .categoryIncludeProduct!
                      .products
                      .length),
            );
          else
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        },
      ),
    );
  }

}
