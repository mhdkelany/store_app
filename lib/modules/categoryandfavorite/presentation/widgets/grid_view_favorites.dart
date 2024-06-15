import 'package:flutter/material.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/widgets/build_grid_favorites_products.dart';

class GridViewFavorites extends StatelessWidget {
  const GridViewFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
          ),

          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height/0.88,
            children: List.generate(
                FavoriteAndCategoryCubit.get(context).favoriteEntity!.products.length, (index) => BuildGridFavoritesProducts(context:context,data:FavoriteAndCategoryCubit.get(context).favoriteEntity!.products[index],index:index)
            ),
          ),
        )
    );
  }
}
