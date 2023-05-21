import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/models/categories_model.dart';
import 'package:store/models/category_product_model.dart';
import 'package:store/models/change_favorites_model.dart';
import 'package:store/models/edit_profile_model.dart';
import 'package:store/modules/categoryandfavorite/models/favorites_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/models/order_details_model.dart';
import 'package:store/models/oredermodel.dart';
import 'package:store/models/product_for_user_model.dart';
import 'package:store/models/products_cart_model.dart';
import 'package:store/models/search_model.dart';
import 'package:store/models/user_data_model.dart';
import 'package:store/models/wishes_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/screens/categories_screen.dart';
import 'package:store/modules/categoryandfavorite/screens/favorites_screen.dart';
import 'package:store/modules/home/screen/home_screen.dart';
import 'package:store/modules/manage_product/model/sub_category_model.dart';
import 'package:store/modules/profile_screen.dart';
import 'package:store/modules/uploade_wish_screen.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import '../../shared/network/end_point/end_point.dart';
import '../../shared/network/remote/dio_helper.dart';

class StoreAppCubit extends Cubit<StoreAppStates> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectivityStreamSubscription;

  StoreAppCubit() : super(StoreAppInitialState()) {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.none) {
          emit(ConnectionErrorState());
        } else {
          emit(ConnectionSuccessState());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }

  static StoreAppCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(isHome: true),
    UploadWishScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNav(int value, context) {
    if (value == 1) {
      CategoriesAndFavoriteCubit.get(context).getProductIncludeCategory('1');
      selectIndex(0);
    }
    if (value == 3) CategoriesAndFavoriteCubit.get(context).getFavorites();
    if (value == 2)
      emit(OpenWishScreenState());
    else {
      currentIndex = value;
      emit(ChangeBottomNavState());
    }
  }

  int selectedIndex = 0;

  void selectIndex(index) {
    selectedIndex = index;
    emit(SelectedIndexState());
  }

  Map<String, bool> isFavorite = {};

  void getHome() async {
    emit(StoreHomeLoadingState());
    DioHelper.getData(url: HOME, query: {'Authorization': token}).then((value) {
      //write favorite
      homeModel = HomeModel.fromJson(value.data);
      print(value.data);
      emit(StoreHomeSuccessState(homeModel!));
      homeModel!.products.forEach((element) {
        isFavorite.addAll({
          element.idProduct!: element.inFavorites!,
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(StoreHomeErrorState());
    }).timeout(Duration(seconds: 60), onTimeout: () {
      emit(StoreHomeErrorState());
    });
  }

  CacheManager cacheManager = CacheManager(Config('images_key',
      maxNrOfCacheObjects: 20, stalePeriod: Duration(days: 1)));

  void clearCache() {
    imageCache.clear();
    imageCache.clearLiveImages();
    cacheManager.emptyCache();
    emit(ClearFromCacheState());
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isOpenDrawer = false;

  void changeDrawer() {
    if (!isOpenDrawer) {
      xOffset = -50;
      yOffset = 150;
      scaleFactor = 0.6;
      isOpenDrawer = true;
      emit(ChangeDrawerState());
    } else {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isOpenDrawer = false;
      emit(ChangeDrawerState());
    }
  }

  WishesModel? wishesModel;

  void postWishes({required String wish}) async {
    if (await checkConnection()) {
      emit(PostWishLoadingState());
      DioHelper.postData(
          url: WISH,
          data: {'description': wish, 'Authorization': token}).then((value) {
        wishesModel = WishesModel.fromJson(value.data);
        emit(PostWishSuccessState(wishesModel!));
        print(value.data);
      }).catchError((error) {
        emit(PostWishErrorState());
      }).timeout(Duration(seconds: 60), onTimeout: () {
        emit(PostWishErrorState());
      });
    } else {
      emit(CheckSocketState());
    }
  }

  UserInformation? userInformation;

  void getProfile(context) async {
    if (token != null) if (await checkConnection()) {
      try {
        DioHelper.getData(
            url: PROFILE,
            token: token,
            query: {'Authorization': token}).then((value) {
          userInformation = UserInformation.fromJson(value.data);
          print(userInformation!.state);
          if (userInformation!.userType == 0) {
            getProductForUser(context);
            print(userInformation!.lat);
          }
          emit(GetProfileSuccessState());
          if (userInformation!.userType == 1) {
            // getProductIncludeCategory('1');
            getHome();
          }
        }).catchError((error) {
          if (error.type == DioErrorType.connectTimeout) {
            emit(GetProfileErrorState());
          }
          print(error.toString());
          emit(GetProfileErrorState());
        }).timeout(Duration(seconds: 60), onTimeout: () {
          emit(GetProfileErrorState());
        });
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          emit(GetProfileErrorState());
        }
        print(e.toString());
      }
    } else {
      emit(CheckSocketState());
    }
  }

  bool isShow = true;
  IconData icon = Icons.visibility_off_outlined;

  void changeVisibilityPassword() {
    isShow = !isShow;
    icon = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

  EditProfileModel? editProfileModel;

  void editProfile(
      {required String name,
      required String phone,
      required String password,
      required int userType}) async {
    if (await checkConnection()) {
      emit(ChangeProfileLoadingState());
      DioHelper.postData(url: editPROFILE, data: {
        'Authorization': token,
        'name': name,
        'password': password,
        'phone': phone,
        'lat': lat == null ? null : lat,
        'lng': lng == null ? null : lng,
        'user_type': userType
      }).then((value) {
        editProfileModel = EditProfileModel.fromJson(value.data);
        lat = null;
        lng = null;
        emit(ChangeProfileSuccessState(editProfileModel!));
      }).catchError((error) {
        print(error.toString());
        emit(ChangeProfileErrorState());
      }).timeout(Duration(seconds: 60), onTimeout: () {
        emit(ChangeProfileErrorState());
      });
    } else {
      emit(CheckSocketState());
    }
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(String id) {
    isFavorite[id] = !isFavorite[id]!;
    DioHelper.postData(url: CHANGEFAVORITES, data: {
      'Authorization': token,
      'id_pro': id,
      'state': isFavorite[id]
    }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        isFavorite[id] = !isFavorite[id]!;
      } else {}
      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      isFavorite[id] = !isFavorite[id]!;
      emit(ChangeFavoritesErrorState());
    });
  }

  SearchModel? searchModel;

  void searchProducts(String productName) async {
    if (await checkConnection()) {
      DioHelper.postData(url: SEARCH, data: {'product': productName})
          .then((value) {
        searchModel = SearchModel.fromJson(value.data);
        print(value.data);
        emit(SearchProductsSuccessState());
      }).catchError((error) {
        emit(SearchProductsSuccessState());
      });
    } else {
      emit(CheckSocketState());
    }
  }

  dynamic category;
  dynamic subCategory;

  void choiceFromCategory(dynamic value) {
    category = value;
    //emit(ChoiceFromCategory());
  }
  void choiceFromSubCategory(dynamic value) {
    category = value;
    //emit(ChoiceFromCategory());
  }

  var _picker = ImagePicker();
  File? productImage;

  Future<void> choiceImage() async {
    final XFile = await _picker.pickImage(source: ImageSource.gallery);
    if (XFile != null) {
      productImage = File(XFile.path);
      emit(ChoiceImageSuccessState());
    } else {
      print('no image selected');
      emit(ChoiceImageErrorState());
    }
  }

  void removeImage() {
    productImage = null;
    emit(RemoveImageState());
  }

  ProductForUserModel? productForUserModel;

  void getProductForUser(context) {
    emit(GetProductForUserLoadingState());
    DioHelper.postData(url: GET_PRODUCT_FOR_USER, data: {
      'Authorization': token,
    }).then((value) {
      productForUserModel = ProductForUserModel.fromJson(value.data);
      print('${value.data}');
      emit(GetProductForUserSuccessState(productForUserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetProductForUserErrorState());
    });
  }

  void updateProduct({required File? path, required Map data, context}) async {
    if (await checkConnection()) {
      try {
        emit(UpdateProductForUserLoadingState());
        var request = await http.MultipartRequest("POST",
            Uri.parse('https://ibrahim-store.com/api/update_details_pro.php'));
        if (path != null) {
          var length = await path.length();
          var multiPartFile = http.MultipartFile(
              "image", http.ByteStream(path.openRead()), length,
              filename: path.path.split('/').last);
          request.files.add(multiPartFile);
        }
        request.fields['name'] = data['name'];
        request.fields['short_description'] = data['shortDescription'];
        request.fields['long_description'] = data['longDescription'];
        request.fields['price'] = data['price'];
        request.fields['quantity'] = data['quantity'];
        request.fields['Authorization'] = data['token'];
        request.fields['id_cate'] = data['idCategory'];
        request.fields['id_pro'] = data['idProduct'];
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);
        if (myRequest.statusCode == 200) {
          emit(UpdateProductForUserSuccessState());
          getProductForUser(context);
          print(response.body);
          print(jsonDecode(response.body));
          return jsonDecode(response.body);
        } else {
          emit(UpdateProductForUserErrorState());
        }
      } catch (e) {
        emit(UpdateProductForUserErrorState());
        print(e.toString());
      }
    } else {
      emit(CheckSocketState());
    }
    // if(await checkConnection()) {
    //   emit(UpdateProductForUserLoadingState());
    //   DioHelper.putData(
    //       url: UPDATE_PRODUCT_FOR_USER,
    //       data: {
    //         'name': name,
    //         'short_description': shortDescription,
    //         'long_description': longDescription,
    //         'price': price,
    //         'quantity': quantity,
    //         'img': image,
    //         'id_pro': idProduct,
    //         'Authorization': token,
    //       }
    //   ).then((value) {
    //     emit(UpdateProductForUserSuccessState());
    //   }).catchError((error) {
    //     print(error.toString());
    //     emit(UpdateProductForUserErrorState());
    //   });
    // }
    // else
    //   {
    //     emit(CheckSocketState());
    //   }
  }

  bool isNotification = false;
  List<Products> notification = [];

  void getNotification(context) {
    if (StoreAppCubit.get(context).productForUserModel !=
        null) if (productForUserModel!.productForUser.length > 0)
      for (int i = 0; i < productForUserModel!.productForUser.length; i++) {
        print('qun');
        if (productForUserModel!.productForUser[i].quantity == '0') {
          print('qun');
          isNotification = true;
          notification.add(productForUserModel!.productForUser[i]);
          emit(QuantityProductIsEmptyState());
        }
      }
  }

  void insertProduct({required Map data, required File path}) async {
    if (await checkConnection()) {
      emit(InsertProductForUserLoadingState());
      var request = await http.MultipartRequest(
          "POST", Uri.parse('https://ibrahim-store.com/api/add_pro.php'));
      var length = await path.length();
      var multiPartFile = http.MultipartFile(
          "image", http.ByteStream(path.openRead()), length,
          filename: path.path.split('/').last);
      request.files.add(multiPartFile);
      request.fields['name'] = data['name'];
      request.fields['short_description'] = data['shortDescription'];
      request.fields['long_description'] = data['longDescription'];
      request.fields['price'] = data['price'];
      request.fields['quantity'] = data['quantity'];
      request.fields['Authorization'] = data['token'];
      request.fields['id_cate'] = data['idCategory'];

      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      if (myRequest.statusCode == 200) {
        emit(InsertProductForUserSuccessState(productForUserModel!));
        return jsonDecode(response.body);
      } else {
        emit(InsertProductForUserErrorState());
      }
    } else {
      emit(CheckSocketState());
    }
  }

  CameraPosition? kGooglePlex;

  var myMarker = [];
  double? lat;
  double? lng;
  bool isBill = false;

  void changeLocation(CameraPosition position) {
    myMarker.first = myMarker.first.copyWith(positionParam: position.target);
    emit(ChangeLocationState());
  }

  void animateCamera(GoogleMapController controller) {
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex!));
    Marker marker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(userInformation!.lat!, userInformation!.lang!),
      //draggable: true
    );
    myMarker.add(marker);
    emit(AnimateCameraState());
  }

  void initialMap() {
    kGooglePlex = CameraPosition(
        target: LatLng(userInformation!.lat!, userInformation!.lang!),
        zoom: 18.555);

    emit(InitialMapState());
  }

  String key = 'AIzaSyBlZOVy5fanzdlB9Dkb-MQhLrkgZ51TGhI';

  void getPlaceId(String value) {
    Dio dio = Dio();
    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$value&inputtype=textquery&key=$key';
    dio
        .get(
      url,
    )
        .then((value) {
      // print(value.data['candidates'][0]['place_id']as String);
      print(value.data);
      emit(GetPlaceIdSuccessState());
    });
  }

  OrderModel? orderModel;

  void getOrdersForUser() async {
    if (token != null) if (await checkConnection()) {
      emit(GetOrdersForUserLoadingState());
      DioHelper.postData(url: ORDER_USER, data: {'Authorization': token})
          .then((value) {
        orderModel = OrderModel.fromJson(value.data);
        print(value.data);
        emit(GetOrdersForUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetOrdersForUserErrorState());
      });
    }
  }

  OrderDetailsModel? orderDetailsModel;

  void getOrdersForUserDetails(int id) async {
    if (token != null) if (await checkConnection()) {
      emit(GetOrdersForUserDetailsLoadingState());
      DioHelper.postData(
          url: ORDER_DETAILS_USER,
          data: {'Authorization': token, 'id_bill': id}).then((value) {
        orderDetailsModel = OrderDetailsModel.fromJson(value.data);
        totalMyOrder();
        print(value.data);
        emit(GetOrdersForUserDetailsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetOrdersForUserDetailsErrorState());
      });
    }
  }

  double totalOrder = 0.0;

  void totalMyOrder() {
    if (orderDetailsModel != null)
      for (int i = 0; i < orderDetailsModel!.orders.length; i++) {
        totalOrder =
            totalOrder + double.tryParse(orderDetailsModel!.orders[i].sum!)!;
      }
  }

  int selectedIndexForMerchant = 0;

  void changeBottomForMerchant({required int index}) {
    selectedIndexForMerchant = index;
    emit(ChangeBottomForMerchant());
  }

}
//36.2852408
//33.5224673
