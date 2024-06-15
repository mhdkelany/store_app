import 'package:equatable/equatable.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';

class SearchProductEntity extends Equatable {
  final String message;
  final bool status;
  final List<Product>? product;

  SearchProductEntity({
    required this.message,
    required this.status,
    required this.product,
  });

  @override
  List<Object> get props => [
        message,
        status,
        product!,
      ];
}
