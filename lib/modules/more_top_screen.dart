import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/order/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

class MoreTopScreen extends StatelessWidget {
  const MoreTopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
              appBar: AppBar(
                title: Text('المنتجات'),
                titleSpacing: 0,
              ),
              body: ConditionalBuilder(
                builder: (context)=> ListView.separated(
                    itemBuilder: (context,index)=>InkWell(
                      onTap: ()
                      {
                        navigateTo(context, ProductDetailsScreen(model:StoreAppCubit.get(context).homeModel!.top[index],index: index,));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                cacheManager: StoreAppCubit.get(context).cacheManager,
                                key: UniqueKey(),
                                imageUrl:'https://ibrahim-store.com/api/images/${StoreAppCubit.get(context).homeModel!.top[index].image}',
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  width: MediaQuery.of(context).size.width*0.19,
                                  height: MediaQuery.of(context).size.height*0.10,
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
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      '${StoreAppCubit.get(context).homeModel!.top[index].name}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'tajawal-light'
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    width: MediaQuery.of(context).size.width*0.25,
                                  ),
                                  Container(
                                    child: Text(
                                      '${StoreAppCubit.get(context).homeModel!.top[index].shortDescription}',
                                      style: Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    width: MediaQuery.of(context).size.width*0.20,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: StoreAppCubit.get(context).isFavorite[StoreAppCubit.get(context).homeModel!.top[index].idProduct]!?Colors.red[50]:Colors.grey[300]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 18,
                                    color: StoreAppCubit.get(context).isFavorite[StoreAppCubit.get(context).homeModel!.top[index].idProduct]!?Colors.red:Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                '${StoreAppCubit.get(context).homeModel!.top[index].price}د.أ',
                                style: TextStyle(
                                    fontFamily: 'tajawal-bold',
                                    color: primaryColor,
                                    fontSize: 18
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context,index)=>SizedBox(height: 2,),
                    itemCount: StoreAppCubit.get(context).homeModel!.top.length
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
                condition: StoreAppCubit.get(context).homeModel!=null,
              )

          );
        },
      ),
    );
  }
}
