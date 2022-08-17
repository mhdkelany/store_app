class RegisterModel
{
  bool?  state;
  String ?message;
  RegisterModel.fromJson(dynamic json)
  {
    state=json['state'];
    message=json['message'];
    //data=json['data']!=null? UserInformation.fromJson(json['data']): null;
  }
}