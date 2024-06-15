import 'package:equatable/equatable.dart';

class CheckPhoneNumberEntity extends Equatable {
  final bool status;
  final String message;

  CheckPhoneNumberEntity({
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props => [
        status,
        message,
      ];
}
