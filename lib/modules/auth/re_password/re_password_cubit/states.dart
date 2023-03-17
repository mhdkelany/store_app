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
class RePasswordVerifiedPhoneNumberErrorState extends RePasswordStates{}


class RePasswordAuthPhoneLoadingState extends RePasswordStates{}
class RePasswordAuthPhoneErrorState extends RePasswordStates{}
class RePasswordAuthPhoneSuccessState extends RePasswordStates{}