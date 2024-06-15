import 'package:equatable/equatable.dart';




class ChangeFavoriteEntity extends Equatable {
  final bool status;
  final String message;

  ChangeFavoriteEntity({required this.status, required this.message,});

  @override
  List<Object> get props => [status, message];
}