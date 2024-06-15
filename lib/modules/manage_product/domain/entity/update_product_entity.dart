import 'package:equatable/equatable.dart';

class UpdateProductEntity extends Equatable {
  final String message;
  final bool status;

  UpdateProductEntity({
    required this.message,
    required this.status,
  });

  @override
  List<Object> get props => [message, status];
}
