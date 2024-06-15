import 'package:dio/dio.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/network/error_model.dart';
import 'package:store/modules/auth/data/model/login_model.dart';
import 'package:store/modules/auth/data/model/register_modell.dart';
import 'package:store/modules/auth/domain/usecase/login_usecase.dart';
import 'package:store/modules/auth/domain/usecase/register_usecase.dart';
import 'package:store/shared/network/end_point/end_point.dart';

abstract class BaseAuthDataSource {
  Future<LogInModel> login(LoginParameters parameters);
  Future<RegisterModelTwo> register(RegisterParameters parameters);
}

class AuthDataSource extends BaseAuthDataSource {
  @override
  Future<LogInModel> login(LoginParameters parameters)async {
    final response = await Dio().post('$baseUrl$LOGIN', data: {
      'phone': parameters.phone,
      'password': parameters.password,
      'user_type': parameters.userType,
      'token_mobile':parameters.tokenMobile
    });
    if(response.statusCode==200)
      {
        return LogInModel.fromJson(response.data);
      }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<RegisterModelTwo> register(RegisterParameters parameters)async {
   final response=await Dio().post('$baseUrl$Register' ,data: {
     'phone': parameters.phone,
     'password': parameters.password,
     'user_type': parameters.userType,
     'name':parameters.name,
     'address':parameters.address,
     'lat':parameters.lat,
     'lng':parameters.lng
   });
   if(response.statusCode==200)
     {
       return RegisterModelTwo.fromJson(response.data);
     }else{
     throw ServerException(ErrorModel.fromJson(response.data));
   }
  }
}
