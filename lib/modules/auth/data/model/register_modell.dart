import 'package:store/modules/auth/domain/entity/register_entity.dart';

class RegisterModelTwo extends RegisterEntity {
  RegisterModelTwo({
    required super.status,
    required super.message,
  });

  factory RegisterModelTwo.fromJson(Map<String, dynamic> json) {
    return RegisterModelTwo(
      status: json['state'],
      message: json['message'],
    );
  }
}
