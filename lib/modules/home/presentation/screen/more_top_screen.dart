import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/order/presentation/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

class MoreTopScreen extends StatelessWidget {
  const MoreTopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text(
                  'المنتجات',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'tajawal-light',
                  ),
                ),
                titleSpacing: 0,
              ),
              body: ConditionalBuilder(
                builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            navigateTo(
                                context,
                                ProductDetailsScreen(
                                  model: HomeCubit.get(context)
                                      .homeModel!
                                      .top[index],
                                  index: index,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    cacheManager:
                                        StoreAppCubit.get(context).cacheManager,
                                    key: UniqueKey(),
                                    imageUrl:
                                        'https://ibrahim-store.com/api/images/${HomeCubit.get(context).homeModel!.top[index].image}',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image(
                                        image: imageProvider,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      child: ShimmerWidget.rectangular(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300],
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.19,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${HomeCubit.get(context).homeModel!.top[index].name}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'tajawal-light',
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          '${HomeCubit.get(context).homeModel!.top[index].shortDescription}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    '${double.tryParse(HomeCubit.get(context).homeModel!.top[index].price)!.toStringAsFixed(2)}د.أ',
                                    style: TextStyle(
                                        fontFamily: 'tajawal-bold',
                                        color: primaryColor,
                                        fontSize: 18.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 2,
                        ),
                    itemCount: HomeCubit.get(context).homeModel!.top.length),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                condition: HomeCubit.get(context).homeModel != null,
              ));
        },
      ),
    );
  }
}
