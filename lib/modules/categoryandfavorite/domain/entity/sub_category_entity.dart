import 'package:equatable/equatable.dart';

class SubCategoryEntity extends Equatable {
  final bool status;
  final String message;
  final List<SubCategoryDataEntity> data;

  SubCategoryEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [status, message, data];
}

class SubCategoryDataEntity extends Equatable {
  final String name;
  final String id;
  final String image;

  SubCategoryDataEntity({
    required this.name,
    required this.id,
    required this.image,
  });

  @override
  List<Object> get props => [name, id, image];
}
