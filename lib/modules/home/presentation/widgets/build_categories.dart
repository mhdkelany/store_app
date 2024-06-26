import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/category_entity.dart';
import 'package:store/modules/categoryandfavorite/models/categories_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/screens/categories_for_home_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

class BuildCategories extends StatelessWidget {
   BuildCategories({required this.context,required this.model,required this.index,Key? key}) : super(key: key);
  BuildContext context;
  CategoryData model;
  int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FavoriteAndCategoryCubit.get(context).productsOfCategoriesEntity=null;
        FavoriteAndCategoryCubit.get(context).getSubCate( model.idCate);
        navigateTo(context, CategoriesForHomeScreen(title: '${model.name}',idCate: model.idCate,));
        StoreAppCubit.get(context).selectIndex(index);
        print(model.idCate);
      },
      child: Container(
        width: MediaQuery.of(context).size.width/5,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [

                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: primaryColor,
                    ),
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl:'${model.image}',
                  imageBuilder: (context,imageProvider)=>CircleAvatar(
                    radius: 30,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context,url)=>CircleAvatar(
                    radius: 30,
                    child: ShimmerWidget.circular(height: 70,width: 70,
                    ),
                  ),
                  errorWidget: (context,url,error)=>CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.refresh_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${model.name}',
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
