import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

class BuildNewProducts extends StatelessWidget {
   BuildNewProducts({required this.context,required this.products,required this.index,Key? key}) : super(key: key);
  BuildContext context;
  Products products;
  int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).homeModel!.products[index],index: index,));
        StoreAppCubit.get(context).countQuantity=0;
        print(products.inFavorites);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
              )
          ),
          elevation: 3,
          child: Column(
            children: [
              CachedNetworkImage(
                cacheManager: StoreAppCubit.get(context).cacheManager,
                key: UniqueKey(),
                imageUrl:'https://ibrahim-store.com/api/images/${products.image}',
                imageBuilder: (context,imageProvider)=>Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:imageProvider
                      )
                  ),
                  clipBehavior: Clip.antiAlias,
                ),
                fit: BoxFit.cover,
                placeholder: (context,url)=>Container(
                  child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.3,),
                ),
                errorWidget: (context,url,error)=>Container(
                  width: double.infinity,
                  height:MediaQuery.of(context).size.height*0.3 ,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.refresh_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${products.name}',
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '${products.price}د.أ ',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.sp
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),

                    IconButton(onPressed: ()
                    {
                      StoreAppCubit.get(context).changeFavorites(products.idProduct!);
                    },
                        icon: Icon(
                          Icons.favorite,
                          color: StoreAppCubit.get(context).isFavorite[products.idProduct]!?Colors.red:Colors.grey,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
