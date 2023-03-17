import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/models/register_model.dart';
import 'package:store/modules/auth/register/states.dart';
import 'package:store/modules/choice_user.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class RegisterUserMarketCubit extends Cubit<RegisterUserMarketStates> {
  RegisterUserMarketCubit() :super(RegisterUserMarketInitialState());

  static RegisterUserMarketCubit get(context) => BlocProvider.of(context);

  bool isShow = true;
  IconData icon = Icons.visibility_off_outlined;

  void changeVisibilityPassword() {
    isShow = !isShow;
    icon = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordRegisterVisibilityState());
  }
    CameraPosition? kGooglePlex ;
  var myMarker=[];
  LatLng? newLatLng;
  double ? lat;
  double ?lang;
  double ? constLat;
  double ?constLng;
  void determinePosition()  {
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
      // if(newLatLng!=null)
      //   placemarkFromCoordinates(newLatLng!.latitude, newLatLng!.longitude).then((value) {
      //     place=value[0];
      //     print(value);
      //     emit(RegisterGetCurrentAddressSuccessState());
      //   });
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
      emit(RegisterGetCurrentLocationSuccessState());
    }).catchError((error){
      emit(RegisterGetCurrentLocationErrorState());

    });
  }
  void changeLocation(CameraPosition pos)
  {
   myMarker.first=myMarker.first.copyWith(positionParam: pos.target);

   emit(RegisterChangeLocationState());
  }
  void changeMarker(GoogleMapController controller)
  {
    LatLng latLng=LatLng(constLat!, constLng!);
    controller.animateCamera(CameraUpdate.newLatLng(latLng)).then((value) {
      newLatLng=latLng;
      print(latLng);
      print(newLatLng);
      emit(changeMarkerState());
    });
  }
  Placemark? place;
  void getAddress(double lat,double lng)
  {
    placemarkFromCoordinates(lat,lng).then((value) {
      place=value[1];
      print(place);
      emit(RegisterGetCurrentAddressSuccessState());
    }).catchError((error){
      emit(RegisterGetCurrentAddressErrorState());
    });
  }
  void getNewAddress(double lat,double lng)
  {
    placemarkFromCoordinates(lat,lng).then((value) {
      place=value[1];
      print(value);
      emit(RegisterGetCurrentAddressSuccessState());
    });
  }
  bool showBottom=false;
  void changeBottomSheet(bool isShow,context)
  {
    showBottom=isShow;

    emit(RegisterChangeBottomSheetState());
  }
  bool isShowing=true;
  IconData icons=Icons.visibility_off_outlined;
  void changeVisibilityPasswordRegister()
  {
    isShow=!isShow;
    icon=isShow?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ChangePasswordRegisterVisibilityState());
  }
  RegisterModel? model;
  void createUser({
    required int userType,
    required String password,
    required String name,
    required String phone,
    required String address,
   required BuildContext context
  })async
  {
    if(await checkConnection()) {
      emit(RegisterUserMarketLoadingState());
      DioHelper.postData(
        url: Register,
        data: {
          'password': password,
          'name': name,
          'phone': phone,
          'email': 'mmhd@djjsssjfsssssss',
          'lng': lang,
          'lat': lat,
          'user_type': userType,
          'address': address,
        },
      ).then((value) {
        model = RegisterModel.fromJson(value.data);
        navigateToEnd(context, ChoiceUser());
        emit(RegisterUserMarketSuccessState(model!));
      }).catchError((error) {
        print(error.toString());
        emit(RegisterUserMarketErrorState());
      });
    }
    else
      {
        emit(CheckConnectionState());
      }
  }
  bool isPrimaryColor=false;
  void changeColor()
  {
    isPrimaryColor=!isPrimaryColor;
    emit(ChangeColorState());
  }
  String key='';
  void getPlaceId(String value)
  {
    Dio dio=Dio(
      BaseOptions(
        baseUrl: 'https://maps.googleapis.com/',
     )
    );
    String url='map/api/place/findplacefromtext/json?';
    dio.get(
      url,
      queryParameters:
      {
        'input':value,
        'inputtype':'textquery',
        'key':key
      }
    )
        .then((value) {
          emit(GetPlaceIdSuccessState());
    }).catchError((error){
      emit(GetPlaceIdErrorState());
    });
  }
  bool isLoading=false;
  void changeLoading()
  {
    isLoading=!isLoading;
    emit(ChangeLoadState());
  }
  String verificationIdd='';
  String messageError='';
  verifiedPhone(String phone)async
  {
    if(await checkConnection()) {
      emit(VerifiedPhoneLoadingState());
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+962${phone}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            //ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('${e.code}'), Colors.red, Duration(seconds: 3)));
            //RegisterUserMarketCubit.get(context).changeLoading();
            isLoading = false;
            messageError = e.message ?? 'error';
            emit(VerifiedPhoneErrorState());
          },
          codeSent: (String verificationId, int? resendToken) {
            // RegisterUserMarketCubit.get(context).changeLoading();
            //navigateTo(context, VerifiedScreen(verificationId: verificationId,password: passwordController.text, name: nameController.text, phone:phoneController.text, address: cityController.text,isTimeOut: false,));
            verificationIdd = verificationId;
            isLoading = false;
            emit(VerifiedPhoneSuccessState());
          },
          timeout: Duration(seconds: 100),
          codeAutoRetrievalTimeout: (String verificationId) {
            isLoading = false;
            emit(VerifiedPhoneRetrievalState());
            //navigateTo(context, VerifiedScreen(verificationId: verificationId,password: passwordController.text, name: nameController.text, phone:phoneController.text, address: cityController.text,isTimeOut: true));
          },
        );
      } on FirebaseAuthException catch (e) {
        messageError ='يوجد خطأ في اﻷتصال الرجاء إعادة المحاولة لاحقاً';
        print(messageError);
        emit(VerifiedPhoneErrorState());
      }
    }
    else
      {
        emit(CheckConnectionState());
      }
  }
  FirebaseAuth auth=FirebaseAuth.instance;
  bool isVerified=true;
  authPhone({required String verificationId,required String opt,required String password,required String name,required String phone,required String address,required BuildContext context})async
  {
    if(await checkConnection()) {
      isVerified = true;
      emit(AuthPhoneLoadingState());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: opt);
        await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        isVerified = false;
        messageError = e.code;
        emit(AuthPhoneErrorState());
        //ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('${e.code}'), Colors.red, Duration(seconds: 3)));
      }
      if (auth.currentUser != null && isVerified) {
        print(auth.currentUser);
        emit(AuthPhoneSuccessState());
        // RegisterUserMarketCubit.get(context).createUser(password: password, name: name, phone: phone, address: address,userType: 1);
      }
    }
    else
      {
        emit(CheckConnectionState());
      }
  }

}