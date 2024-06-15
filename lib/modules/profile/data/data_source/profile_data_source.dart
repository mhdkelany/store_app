import 'package:dio/dio.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/network/error_model.dart';
import 'package:store/modules/auth/data/model/login_model.dart';
import 'package:store/modules/profile/data/model/edit_profile_model.dart';
import 'package:store/modules/profile/domain/usecase/edit_profile_usecase.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';

abstract class BaseProfileDataSource {
  Future<LogInModel> getProfile();

  Future<EditProfileModel> editProfile(EditProfileParameters parameters);
}

class ProfileDataSource extends BaseProfileDataSource {
  @override
  Future<LogInModel> getProfile() async {
    final response = await Dio().get(
      '$baseUrl$PROFILE',
      queryParameters: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return LogInModel.fromJson(response.data);
    } else {
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<EditProfileModel> editProfile(EditProfileParameters parameters) async {
    final response = await Dio().post(
      '$baseUrl$editPROFILE',
      data: {
        'Authorization': token,
        'name': parameters.name,
        'password': parameters.password,
        'phone': parameters.phone,
        'lat': parameters.lat == null ? null : parameters.lat,
        'lng': parameters.lng == null ? null : parameters.lng,
        'user_type': parameters.userType
      },
    );
    if (response.statusCode == 200) {
      return EditProfileModel.fromJson(response.data);
    } else {
      throw ServerException(
        ErrorModel.fromJson(response.data),
      );
    }
  }
}
