import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/entity/search_product_entity.dart';
import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/edit_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/get_all_own_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/get_own_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/post_wish_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/search_product_usecase.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_state.dart';
import 'package:store/shared/components/constansts/constansts.dart';

class ManageProductCubit extends Cubit<ManageProductState> {
  final GetOwnProductUseCase getOwnProductUseCase;
  final AddProductUseCase addProductUseCase;
  final EditProductUseCase editProductUseCase;
  final PostWishUseCase postWishUseCase;
  final GetAllOwnProductUseCase getAllOwnProductUseCase;
  final SearchProductUseCase searchProductUseCase;

  ManageProductCubit(
      this.getOwnProductUseCase,
      this.addProductUseCase,
      this.editProductUseCase,
      this.postWishUseCase,
      this.getAllOwnProductUseCase,
      this.searchProductUseCase)
      : super(ManageProductInitial());

  static ManageProductCubit get(BuildContext context) =>
      BlocProvider.of(context);
  var _picker = ImagePicker();
  File? productImage;

  Future<void> choiceImage() async {
    final XFile = await _picker.pickImage(source: ImageSource.gallery);
    if (XFile != null) {
      productImage = File(XFile.path);
      emit(ChoiceImageSuccessState());
    } else {
      emit(ChoiceImageErrorState());
    }
  }

  void removeImage() {
    productImage = null;
    emit(RemoveImageState());
  }

  int currentPageForUser = 1;
  OwnProductEntity? productForUserModel;

  FutureOr<void> getProductForUser(BuildContext context,
      {bool isRefresh = false}) async {
    final result = await getOwnProductUseCase.call(currentPageForUser);
    result.fold((l) {
      emit(GetProductForUserErrorState());
    }, (r) {
      if (isRefresh) {
        productForUserModel = r;
        emit(GetProductForUserSuccessState(productForUserModel!));
      } else if (productForUserModel!.productForUser.length >= 10) {
        productForUserModel!.productForUser.addAll(r.productForUser);
        emit(GetProductForUserSuccessState(productForUserModel!));
      }
      if (productForUserModel!.productForUser.length >= 10)
        currentPageForUser++;
    });
  }

  FutureOr<void> insertProduct(AddProductParameters parameters) async {
    emit(InsertProductForUserLoadingState());
    if (await checkConnection()) {
      final result = await addProductUseCase.call(parameters);
      result.fold(
        (l) {
          emit(InsertProductForUserErrorState());
        },
        (r) {
          productForUserModel = r;
          emit(InsertProductForUserSuccessState(productForUserModel!));
        },
      );
    }
  }

  UpdateProductEntity? updateProductEntity;

  FutureOr<void> updateProduct(AddProductParameters parameters) async {
    emit(UpdateProductForUserLoadingState());
    if (await checkConnection()) {
      final result = await editProductUseCase.call(parameters);
      result.fold(
        (l) {
          emit(UpdateProductForUserErrorState());
        },
        (r) {
          updateProductEntity = r;
          productForUserModel = null;
          currentPageForUser = 1;
          getProductForUser(parameters.context, isRefresh: true);
          emit(UpdateProductForUserSuccessState(updateProductEntity!));
        },
      );
    }
  }

  UpdateProductEntity? postWishModel;

  FutureOr<void> postWish(String parameters) async {
    emit(PostWishLoadingState());
    if (await checkConnection()) {
      final result = await postWishUseCase.call(parameters);
      result.fold(
        (l) {
          emit(PostWishErrorState());
        },
        (r) {
          postWishModel = r;
          emit(PostWishSuccessState(postWishModel!));
        },
      );
    }
  }

  bool isNotification = false;
  List<Product> notification = [];

  void getNotification(context) {
    if (productForUserModel !=
        null) if (productForUserModel!.productForUser.length > 0)
      for (int i = 0; i < productForUserModel!.productForUser.length; i++) {
        if (productForUserModel!.productForUser[i].quantity == '0') {
          isNotification = true;
          notification.add(productForUserModel!.productForUser[i]);
          emit(QuantityProductIsEmptyState());
        }
      }
  }

  OwnProductEntity? productForUserAllModel;

  FutureOr<void> getAllOwnProduct(NoParameters noParameters) async {
    emit(GetProductForUserAllLoadingState());
    if (await checkConnection()) {
      final result = await getAllOwnProductUseCase.call(noParameters);
      result.fold(
        (l) {
          emit(GetProductForUserAllErrorState());
        },
        (r) {
          productForUserAllModel = r;
          emit(GetProductForUserAllSuccessState(productForUserAllModel!));
        },
      );
    }
  }

  List<Product> searchForUser = [];

  void searchOnProductOfUser(String value) {
    searchForUser = productForUserAllModel!.productForUser
        .where((element) => element.name!.startsWith(value))
        .toList();
    emit(SearchForUserState());
  }

  bool isSearching = false;

  Widget appBar(BuildContext context) {
    if (isSearching) {
      return IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          _clearText();
          Navigator.pop(context);
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          startSearch(context);
        },
      );
    }
  }

  void startSearch(BuildContext context) {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _clearText),
    );
    isSearching = true;
    emit(StartSearchingState());
  }

  TextEditingController textEditingController = TextEditingController();

  void _clearText() {
    textEditingController.clear();
    isSearching = false;
    emit(ClearTextState());
  }
  SearchProductEntity? searchModel;
  FutureOr<void> searchProduct(String parameter) async {
    if (await checkConnection()) {
      final result = await searchProductUseCase.call(parameter);
      result.fold(
            (l) {
              emit(SearchProductsErrorState());
            },
            (r) {
              searchModel=r;
              emit(SearchProductsSuccessState());
            },
      );
    }
  }
}
