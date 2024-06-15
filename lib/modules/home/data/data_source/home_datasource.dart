import 'package:dio/dio.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/network/error_model.dart';
import 'package:store/modules/home/data/model/change_favorite_state_model.dart';
import 'package:store/modules/home/data/model/new_home_model.dart';
import 'package:store/modules/home/domain/usecase/change_favorite_usecase.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';

abstract class BaseHomeDataSource {
  Future<NewHomeModel> getHome(int page);
  Future<NewHomeModel> getHomeAsGuest(int page);
  Future<ChangeFavoriteStateModel> changeFavoriteState(ChangeFavoriteParameters parameters);
}

class HomeDataSource extends BaseHomeDataSource {
  @override
  Future<NewHomeModel> getHome(int page) async {
    final response = await Dio().get(
      '$baseUrl$HOME',
      queryParameters: {
        'Authorization': token,
        'page': page,
      },
    );
    if(response.statusCode==200)
      {
        return NewHomeModel.fromJsom(response.data);
      }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<NewHomeModel> getHomeAsGuest(int page) async {
    final response = await Dio().get(
      '$baseUrl$homeWithoutToken',
      queryParameters: {
        'page': page,
      },
    );
    if(response.statusCode==200)
    {
      return NewHomeModel.fromJsom(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<ChangeFavoriteStateModel> changeFavoriteState(ChangeFavoriteParameters parameters)async {
    final response=await Dio().post('${baseUrl}$CHANGEFAVORITES',data: {'id_pro':parameters.id,'state':parameters.status,'Authorization':token});
    if(response.statusCode==200)
    {
      return ChangeFavoriteStateModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }
}
