part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileSuccessState extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileErrorState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileRemoveState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ChangeProfileErrorState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ChangeProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ChangeProfileSuccessState extends ProfileState {
  final EditProfileEntity editProfileEntity;

  ChangeProfileSuccessState(this.editProfileEntity);

  @override
  List<Object> get props => [];
}