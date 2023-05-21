import 'package:store/modules/auth/re_password/model/check_phone_number_model.dart';

abstract class RePasswordStates {}
class RePasswordInitState extends RePasswordStates {}

class RePasswordCheckPhoneNumberSuccessState extends RePasswordStates
{
  CheckPhoneNumberModel checkPhoneNumberModel;
  RePasswordCheckPhoneNumberSuccessState(this.checkPhoneNumberModel);
}
class RePasswordCheckPhoneNumberErrorState extends RePasswordStates
{
  String message;
  RePasswordCheckPhoneNumberErrorState(this.message);
}
class RePasswordCheckPhoneNumberLoadingState extends RePasswordStates{}

class RePasswordVerifiedPhoneNumberLoadingState extends RePasswordStates{}
class RePasswordVerifiedPhoneNumberSuccessState extends RePasswordStates{}
class RePasswordVerifiedPhoneNumberErrorState extends RePasswordStates
{
  String error;
  RePasswordVerifiedPhoneNumberErrorState(this.error);
}
class RePasswordVerifiedPhoneNumberWrongState extends RePasswordStates
{
  String error;
  RePasswordVerifiedPhoneNumberWrongState(this.error);
}


class RePasswordAuthPhoneLoadingState extends RePasswordStates{}
class RePasswordAuthPhoneErrorState extends RePasswordStates
{
  String error;
  RePasswordAuthPhoneErrorState(this.error);
}
class RePasswordAuthPhoneSuccessState extends RePasswordStates{}

class RePasswordSuccessState extends RePasswordStates{}
class RePasswordErrorState extends RePasswordStates
{
  String errorMessage;
  RePasswordErrorState(this.errorMessage);
}
class RePasswordLoadingState extends RePasswordStates{}