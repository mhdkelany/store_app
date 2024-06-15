
import 'package:get_it/get_it.dart';
import 'package:store/modules/auth/data/data_source/auth_data_source.dart';
import 'package:store/modules/auth/data/repo/auth_repo.dart';
import 'package:store/modules/auth/domain/repo/base_auth_repo.dart';
import 'package:store/modules/auth/domain/usecase/login_usecase.dart';
import 'package:store/modules/auth/domain/usecase/register_usecase.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/categoryandfavorite/data/data_source/data_source.dart';
import 'package:store/modules/categoryandfavorite/data/repo/category_and_favoite_repo.dart';
import 'package:store/modules/categoryandfavorite/domain/repo/base_category_and_favorite_repo.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/category_usecase.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_favorite_usecase.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_sub_category_usecase.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/home/data/data_source/home_datasource.dart';
import 'package:store/modules/home/data/repo/home_repo.dart';
import 'package:store/modules/home/domain/repo/base_home_repo.dart';
import 'package:store/modules/home/domain/usecase/change_favorite_usecase.dart';
import 'package:store/modules/home/domain/usecase/get_home_usecase.dart';
import 'package:store/modules/home/domain/usecase/get_home_without_token_usecase.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/manage_product/data/data_source/manage_product_data_source.dart';
import 'package:store/modules/manage_product/data/repo/manage_product_repo.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/edit_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/get_all_own_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/get_own_product_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/post_wish_usecase.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/search_product_usecase.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/maps/presentation/controller/map_cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/order/data/data_source/order_datasource.dart';
import 'package:store/modules/order/data/repo/order_repo.dart';
import 'package:store/modules/order/domain/order_usecase/get_order_details_usecase.dart';
import 'package:store/modules/order/domain/order_usecase/get_orders_usecase.dart';
import 'package:store/modules/order/domain/order_usecase/order_usecase.dart';
import 'package:store/modules/order/domain/repo/base_order_repo.dart';
import 'package:store/modules/profile/data/data_source/profile_data_source.dart';
import 'package:store/modules/profile/data/repo/profile_repo.dart';
import 'package:store/modules/profile/domain/repo/base_profile_repo.dart';
import 'package:store/modules/profile/domain/usecase/edit_profile_usecase.dart';
import 'package:store/modules/profile/domain/usecase/get_profile_usecase.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';

final sl=GetIt.instance;

class ServicesLocator
{
  static void init()
  {
    ///BLoc
    sl.registerFactory(() => AuthCubit(sl(),sl()));
    sl.registerFactory(() => HomeCubit(sl(),sl(),sl()));
    sl.registerFactory(() => FavoriteAndCategoryCubit(sl(),sl(),sl(),sl(),));
    sl.registerFactory(() => ProfileCubit(sl(),sl(),));
    sl.registerFactory(() => ManageProductCubit(sl(),sl(),sl(),sl(),sl(),sl()));
    sl.registerFactory(() => OrderCubit(sl(),sl(),sl()));
    sl.registerFactory(() => MapCubit());

    ///UseCase
    sl.registerLazySingleton(() =>LoginUseCase(sl()));
    sl.registerLazySingleton(() =>RegisterUseCase(sl()));
    sl.registerLazySingleton(() =>CategoryUseCase(sl()));
    sl.registerLazySingleton(() =>GetFavoriteUseCae(sl()));
    sl.registerLazySingleton(() =>GetProductOfCategoryUseCase(sl()));
    sl.registerLazySingleton(() =>GetSubCategoryUseCase(sl()));
    sl.registerLazySingleton(() =>GetHomeUseCase(sl()));
    sl.registerLazySingleton(() =>GetHomeAsGuestUseCase(sl()));
    sl.registerLazySingleton(() =>ChangeFavoriteUseCase(sl()));
    sl.registerLazySingleton(() =>GetProfileUseCase(sl()));
    sl.registerLazySingleton(() =>EditProfileUseCase(sl()));
    sl.registerLazySingleton(() =>AddProductUseCase(sl()));
    sl.registerLazySingleton(() =>EditProductUseCase(sl()));
    sl.registerLazySingleton(() =>GetAllOwnProductUseCase(sl()));
    sl.registerLazySingleton(() =>GetOwnProductUseCase(sl()));
    sl.registerLazySingleton(() =>PostWishUseCase(sl()));
    sl.registerLazySingleton(() =>SearchProductUseCase(sl()));
    sl.registerLazySingleton(() =>OrderUseCase(sl()));
    sl.registerLazySingleton(() =>GetOrderDetailsUseCase(sl()));
    sl.registerLazySingleton(() =>GetOrdersUseCase(sl()));


    ///Repository
    sl.registerLazySingleton<BaseAuthRepo>(() => AuthRepo(sl()));
    sl.registerLazySingleton<BaseCategoryAndFavoriteRepo>(() => CategoryAndFavoriteRepo(sl()));
    sl.registerLazySingleton<BaseHomeRepo>(() => HomeRepo(sl()));
    sl.registerLazySingleton<BaseProfileRepo>(() => ProfileRepo(sl()));
    sl.registerLazySingleton<BaseManageProductRepo>(() => ManageProductRepo(sl()));
    sl.registerLazySingleton<BaseOrderRepo>(() => OrderRepo(sl()));

    ///Data Source
    sl.registerLazySingleton<BaseAuthDataSource>(() =>AuthDataSource());
    sl.registerLazySingleton<BaseCategoryAndFavoriteDataSource>(() =>CategoryAndFavoriteDataSource());
    sl.registerLazySingleton<BaseHomeDataSource>(() =>HomeDataSource());
    sl.registerLazySingleton<BaseProfileDataSource>(() =>ProfileDataSource());
    sl.registerLazySingleton<BaseManageProductDataSource>(() =>ManageProductDataSource());
    sl.registerLazySingleton<BaseOrderDataSource>(() =>OrderDataSource());
  }
}