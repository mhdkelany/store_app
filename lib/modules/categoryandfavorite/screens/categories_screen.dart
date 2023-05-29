import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/widgets/build_grid_for_categories.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';


class CategoriesScreen extends StatelessWidget {

  bool isHome = true;
  bool isMerchant;

  CategoriesScreen({required this.isHome,required this.isMerchant,Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesAndFavoriteCubit, CategoriesAndFavoriteState>(
      listener: (context, state) {
        if (state is CheckSocketState) {
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              Text('لا يوجد اتصال باﻷنترنت'),
              Colors.amber,
              Duration(seconds: 5)));
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ConditionalBuilder(
            builder: (context) => Scaffold(
                appBar: isHome ? null : AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BuildGridForCategories(context: context,isMerchant: isMerchant),
                ),),
            fallback: (context) => Center(child: SpinKitFadingCircle(color: primaryColor,)),
            condition: CategoriesAndFavoriteCubit.get(context).categoriesModel != null
          ),
        );
      },
    );
  }
}
