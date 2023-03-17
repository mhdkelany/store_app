import 'package:store/models/register_model.dart';

abstract class RegisterUserMarketStates{}

class RegisterUserMarketInitialState extends RegisterUserMarketStates{}

class RegisterUserMarketLoadingState extends RegisterUserMarketStates{

}
class RegisterUserMarketSuccessState extends RegisterUserMarketStates
{
  RegisterModel registerModel;
  RegisterUserMarketSuccessState(this.registerModel);
}
class RegisterUserMarketErrorState extends RegisterUserMarketStates{}

class ChangePasswordRegisterVisibilityState extends RegisterUserMarketStates{}

class RegisterGetCurrentLocationSuccessState extends RegisterUserMarketStates{}
class RegisterGetCurrentLocationErrorState extends RegisterUserMarketStates{}
class changeMarkerState extends RegisterUserMarketStates{}
class RegisterGetCurrentAddressSuccessState extends RegisterUserMarketStates{}
class RegisterGetCurrentAddressErrorState extends RegisterUserMarketStates{}

class RegisterChangeBottomSheetState extends RegisterUserMarketStates{}
class RegisterChangeLocationState extends RegisterUserMarketStates{}

class ChangeColorState extends RegisterUserMarketStates{}
class ChangeLoadState extends RegisterUserMarketStates{}

class GetPlaceIdSuccessState extends RegisterUserMarketStates{}
class GetPlaceIdErrorState extends RegisterUserMarketStates{}

class VerifiedPhoneSuccessState extends RegisterUserMarketStates{}
class VerifiedPhoneLoadingState extends RegisterUserMarketStates{}
class VerifiedPhoneErrorState extends RegisterUserMarketStates{}
class VerifiedPhoneRetrievalState extends RegisterUserMarketStates{}

class AuthPhoneSuccessState extends RegisterUserMarketStates{}
class AuthPhoneLoadingState extends RegisterUserMarketStates{}
class AuthPhoneErrorState extends RegisterUserMarketStates{}

class CheckConnectionState extends RegisterUserMarketStates{}