import 'package:store/modules/auth/domain/entity/login_entity.dart';

class LogInModel extends UserEntity {
  LogInModel(
      {required super.status,
      required super.statusProfile,
      required super.message,
      required super.lang,
      required super.lat,
      required super.name,
      required super.phone,
      required super.token,
      required super.address,
      required super.userType,
        required super.id,
      });

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      id:json['id_user'],
      status: json['state'],
      statusProfile: json['state_profile']==null?null:json['state_profile'],
      message: json['message']!=null?json['message']:'',
      lang: json['lng'],
      lat: json['lat'],
      name: json['name'],
      phone: json['phone'],
      token: json['token'],
      address: json['address'],
      userType: json['user_type'],
    );
  }
}
