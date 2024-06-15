import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/profile/domain/entity/edit_profie_entity.dart';
import 'package:store/modules/profile/domain/usecase/edit_profile_usecase.dart';
import 'package:store/modules/profile/domain/usecase/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final EditProfileUseCase editProfileUseCase;
  ProfileCubit(this.getProfileUseCase,this.editProfileUseCase) : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);
  UserEntity ?userInformation;
  Future<void> getProfile(NoParameters noParameters,BuildContext context) async {
    final result = await getProfileUseCase.call(noParameters);
    result.fold(
      (l) {
        emit(GetProfileErrorState());
      },
      (r) {
        userInformation=r;
        if(userInformation!.userType==0)
          {
            ManageProductCubit.get(context).getAllOwnProduct(NoParameters());
            ManageProductCubit.get(context).getProductForUser(context, isRefresh: true);
          }
        emit(GetProfileSuccessState());
        if(userInformation!.userType==1){
          HomeCubit.get(context).getHome(isRefresh: true);
          emit(GetProfileSuccessState());
        }
      },
    );
  }
   EditProfileEntity? editProfileEntity;
  FutureOr<void> editProfile(EditProfileParameters parameters)async
  {
    emit(ChangeProfileLoadingState());
    final result=await editProfileUseCase.call(parameters);
    result.fold((l) {
      emit(ChangeProfileErrorState());
    }, (r) {
      editProfileEntity=r;
      emit(ChangeProfileSuccessState(editProfileEntity!));
    });
  }
  void removeState() {
    emit(ProfileRemoveState());
  }

}
