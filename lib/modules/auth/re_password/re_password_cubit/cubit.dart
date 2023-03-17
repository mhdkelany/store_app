import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/auth/re_password/model/check_phone_number_model.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/states.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class RePasswordCubit extends Cubit<RePasswordStates> {
  RePasswordCubit() : super(RePasswordInitState());

  static RePasswordCubit get(context) => BlocProvider.of(context);
  CheckPhoneNumberModel? checkPhoneNumberModel;
  void checkPhoneNumber(String phone) async {
    emit(RePasswordCheckPhoneNumberLoadingState());
    if (await checkConnection()) {
      DioHelper.postData(
        url: 'send_code.php',
        data: {
          'email':phone
        },
      )
          .then(
            (value)
        {
          checkPhoneNumberModel=CheckPhoneNumberModel.fromJson(value.data);
          emit(RePasswordCheckPhoneNumberSuccessState(checkPhoneNumberModel!));
        },
          )
          .catchError(
            (error)
        {
          emit(RePasswordCheckPhoneNumberErrorState(error.toString()));
        },
          );
    }
  }

  String verificationIdd = '';
  String messageError = '';
  bool rePasswordIsLoading = false;
  FirebaseAuth rePasswordAuth=FirebaseAuth.instance;
  rePasswordVerifiedPhone(String phone) async {
    if (await checkConnection()) {
      emit(RePasswordVerifiedPhoneNumberLoadingState());
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+963${phone}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            rePasswordIsLoading = false;
            messageError = e.message ?? 'error';
            print(e.message);
            emit(RePasswordVerifiedPhoneNumberErrorState());
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationIdd = verificationId;
            rePasswordIsLoading = false;
            emit(RePasswordVerifiedPhoneNumberSuccessState());
          },
          timeout: Duration(seconds: 100),
          codeAutoRetrievalTimeout: (String verificationId) {
            rePasswordIsLoading = false;
            // emit(VerifiedPhoneRetrievalState());
          },
        );
      } on FirebaseAuthException catch (e) {
        messageError = 'يوجد خطأ في اﻷتصال الرجاء إعادة المحاولة لاحقاً';
        print(messageError);
        emit(RePasswordVerifiedPhoneNumberErrorState());
      }
    }
  }
  bool isVerified=true;

  authPhone({required String opt})async
  {
    if(await checkConnection()) {
      isVerified = true;
      emit(RePasswordAuthPhoneLoadingState());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationIdd, smsCode: opt);
        await rePasswordAuth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        isVerified = false;
        messageError = e.code;
        emit(RePasswordAuthPhoneErrorState());
        //ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('${e.code}'), Colors.red, Duration(seconds: 3)));
      }
      if (rePasswordAuth.currentUser != null && isVerified) {
        print(rePasswordAuth.currentUser);
        emit(RePasswordAuthPhoneSuccessState());
        // RegisterUserMarketCubit.get(context).createUser(password: password, name: name, phone: phone, address: address,userType: 1);
      }
    }
  }
}
