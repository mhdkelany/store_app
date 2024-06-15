import 'package:flutter/material.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/home/home_cubit.dart';

import 'build_categories.dart';

class BuildGridForCategories extends StatelessWidget {
   BuildGridForCategories({required this.context,required this.isMerchant,Key? key}) : super(key: key);
  BuildContext context;
  bool isMerchant;
  @override
  Widget build(BuildContext context) {
    return GridView.count(

      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height/0.48,
      children: List.generate(
          FavoriteAndCategoryCubit.get(context).categoryEntity!.cateData.length, (index) => BuildCategories(context:context,index:index,data:FavoriteAndCategoryCubit.get(context).categoryEntity!.cateData[index],isMerchant: isMerchant,)
      ),
    );
  }
}
