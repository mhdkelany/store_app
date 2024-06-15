part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends AuthState {
  final UserEntity userEntity;

  LoginSuccessState(this.userEntity);

  @override
  List<Object> get props => [];
}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class LoginChangePasswordVisibilityState extends AuthState {
  @override
  List<Object> get props => [];
}

class RemoveState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginLocationState extends AuthState {

  @override
  List<Object> get props => [];
}

class LoginLocationOpenState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends AuthState {
  final RegisterEntity registerEntity;

  RegisterSuccessState(this.registerEntity);

  @override
  List<Object> get props => [registerEntity];
}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class RegisterCheckConnectionState extends AuthState {
  @override
  List<Object> get props => [];
}

class ChangeBottomSheetState extends AuthState {
  @override
  List<Object> get props => [];
}

class ChangePasswordVisibilityState extends AuthState {
  @override
  List<Object> get props => [];
}
class GetCurrentAddressSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}
class GetCurrentAddressErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterChangeMarkerState extends AuthState {
  @override
  List<Object> get props => [];
}

class ChangeLocationState extends AuthState {
  @override
  List<Object> get props => [];
}

class GetCurrentLocationSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}
class GetCurrentLocationErrorState extends AuthState {
  @override
  List<Object> get props => [];
}