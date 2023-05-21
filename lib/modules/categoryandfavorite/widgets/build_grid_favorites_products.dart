import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/icon_broken.dart';

class BuildGridFavoritesProducts extends StatelessWidget {
  BuildGridFavoritesProducts(
      {required this.context,
      required this.data,
      required this.index,
      Key? key})
      : super(key: key);
 final BuildContext context;
 final Products data;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OrderCubit.get(context).countQuantity = 0;
        navigateTo(
            context,
            ProductDetailsScreen(
              model: CategoriesAndFavoriteCubit.get(context).favoritesModel!.products[index],
              index: index,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                cacheManager: StoreAppCubit.get(context).cacheManager,
                key: UniqueKey(),
                imageUrl: '$imageUrl${data.image}',
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.30,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => Container(
                  child: ShimmerWidget.rectangular(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.30,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.30,
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
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            '${data.name}',
                            style:
                                TextStyle(fontSize: 16.0, color: primaryColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
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
                      onPressed: () {
                        print(data.idProduct);
                      },
                      icon: Icon(
                        IconBroken.Heart,
                        color: StoreAppCubit.get(context)
                                .isFavorite[data.idProduct]!
                            ? Colors.red
                            : Colors.grey,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
