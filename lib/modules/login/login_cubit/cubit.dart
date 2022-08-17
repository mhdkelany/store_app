import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:store/models/user_data_model.dart';
import 'package:store/modules/choice_user.dart';
import 'package:store/modules/login/login_cubit/states.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_point/end_point.dart';

class LoginUserMarketCubit extends Cubit<LoginUserMarketStates>
{
  LoginUserMarketCubit():super(LoginUserMarketInitialState());
  static LoginUserMarketCubit get(context)=>BlocProvider.of(context);

  bool isShow=true;
  IconData icon=Icons.visibility_off_outlined;
  bool ?isDetermine=false;
  void changeVisibilityPassword()
  {
    isShow=!isShow;
    icon=isShow?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }
  void determinePosition()  {
    Geolocator.isLocationServiceEnabled().then((value) {
      if(!value)
        {
          print('Location services are disabled.....');
          return Future.error('Location services are disabled.');
        }
      if(value)
        {
          isDetermine=true;
          countTime=0;
        }
    }).catchError((error){});

     Geolocator.checkPermission().then((value) {
      if(value==LocationPermission.denied)
        {
          print('Location services are disabled.');
          value=Geolocator.requestPermission().then((value) {
            if(value==LocationPermission.denied)
              {
                emit(LocationState());
                isDetermine=false;
               print('Location services are disabled.');
              }
          }).catchError((error){}) as LocationPermission;
        }
      if (value == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        print('ddddd');
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }).catchError((error){});

       Geolocator.getCurrentPosition().then((value) {
         getAddress(value);
         print(value.longitude);
         print(value.latitude);
         emit(GetCurrentLocationSuccessState());
       }).catchError((error) {
         emit(GetCurrentLocationErrorState());
       });

  }
  Placemark? place;
  void getAddress(Position position)
  {
    GeocodingPlatform.instance.placemarkFromCoordinates(position.latitude,position.longitude, ).then((value) {
        print(value);
         place=value[0];
        emit(GetCurrentAddressSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCurrentAddressErrorState());
    });
  }
  int countTime=0;
  void timeFinish()
  {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(countTime<10&&place==null)
        {
          countTime++;
        }else
        {
        timer.cancel();
      }

      print(countTime);
      emit(CountTimePlusState());
    });
  }
  UserDataModel ?dataModel;
  void userLogin({required String phone,required String password , String? tokenMobile,required int userType})async
  {
    if(await checkConnection()) {
      emit(LoginUserMarketLoadingState());
      DioHelper.postData(
          url: LOGIN,
          data:
          {
            'phone': phone,
            'password': password,
            'token_mobile': tokenMobile,
            'user_type': userType
          }
      ).then((value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          dataModel = UserDataModel.fromJson(value.data);
          print(value.data);

          print(phone);
          print(password);
          emit(LoginUserMarketSuccessState(dataModel!));
        }
      }).catchError((error) {
        if(error.type==DioErrorType.response)
          {
            print(error.toString());
            emit(LoginUserMarketErrorState());
          }
        print(error.toString());
        emit(LoginUserMarketErrorState());
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }
  void uploadTokenFirebase(int id)
  {
    emit(GetTokenLoadingState());
    FirebaseMessaging.instance.getToken().then((value) {
      DioHelper.postData(
          url: ADD_TOKEN,
          data: {
            'id_user':id,
            'token':value
          }
      ).then((value) {
        emit(GetTokenSuccessState());
      }).catchError((error){
        emit(GetTokenErrorState());
      });
    }).catchError((error){
      emit(GetTokenMessagingErrorState());
    });

  }
}