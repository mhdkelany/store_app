import 'package:equatable/equatable.dart';

class EditProfileEntity extends Equatable {
  final bool? status;
  final String? token;

  EditProfileEntity({
    required this.status,
    required this.token,
  });

  @override
  List<Object?> get props => [
        status,
        token,
       ];
}
