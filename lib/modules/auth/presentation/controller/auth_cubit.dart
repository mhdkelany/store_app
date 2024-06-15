import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/auth/domain/entity/register_entity.dart';
import 'package:store/modules/auth/domain/usecase/login_usecase.dart';
import 'package:store/modules/auth/domain/usecase/register_usecase.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/home/presentation/screen/main_screen.dart';
import 'package:store/modules/home/presentation/screen/zoom_drawer_screen.dart';
import 'package:store/modules/other/other_screens/choice_user.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

import '../../login/login_cubit/states.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit(this.loginUseCase, this.registerUseCase) : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  void removeState() {
    emit(RemoveState());
  }

  bool isShow = true;
  IconData icon = Icons.visibility_off_outlined;

  void changeVisibilityPassword() {
    isShow = !isShow;
    icon = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  UserEntity? userEntity;

  FutureOr<void> login({required LoginParameters loginParameters}) async {
    emit(LoginLoadingState());
    final result = await loginUseCase.call(loginParameters);
    result.fold(
      (l) {
        emit(LoginErrorState(l.message));
      },
      (r) {
        userEntity = r;
        emit(LoginSuccessState(userEntity!));
      },
    );
  }

  void uploadTokenFirebase(int id) {
    FirebaseMessaging.instance.getToken().then((value) {
      DioHelper.postData(url: ADD_TOKEN, data: {'id_user': id, 'token': value})
          .then((value) {})
          .catchError((error) {});
    }).catchError((error) {});
  }

  void logOut({required String token, required int id}) {
    DioHelper.postData(
      url: 'logout',
      data: {'token_user': token, "id_user": id},
    ).then((value) {}).catchError((error) {});
  }

  void determinePosition() {
    Geolocator.isLocationServiceEnabled().then((value) {
      if (!value) {
        //emit(LocationDoNotOpenState());
      }
      if (value) {}
    }).catchError((error) {});

    Geolocator.checkPermission().then((value) {
      value = Geolocator.requestPermission().then((value) {
        if (value == LocationPermission.denied) {
          emit(LoginLocationState());
        } else if (value == LocationPermission.always) {
          CacheHelper.putData(key: 'location', value: true).then((value) {
            location = CacheHelper.getCacheData(key: 'location');
            emit(LoginLocationOpenState());
          });
        } else if (value == LocationPermission.whileInUse) {
          CacheHelper.putData(key: 'location', value: true);
          CacheHelper.putData(key: 'location', value: true).then((value) {
            // getCurrentPosition();
            location = CacheHelper.getCacheData(key: 'location');
            emit(LoginLocationOpenState());
          });
        } else if (value == LocationPermission.unableToDetermine) {}
      }).catchError((error) {}) as LocationPermission;

      if (value == LocationPermission.deniedForever) {
        emit(LoginLocationState());
      }
    }).catchError((error) {});
  }
  late RegisterEntity registerEntity;
  FutureOr<void> register(RegisterParameters parameters,BuildContext context) async {
    if(await checkConnection()) {
      final result = await registerUseCase.call(parameters);
      result.fold(
            (l) {
          emit(RegisterErrorState(l.message));
        },
            (r) {
          registerEntity = r;
          navigateToEnd(context, ChoiceUser());
          emit(RegisterSuccessState(registerEntity));
        },
      );
    }else{
      emit(RegisterCheckConnectionState());
    }
  }

  bool showBottom=false;
  void changeBottomSheet(bool isShow,context)
  {
    showBottom=isShow;

    emit(ChangeBottomSheetState());
  }
  bool isShowing=true;
  IconData icons=Icons.visibility_off_outlined;
  void changeVisibilityPasswordRegister()
  {
    isShow=!isShow;
    icon=isShow?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }
  CameraPosition? kGooglePlex ;
  var myMarker=[];
  LatLng? newLatLng;
  double ? lat;
  double ?lang;
  double ? constLat;
  double ?constLng;
  void determineRegisterPosition()  {
    Geolocator.isLocationServiceEnabled().then((value) {
      if(!value)
      {
        return Future.error('Location services are disabled.');
      }
    }).catchError((error){});

    Geolocator.checkPermission().then((value) {
      if(value==LocationPermission.denied)
      {
        value=Geolocator.requestPermission().then((value) {
          if(value==LocationPermission.denied)
          {
            print('Location services are disabled.');
          }
        }).catchError((error){}) as LocationPermission;
      }
      if (value == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }).catchError((error){});
    Geolocator.getCurrentPosition().then((value) {

      constLat=value.latitude;
      constLng=value.longitude;
      lat=value.latitude;
      lang=value.longitude;
      print(value.longitude);
      getAddress(lat!,lang!);
      kGooglePlex=CameraPosition(
        target: LatLng(lat!, lang!),
        zoom: 18.4746,
      );
      myMarker=[];
      Marker marker=Marker(
        markerId: MarkerId('1'),
        position: LatLng(lat!, lang!),

      );
      myMarker.add(marker);
      emit(GetCurrentLocationSuccessState());
    }).catchError((error){
      emit(GetCurrentLocationErrorState());

    });
  }
  void changeLocation(CameraPosition pos)
  {
    myMarker.first=myMarker.first.copyWith(positionParam: pos.target);

    emit(ChangeLocationState());
  }
  void changeMarker(GoogleMapController controller)
  {
    LatLng latLng=LatLng(constLat!, constLng!);
    controller.animateCamera(CameraUpdate.newLatLng(latLng)).then((value) {
      newLatLng=latLng;
      print(latLng);
      print(newLatLng);
      emit(RegisterChangeMarkerState());
    });
  }
  Placemark? place;
  void getAddress(double lat,double lng)
  {
    placemarkFromCoordinates(lat,lng).then((value) {
      place=value[1];
      print(place);
      emit(GetCurrentAddressSuccessState());
    }).catchError((error){
      emit(GetCurrentAddressErrorState());
    });
  }
  void getNewAddress(double lat,double lng)
  {
    placemarkFromCoordinates(lat,lng).then((value) {
      place=value[1];
      print(value);
      emit(GetCurrentAddressSuccessState());
    });
  }

  loginOperation(BuildContext context,AuthState state){
    if (state is LoginLoadingState) {
      showDialog(context: context, builder: (context) => Loading(context));
    }
    if (state is CheckSocketState) {
      ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
          Text('لا يوجد اتصال بالإنترنت'),
          Colors.amber,
          Duration(seconds: 5)));
    }
    if (state is LoginSuccessState) {
      if(state.userEntity.statusProfile!=null)
        if (!state.userEntity.statusProfile!) {
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              Text('حسابك متوقف لا يمكنك تسجيل الدخول'),
              Colors.amber,
              Duration(seconds: 5)));
          Navigator.pop(context);
        }
      //if(LoginUserMarketCubit.get(context).dataModel!=null)
      if (state.userEntity.status != null) if (state.userEntity.userType ==
          1) {
        if (state.userEntity.status) {
          CacheHelper.putData(key: 'token', value: state.userEntity.token)
              .then((value) {
            navigateToEnd(context, DrawerScreen());
            CacheHelper.putData(key: 'isSailing', value: false);
            token = state.userEntity.token;
            ProfileCubit.get(context).getProfile(NoParameters(),context);
            //HomeCubit.get(context).getHome(isRefresh: true);
            FavoriteAndCategoryCubit.get(context).getCategories(NoParameters());
          });
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
            Text(
              '${state.userEntity.message}يرجى التأكد من البيانات المدخلة',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Colors.red,
            Duration(seconds: 3),
          ));
        }
      } else {
        if (state.userEntity.status) {
          CacheHelper.putData(key: 'token', value: state.userEntity.token)
              .then((value) {
            navigateToEnd(context, MainScreen());
            CacheHelper.putData(key: 'isSailing', value: true);
            token = state.userEntity.token;
            ProfileCubit.get(context).getProfile(NoParameters(),context);
            FavoriteAndCategoryCubit.get(context).getCategories(NoParameters());
          });
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
            Text(
              '${state.userEntity.message}يرجى التأكد من البيانات المدخلة',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            Colors.red,
            Duration(seconds: 3),
          ));
        }
      }
    }
  }
}
