import 'package:store/models/edit_profile_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/models/product_for_user_model.dart';
import 'package:store/models/wishes_model.dart';

abstract class StoreAppStates {}
class StoreAppInitialState extends StoreAppStates{}
class ChangeBottomNavState extends StoreAppStates{}

class StoreHomeLoadingState extends StoreAppStates{}
class StoreHomeSuccessState extends StoreAppStates
{
  HomeModel homeModel;
  StoreHomeSuccessState(this.homeModel);
}
class StoreHomeErrorState extends StoreAppStates
{

}
class SelectedIndexState extends StoreAppStates{}
class StoreCategoriesSuccessState extends StoreAppStates{}
class StoreCategoriesErrorState extends StoreAppStates{}

class StoreAddQuantityToCartState extends StoreAppStates{}
class StoreRemoveQuantityFromCartState extends StoreAppStates{}

class StoreChangeButtonAddToCartShowState extends StoreAppStates{}

class StoreAddItemIntoCartState extends StoreAppStates{}

class RemoveAllCartItemState extends StoreAppStates {}

class OpenWishScreenState extends StoreAppStates{}

class GetTotalBillState extends StoreAppStates{}

class ClearFromCacheState extends StoreAppStates{}

class ChangeDrawerState extends StoreAppStates{}

class PostWishSuccessState extends StoreAppStates
{
  WishesModel wishesModel;
  PostWishSuccessState(this.wishesModel);
}
class PostWishLoadingState extends StoreAppStates{}
class PostWishErrorState extends StoreAppStates{}


class GetProfileSuccessState extends StoreAppStates{}
class GetProfileLoadingState extends StoreAppStates{}
class GetProfileErrorState extends StoreAppStates{}

class GetFavoritesSuccessState extends StoreAppStates{}
class GetFavoritesLoadingState extends StoreAppStates{}
class GetFavoritesErrorState extends StoreAppStates{}

class ChangeFavoritesSuccessState extends StoreAppStates{}
class ChangeFavoritesLoadingState extends StoreAppStates{}
class ChangeFavoritesErrorState extends StoreAppStates{}

class SearchProductsSuccessState extends StoreAppStates{}
class SearchProductsLoadingState extends StoreAppStates{}
class SearchProductsErrorState extends StoreAppStates{}

class ChangePasswordVisibilityState extends StoreAppStates{}

class ChangeProfileSuccessState extends StoreAppStates
{
  EditProfileModel editProfileModel;
  ChangeProfileSuccessState(this.editProfileModel);
}
class ChangeProfileLoadingState extends StoreAppStates{}
class ChangeProfileErrorState extends StoreAppStates{}

class getProductIncludeCategorySuccessState extends StoreAppStates{}
class getProductIncludeCategoryErrorState extends StoreAppStates{}

class ChangeProductIncludeCartState extends StoreAppStates{}

class SendOrderSuccessState extends StoreAppStates{}
class SendOrderLoadingState extends StoreAppStates{}
class SendOrderErrorState extends StoreAppStates{}
class ChoiceFromCategory extends StoreAppStates{}

class ChoiceImageSuccessState extends StoreAppStates{}
class ChoiceImageErrorState extends StoreAppStates{}

class RemoveImageState extends StoreAppStates{}

class GetProductForUserSuccessState extends StoreAppStates
{
  ProductForUserModel productForUserModel;
  GetProductForUserSuccessState(this.productForUserModel);
}
class GetProductForUserLoadingState extends StoreAppStates{}
class GetProductForUserErrorState extends StoreAppStates{}

class UpdateProductForUserSuccessState extends StoreAppStates{}
class UpdateProductForUserLoadingState extends StoreAppStates{}
class UpdateProductForUserErrorState extends StoreAppStates{}

class InsertProductForUserSuccessState extends StoreAppStates{
  ProductForUserModel productForUserModel;
  InsertProductForUserSuccessState(this.productForUserModel);
}
class InsertProductForUserLoadingState extends StoreAppStates{}
class InsertProductForUserErrorState extends StoreAppStates{}

class QuantityProductIsEmptyState extends StoreAppStates{}
class ChangeLocationState extends StoreAppStates{}
class InitialMapState extends StoreAppStates{}
class AnimateCameraState extends StoreAppStates{}

class GetPlaceIdSuccessState extends StoreAppStates{}
class GetPlaceIdErrorState extends StoreAppStates{}
class RemoveFromCartState extends StoreAppStates{}

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


class GetOrdersForUserSuccessState extends StoreAppStates{}
class GetOrdersForUserLoadingState extends StoreAppStates{}
class GetOrdersForUserErrorState extends StoreAppStates{}

class GetOrdersForUserDetailsSuccessState extends StoreAppStates{}
class GetOrdersForUserDetailsLoadingState extends StoreAppStates{}
class GetOrdersForUserDetailsErrorState extends StoreAppStates{}

