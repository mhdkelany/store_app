import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/favorites_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../shared/components/constansts/shimmer_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
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
            if(StoreAppCubit.get(context).favoritesModel!.products.length==0)
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
          else   return Scaffold(
              body:Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),

                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height/0.85,
                  children: List.generate(
                      StoreAppCubit.get(context).favoritesModel!.products.length, (index) => buildGridFavoritesProduct(context,StoreAppCubit.get(context).favoritesModel!.products[index],index)
                  ),
                ),
              )
          );
          },
          fallback: (context)=>Center(child: CircularProgressIndicator()),
          condition: StoreAppCubit.get(context).favoritesModel!=null,
        );

      },
    );
  }
  Widget buildGridFavoritesProduct(context,Products data,index)=> InkWell(
    onTap: ()
    {
      StoreAppCubit.get(context).countQuantity=0;
      navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).favoritesModel!.products[index],index: index,));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width*0.95,
        decoration: BoxDecoration(
            color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20)
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              cacheManager: StoreAppCubit.get(context).cacheManager,
              key: UniqueKey(),
              imageUrl:'https://ibrahim-store.com/api/images/${data.image}',
              imageBuilder: (context,imageProvider)=>Image(
                image:imageProvider,
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.30,
                fit: BoxFit.cover,
              ),
              placeholder: (context,url)=>Container(
                child: ShimmerWidget.rectangular( width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.30 ,),
              ),
              errorWidget: (context,url,error)=>Container(
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.30,
                color: Colors.grey[300],
                child: Icon(
                  Icons.refresh_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        child: Text(
                          '${data.name}',
                          style: TextStyle(
                            fontSize: 16.0,

                            color: primaryColor
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        child: Text(
                            '${data.price} د.أ ',
                            style: Theme.of(context).textTheme.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: ()
                    {
                      print(data.idProduct);
                    },
                    icon: Icon(
                        IconBroken.Heart,
                      color: StoreAppCubit.get(context).isFavorite[data.idProduct]!?Colors.red:Colors.grey,
                    )
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
