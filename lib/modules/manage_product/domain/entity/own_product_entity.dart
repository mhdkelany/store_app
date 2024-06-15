import 'package:equatable/equatable.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';

class OwnProductEntity extends Equatable {
  final bool? statusProfile;
  final bool status;
  final String message;
  final List<Product> productForUser;

  OwnProductEntity({
    required this.statusProfile,
    required this.status,
    required this.message,
    required this.productForUser,
  });

  @override
  List<Object?> get props => [statusProfile, status, message, productForUser,];
}
