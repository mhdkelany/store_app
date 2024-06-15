import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final bool status;
  final String message;

  const RegisterEntity({
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props => [status, message];
}
