import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final bool status;
  final String message;
  final List<CategoryData> cateData;

  CategoryEntity(
      {required this.status, required this.message, required this.cateData});

  @override
  List<Object> get props => [status, message, cateData];
}

class CategoryData extends Equatable {
  final String? name;
  final dynamic idCate;
  final String? image;

  CategoryData({required this.name, required this.idCate, required this.image});

  @override
  List<Object?> get props => [name, idCate, image];
}
