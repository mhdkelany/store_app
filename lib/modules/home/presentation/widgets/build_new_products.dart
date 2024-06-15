import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/presentation/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

class BuildNewProducts extends StatelessWidget {
   BuildNewProducts({required this.context,required this.products,required this.index,Key? key}) : super(key: key);
  BuildContext context;
  Product products;
  int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, ProductDetailsScreen(model: HomeCubit.get(context).homeModel!.allProducts[index],index: index,));
        OrderCubit.get(context).countQuantity=0;
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
                imageUrl:'$imageUrl${products.image}',
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
                            '${double.tryParse(products.price)!.toStringAsFixed(2)}د.أ ',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 14.sp
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    ),
                    if(token!=null)
                    IconButton(onPressed: ()
                    {
                      HomeCubit.get(context).changeFavorites(products.idProduct!);
                    },
                        icon: Icon(
                          Icons.favorite,
                          color: HomeCubit.get(context).isFavorite[products.idProduct]!?Colors.red:Colors.grey,
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
