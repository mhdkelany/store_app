import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/widgets/grid_view_favorites.dart';
import 'package:store/shared/components/components.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesAndFavoriteCubit,CategoriesAndFavoriteState>(
      listener: (context, state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
          }
      },
      builder: (context, state)
      {

        return ConditionalBuilder(
          builder: (context){
            if(CategoriesAndFavoriteCubit.get(context).favoritesModel!.products.length==0)
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 170,
                        Icons.error_outline_sharp,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'القائمة فارغة',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 24,
                              color: Colors.grey[300]
                          )
                      ),
                    ],
                  ),
                ),
              );
          else   return GridViewFavorites();
          },
          fallback: (context)=>Center(child: CircularProgressIndicator()),
          condition: CategoriesAndFavoriteCubit.get(context).favoritesModel!=null,
        );

      },
    );
  }
}
