import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

class BuildTopSailing extends StatelessWidget {
  BuildTopSailing({required this.context,required this.products,required this.index,Key? key}) : super(key: key);
  BuildContext context;
  Products products;
  int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        print(index);
        navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).homeModel!.top[index],index: index,));
        StoreAppCubit.get(context).countQuantity=0;
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.6,
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CachedNetworkImage(
                  cacheManager: StoreAppCubit.get(context).cacheManager,
                  key: UniqueKey(),
                  imageUrl:'https://ibrahim-store.com/api/images/${products.image}',
                  imageBuilder: (context,imageProvider)=>Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image:imageProvider,
                      width: MediaQuery.of(context).size.width*0.19,
                      height: MediaQuery.of(context).size.height*0.10,
                      fit: BoxFit.cover,
                    ),
                  ),
                  placeholder: (context,url)=>Container(
                    child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height*0.10,width:MediaQuery.of(context).size.width*0.19 ,),
                  ),
                  errorWidget: (context,url,error)=>Container(
                    width: MediaQuery.of(context).size.width*0.19,
                    height: MediaQuery.of(context).size.height*0.10,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.refresh_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 5,
              ),
              Container(
                height: 77,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        child: Text(
                          '${products.name} ' ,
                          style: Theme.of(context).textTheme.subtitle1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.33,
                      child: Text(
                        '${products.shortDescription}',
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width*0.30,
                      child: Text(
                        '${products.price} د.أ ',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 16
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
