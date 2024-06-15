import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/presentation/widgets/product_details_widgets/build_body.dart';
import 'package:store/modules/order/presentation/widgets/product_details_widgets/build_bottom.dart';
import 'package:store/modules/order/presentation/widgets/product_details_widgets/build_leading.dart';
import 'package:store/modules/order/presentation/widgets/product_details_widgets/build_title.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  Product? model;
  final key1 = GlobalKey();
  int? index;
  int i = 0;

  ProductDetailsScreen({this.model, this.index});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  leading: BuildLeading(),
                  floating: false,
                  backgroundColor: forAppBar,
                  toolbarHeight: 50,
                  title: BuildTitle(),
                  pinned: true,
                  bottom: BuildBottom.buildBottom(),
                  expandedHeight: MediaQuery.of(context).size.height * 0.50,
                  flexibleSpace: CachedNetworkImage(
                    cacheManager: StoreAppCubit.get(context).cacheManager,
                    key: UniqueKey(),
                    imageUrl:
                        'https://ibrahim-store.com/api2/images/${model!.image}',
                    imageBuilder: (context, imageProvider) => FlexibleSpaceBar(
                      background: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      child: ShimmerWidget.rectangular(
                        height: MediaQuery.of(context).size.height * 0.53,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.53,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.refresh_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
              body: BuildBody(index: index!,model: model!),
              physics: BouncingScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}
