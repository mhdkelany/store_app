import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_state.dart';
import 'package:store/modules/categoryandfavorite/presentation/widgets/grid_view_favorites.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/glowing_button/glowing_button.dart';
import 'package:store/shared/style/color.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (token != null)
      return BlocConsumer<FavoriteAndCategoryCubit,
          FavoriteAndCategoryState>(
        listener: (context, state) {
          if (state is CateConnectionState) {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                Text('لا يوجد اتصال باﻷنترنت'),
                Colors.amber,
                Duration(seconds: 5)));
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            builder: (context) {
              if (FavoriteAndCategoryCubit.get(context)
                      .favoriteEntity!
                      .products
                      .length ==
                  0)
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
                        Text('القائمة فارغة',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 24.sp, color: Colors.grey[300])),
                      ],
                    ),
                  ),
                );
              else
                return GridViewFavorites();
            },
            fallback: (context) => Center(child: SpinKitFadingCircle(color: primaryColor,)),
            condition:
                FavoriteAndCategoryCubit.get(context).favoriteEntity != null,
          );
        },
      );
    else
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GlowingButton(),
            ),
          ],
        ),
      );
  }
}
