part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitialState extends OrderState {}
class StoreAddQuantityToCartState extends OrderState{}
class StoreRemoveQuantityFromCartState extends OrderState{}

class StoreChangeButtonAddToCartShowState extends OrderState{}
class StoreAddItemIntoCartState extends OrderState{}
class RemoveAllCartItemState extends OrderState {}
class RemoveFromCartState extends OrderState{}

class GetTotalBillState extends OrderState{}
class ChangeProductIncludeCartState extends OrderState{}

class SendOrderSuccessState extends OrderState{}
class SendOrderLoadingState extends OrderState{}
class SendOrderErrorState extends OrderState{}





class CheckSocketOrderState extends OrderState{}


class GetOrdersForUserSuccessState extends OrderState{}
class GetOrdersForUserLoadingState extends OrderState{}
class GetOrdersForUserErrorState extends OrderState{}

class GetOrdersForUserDetailsSuccessState extends OrderState{}
class GetOrdersForUserDetailsLoadingState extends OrderState{}
class GetOrdersForUserDetailsErrorState extends OrderState{}