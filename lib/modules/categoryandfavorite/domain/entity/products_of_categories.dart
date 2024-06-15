import 'package:equatable/equatable.dart';

class ProductsOfCategoriesEntity extends Equatable {
  final bool status;
  final String message;
  final List<Product> products;

  ProductsOfCategoriesEntity({
    required this.status,
    required this.message,
    required this.products,
  });

  @override
  List<Object> get props => [status, message, products];
}

class Product extends Equatable {
  final String? idProduct;
  final String? name;
  final String? shortDescription;
  final String? longDescription;
  final dynamic price;
  final dynamic quantity;
  final String? discount;
  final String? image;
  final dynamic inFavorites;

  Product({
    required this.idProduct,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.image,
    required this.inFavorites,
  });

  @override
  List<Object?> get props =>
      [
        idProduct,
        name,
        shortDescription,
        longDescription,
        price,
        quantity,
        discount,
        image,
        inFavorites,
      ];
}
