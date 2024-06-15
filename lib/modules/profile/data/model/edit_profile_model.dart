import 'package:store/modules/profile/domain/entity/edit_profie_entity.dart';

class EditProfileModel extends EditProfileEntity {
  EditProfileModel({
    required super.status,
    required super.token,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      status: json['state'],
      token: json['Authorization'],
    );
  }
}
