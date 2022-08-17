import 'package:store/models/user_data_model.dart';

abstract class LoginUserMarketStates{}

class LoginUserMarketInitialState extends LoginUserMarketStates{}

class LoginUserMarketLoadingState extends LoginUserMarketStates{}
class LoginUserMarketErrorServerState extends LoginUserMarketStates{}
class LoginUserMarketSuccessState extends LoginUserMarketStates
{
  UserDataModel dataModel;
  LoginUserMarketSuccessState(this.dataModel);
}
class LoginUserMarketErrorState extends LoginUserMarketStates{}
class CheckSocketState extends LoginUserMarketStates{}

class ChangePasswordVisibilityState extends LoginUserMarketStates{}

class GetCurrentLocationSuccessState extends LoginUserMarketStates{}
class GetCurrentLocationErrorState extends LoginUserMarketStates{}

class GetCurrentAddressSuccessState extends LoginUserMarketStates{}
class GetCurrentAddressErrorState extends LoginUserMarketStates{}

class CountTimePlusState extends LoginUserMarketStates{}

class GetTokenSuccessState extends LoginUserMarketStates{}
class GetTokenLoadingState extends LoginUserMarketStates{}
class GetTokenErrorState extends LoginUserMarketStates{}
class GetTokenMessagingErrorState extends LoginUserMarketStates{}

class LocationState extends LoginUserMarketStates{}
