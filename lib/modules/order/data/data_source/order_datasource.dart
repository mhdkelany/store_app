import 'package:dio/dio.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/network/error_model.dart';
import 'package:store/modules/order/data/model/get_details_order_model.dart';
import 'package:store/modules/order/data/model/get_orders_model.dart';
import 'package:store/modules/order/domain/order_usecase/order_usecase.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';

abstract class BaseOrderDataSource {
  Future<dynamic> order(OrderParameters parameters);
  Future<GetOrdersModel> getOrders();
  Future<OrderForMoreDetailsModel> getOrdersDetails(int parameter);
}

class OrderDataSource extends BaseOrderDataSource {
  @override
  Future order(OrderParameters parameters) async {
    final response = await Dio().post('$baseUrl$BILL', data: {
      'products': parameters.product.map((e) => e.toJson()).toList(),
      'Authorization': token,
      'total': parameters.totalBill,
      'lat': parameters.lat == null
          ? ProfileCubit.get(parameters.context).userInformation!.lat
          : parameters.lat,
      'lng': parameters.lng == null
          ? ProfileCubit.get(parameters.context).userInformation!.lang
          : parameters.lng,
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<GetOrdersModel> getOrders() async {
    final response = await Dio().post(
      '$baseUrl$ORDER_USER',
      data: {
        'Authorization': token,
      },
    );
    if(response.statusCode==200){
      return GetOrdersModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<OrderForMoreDetailsModel> getOrdersDetails(int parameter) async{
    final response = await Dio().post(
      '$baseUrl$ORDER_DETAILS_USER',
      data: {
        'Authorization': token,
        'id_bill':parameter,
      },
    );
    if(response.statusCode==200){
      return OrderForMoreDetailsModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }
}
