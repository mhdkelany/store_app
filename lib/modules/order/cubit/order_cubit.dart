import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/models/products_cart_model.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/order/domain/entity/order_entity.dart';
import 'package:store/modules/order/domain/entity/order_more_details_entity.dart';
import 'package:store/modules/order/domain/order_usecase/get_order_details_usecase.dart';
import 'package:store/modules/order/domain/order_usecase/get_orders_usecase.dart';
import 'package:store/modules/order/domain/order_usecase/order_usecase.dart';
import 'package:store/shared/components/constansts/constansts.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderUseCase orderUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderDetailsUseCase getOrdersDetailsUseCase;

  OrderCubit(
      this.orderUseCase, this.getOrdersUseCase, this.getOrdersDetailsUseCase)
      : super(OrderInitialState());

  static OrderCubit get(BuildContext context) => BlocProvider.of(context);
  bool buttonAddToCartShow = true;
  int countQuantity = 0;
  int quantityIndex = 0;
  int testPrice = 100;
  double result = 0.0;

  void addQuantityToCart({index, bool isCart = false}) {
    if (!isCart) {
      countQuantity++;
      quantityIndex++;
    }
    if (isCart) {
      //result=model.products[index].price!;
//double.tryParse(homeModel!.products[index2].price)!
      quantityIndex = product[index].quantity!;
      quantityIndex++;
      priceTotal = 0.0;
      product[index].quantity = quantityIndex;
      product[index].result = quantityIndex * product[index].price;
      // result=(quantityIndex*testPrice).toDouble();
      //product[index].price=result;
      getTotalBill();
      //print(product[2].quantity);
    }
    buttonAddToCartShow = true;
    // result=(countQuantity*testPrice).toDouble();
    emit(StoreAddQuantityToCartState());
  }

  void removeQuantityFromCart({index, bool isCart = false}) {
    if (countQuantity > 0) {
      if (!isCart) countQuantity--;
    }
    if (product.length > 0 && isCart && product[index].quantity > 1) {
      quantityIndex = product[index].quantity!;
      // result=model.products[index].price!;
      quantityIndex--;
      priceTotal = 0.0;
      product[index].quantity = quantityIndex;
      product[index].result = quantityIndex * product[index].price;
      //result=(quantityIndex*testPrice).toDouble();
      //product[index].price=result;
      getTotalBill();

      //print(product[2].quantity);
    }
    buttonAddToCartShow = true;
    result = (countQuantity * testPrice).toDouble();
    emit(StoreRemoveQuantityFromCartState());
  }

  void changeButtonAddToCartShow() {
    buttonAddToCartShow = !buttonAddToCartShow;
    emit(StoreChangeButtonAddToCartShowState());
  }

  List<CartProducts> product = [];

  void addToCart(
      {required int quantity,
      required String productName,
      required String image,
      double? price,
      required String idProduct,
      double? result,
      int? quantityProduct}) {
    // idProducts=[];
    CartProducts cartModel = CartProducts(
        image: image,
        price: price,
        productName: productName,
        quantity: quantity,
        idProduct: idProduct,
        result: result,
        quantityProduct: quantityProduct);
    product.add(cartModel);
    print(cartModel.price);
    emit(StoreAddItemIntoCartState());
    //print(price.toString());
  }

  void removeAllCartItem() {
    product = [];
    emit(RemoveAllCartItemState());
  }

  double priceTotal = 0.0;

  void getTotalBill() {
    if (product.length > 0)
      product.forEach((element) {
        priceTotal = element.result! + priceTotal;
      });
    emit(GetTotalBillState());
  }

  void editProductIncludeCart(
      {required int quantity, required double priceTotal, required int index}) {
    product[index].result = priceTotal;
    product[index].quantity = quantity;

    emit(ChangeProductIncludeCartState());
  }

  double? latBill;
  double? lngBill;
  int i = 0;

  void plus() {
    i++;
  }

  FutureOr<void> order(OrderParameters parameters) async {
    emit(SendOrderLoadingState());
    if (await checkConnection()) {
      final result = await orderUseCase.call(parameters);
      result.fold(
        (l) {
          emit(SendOrderErrorState());
        },
        (r) {
          i = 0;
          emit(SendOrderSuccessState());
          removeAllCartItem();
        },
      );
    } else {
      emit(CheckSocketOrderState());
    }
  }

  void removeFromCart(index, context) async {
    priceTotal = priceTotal - product[index].result;
    await product.removeAt(index);
    emit(RemoveFromCartState());
  }

  void addToCartOperation(BuildContext context, Product model) {
    bool iss = false;
    changeButtonAddToCartShow();
    for (int i = 0; i < product.length; i++) {
      if (product[i].idProduct == model.idProduct) {
        print(product.length);
        iss = true;
      }
    }
    if (product.isEmpty || !iss) {
      addToCart(
          quantityProduct: int.tryParse(model.quantity!)!,
          quantity: countQuantity,
          productName: '${model.name}',
          image: '${model.image}',
          result: countQuantity * double.tryParse(model.price)!,
          idProduct: '${model.idProduct}',
          price: double.tryParse(model.price)!);
      plus();
    } else {
      for (int i = 0; i < product.length; i++) {
        if (product[i].idProduct == model.idProduct)
          editProductIncludeCart(
              quantity: countQuantity,
              priceTotal: countQuantity * double.tryParse(model.price)!,
              index: i);
      }
    }
  }

  OrderEntity? orderEntity;

  FutureOr<void> getOrders(NoParameters parameters) async {
    if (token != null) if (await checkConnection()) {
      emit(GetOrdersForUserLoadingState());
      final result = await getOrdersUseCase.call(parameters);
      result.fold(
        (l) {
          emit(GetOrdersForUserErrorState());
        },
        (r) {
          orderEntity = r;
          emit(GetOrdersForUserSuccessState());
        },
      );
    }
  }
  OrderForMoreDetailsEntity? orderForMoreDetailsEntity;
  FutureOr<void> getOrderDetails(int parameter) async {
    if (token != null)
      if (await checkConnection()) {
        emit(GetOrdersForUserDetailsLoadingState());
        final result = await getOrdersDetailsUseCase.call(parameter);
        result.fold(
              (l) {
                emit(GetOrdersForUserDetailsErrorState());
              },
              (r) {
                orderForMoreDetailsEntity=r;
                totalMyOrder();
                emit(GetOrdersForUserDetailsSuccessState());
              },
        );
      }
  }
  double totalOrder = 0.0;

  void totalMyOrder() {
    if (orderForMoreDetailsEntity != null)
      for (int i = 0; i < orderForMoreDetailsEntity!.orders.length; i++) {
        totalOrder =
            totalOrder + double.tryParse(orderForMoreDetailsEntity!.orders[i].sum)!;
      }
  }

}
