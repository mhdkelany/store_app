import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/home_model.dart';
import 'package:store/modules/order/screens/product_details_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../shared/components/constansts/shimmer_widget.dart';
import '../shared/style/color.dart';

class SearchScreen extends StatelessWidget {
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context,state)
        {
          if(state is CheckSocketState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
            }
        },
        builder: (context,state)
        {
          return GestureDetector(
            onTap: (){
              FocusScopeNode focusScopeNode=FocusScope.of(context);
              if(!focusScopeNode.hasPrimaryFocus)
                {
                  focusScopeNode.unfocus();
                }
            },
            child: Scaffold(
                appBar: AppBar(
                  title: defaultTextFromField(
                      noneBorder: InputBorder.none,
                      controller: searchController,
                      hintText: 'بحث',

                      prefix: IconBroken.Search,
                      inputType: TextInputType.text,
                      validate: (){},
                      textOnChanged: (String value)
                    {
                        StoreAppCubit.get(context).searchProducts(value);
                    },
                    isShow: false
                  ),
                  titleSpacing: 0.0,
                  leading: IconButton(
                    onPressed: ()
                    {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    icon: Icon(IconBroken.Arrow___Right_2),
                  ),
                ),
                body: ConditionalBuilder(
                  builder: (context) {
                    if(StoreAppCubit.get(context).searchModel!.products.length==0)
                    {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.do_not_disturb_alt,
                              color: primaryColor,
                              size: 200,
                            ),
                            Text(
                              'لا يوجد نتائج',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 24,
                                  color: Colors.grey[300]
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  else return ListView.separated(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) {
                          return buildSearchItem(context, StoreAppCubit
                              .get(context)
                              .searchModel!
                              .products[index],index);
                        },
                        separatorBuilder: (context, index) =>
                            Container(width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],),
                        itemCount: StoreAppCubit
                            .get(context)
                            .searchModel!
                            .products
                            .length
                    );

                  },
                  condition:StoreAppCubit.get(context).searchModel!=null ,
                  fallback: (context)=>Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey[300],
                          size: 150,
                        ),
                        Text(
                          'بحث',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 30,
                            color: Colors.grey[300]
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
  Widget buildSearchItem(context,Products model,index)=>InkWell(
    onTap: (){
      FocusScope.of(context).unfocus();
      navigateTo(context, ProductDetailsScreen(model: StoreAppCubit.get(context).searchModel!.products[index], index: index,));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl:'$imageUrl${model.image}',
            imageBuilder: (context,imageProvider)=>Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: imageProvider,
              ),
            ),
            placeholder: (context,url)=>Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 30,
                child: ShimmerWidget.circular(height: 70,width: 70,
                ),
              ),
            ),
            errorWidget: (context,url,error)=>Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 25,
                child: Icon(
                  Icons.refresh_outlined,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'tajawal-light',
                    color: Colors.black
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${model.price} د.أ ',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  color: primaryColor
                )
              ),
            ],
          ),
          Spacer(
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}
