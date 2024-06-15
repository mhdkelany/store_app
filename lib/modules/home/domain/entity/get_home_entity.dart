import 'package:equatable/equatable.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';

class HomeEntity extends Equatable {
  final bool status;
 final bool? statusProfile;
  final List<Product> top;
  final List<Product> cate;
  final List<BannerEntity> banner;
  final List<Product> allProducts;

  HomeEntity(
      {required this.status, required this.top, required this.cate, required this.banner,this.statusProfile,required this.allProducts});

  @override
  List<Object> get props => [status, top, cate, banner,statusProfile!,allProducts];
}

class BannerEntity extends Equatable {
  final String id;
  final String image;

  BannerEntity({required this.id, required this.image});

  @override
  List<Object> get props => [id, image];
}