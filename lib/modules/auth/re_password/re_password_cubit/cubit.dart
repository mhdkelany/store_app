import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/auth/re_password/model/check_phone_number_model.dart';
import 'package:store/modules/auth/re_password/model/re_password_model.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/states.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class RePasswordCubit extends Cubit<RePasswordStates> {
  RePasswordCubit() : super(RePasswordInitState());

  static RePasswordCubit get(context) => BlocProvider.of(context);
  CheckPhoneNumberModel? checkPhoneNumberModel;

  void checkPhoneNumber(String phone) async {
    emit(RePasswordCheckPhoneNumberLoadingState());
    if (await checkConnection()) {
      DioHelper.postData(
        url: SEND_CODE,
        data: {'email': phone},
      ).then(
        (value) {
          checkPhoneNumberModel = CheckPhoneNumberModel.fromJson(value.data);
          emit(RePasswordCheckPhoneNumberSuccessState(checkPhoneNumberModel!));
        },
      ).catchError(
        (error) {
          emit(RePasswordCheckPhoneNumberErrorState(error.toString()));
        },
      );
    }
  }

  RePasswordModel? rePasswordModel;

  void rePassword({required String phone, required String password}) async {
    emit(RePasswordLoadingState());
    if (await checkConnection()) {
      DioHelper.postData(
        url: RE_PASSWORD,
        data: {
          'email': phone,
          'password': password,
        },
      ).then(
        (value) {
          rePasswordModel = RePasswordModel.fromJson(value.data);
          emit(RePasswordSuccessState());
        },
      ).catchError(
        (error) {
          emit(
            RePasswordErrorState(error.toString()),
          );
        },
      );
    }
  }

  String verificationIdd = '';
  bool rePasswordIsLoading = false;
  FirebaseAuth rePasswordAuth = FirebaseAuth.instance;

  Future rePasswordVerifiedPhone(String phone) async {
    if (await checkConnection()) {
      emit(RePasswordVerifiedPhoneNumberLoadingState());
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+962${phone}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            rePasswordIsLoading = false;
            print(e.message);
            emit(RePasswordVerifiedPhoneNumberWrongState(e.message!));
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationIdd = verificationId;
            rePasswordIsLoading = false;
            emit(RePasswordVerifiedPhoneNumberSuccessState());
          },
          timeout: Duration(seconds: 100),
          codeAutoRetrievalTimeout: (String verificationId) {
            rePasswordIsLoading = false;
          },
        );
      } on FirebaseAuthException catch (e) {
        emit(RePasswordVerifiedPhoneNumberErrorState(e.toString()));
      }
    }
  }

  bool isVerified = true;

  authPhone({required String opt}) async {
    if (await checkConnection()) {
      isVerified = true;
      emit(RePasswordAuthPhoneLoadingState());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationIdd, smsCode: opt);
        await rePasswordAuth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        isVerified = false;
        emit(RePasswordAuthPhoneErrorState(e.message!));
      }
      if (rePasswordAuth.currentUser != null && isVerified) {
        print(rePasswordAuth.currentUser);
        emit(RePasswordAuthPhoneSuccessState());
      }
    }
  }
}
