import 'package:store/models/edit_profile_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/models/product_for_user_model.dart';
import 'package:store/models/wishes_model.dart';

abstract class StoreAppStates {}
class StoreAppInitialState extends StoreAppStates{}
class ChangeBottomNavState extends StoreAppStates{}


class SelectedIndexState extends StoreAppStates{}


class ClearFromCacheState extends StoreAppStates{}

class ChangeDrawerState extends StoreAppStates{}











class ChangePasswordVisibilityState extends StoreAppStates{}







class ChoiceFromCategory extends StoreAppStates{}

class ChoiceImageSuccessState extends StoreAppStates{}
class ChoiceImageErrorState extends StoreAppStates{}

class RemoveImageState extends StoreAppStates{}




class UpdateProductForUserSuccessState extends StoreAppStates{
  final bool status;
  final String message;

  UpdateProductForUserSuccessState({required this.status, required this.message});
}
class UpdateProductForUserLoadingState extends StoreAppStates{}
class UpdateProductForUserErrorState extends StoreAppStates{}



class QuantityProductIsEmptyState extends StoreAppStates{}


class GetPlaceIdSuccessState extends StoreAppStates{}
class GetPlaceIdErrorState extends StoreAppStates{}

class ConnectTrueState extends StoreAppStates{}
class ConnectFalseState extends StoreAppStates{}
class CheckState extends StoreAppStates
{
  bool state;
  CheckState(this.state);
}
class Connect2TrueState extends StoreAppStates{}
class Connect2FalseState extends StoreAppStates{}

class ConnectionSuccessState extends StoreAppStates{}
class ConnectionErrorState extends StoreAppStates{}

class CheckSocketState extends StoreAppStates{}
class OpenWishScreenState extends StoreAppStates{}





class ChangeBottomForMerchant extends StoreAppStates{}


class SearchForUserState extends StoreAppStates{}
class ClearTextState extends StoreAppStates{}
class StartSearchingState extends StoreAppStates{}



