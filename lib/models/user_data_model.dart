class UserModel
{
  bool ?status;
  UserDataModel ?userDataModel;
  UserModel.fromJson(dynamic json)
  {
    status=json['status'];
    userDataModel=UserDataModel.fromJson(json);
  }
}

class UserDataModel
{
 bool ? status;
 bool ? statusProfile;
  String ?message;
  //UserInformation? data;
  int? id;
  dynamic lang;
  dynamic lat;
  String? name;
  String? phone;
  String? email;
  String? token;
  String? address;
  dynamic userType;
  UserDataModel.fromJson(dynamic json)
  {
    if(json['state']!=null)
    status=json['state'];
    if(json['state_profile']!=null)
    statusProfile=json['state_profile'];
    message=json['message'];
    id=json['id'];
    lang=json['lng'];
    lat=json['lat'];
    name=json['name'];
    phone=json['phone'];
    token=json['token'];
    address=json['address'];
    email=json['email'];
    userType=json['user_type'];
    //data=json['data']!=null? UserInformation.fromJson(json['data']): null;
  }
}
class UserInformation
{
  String? id;
  double? lang;
  double? lat;
  String? name;
  String? phone;
  String? email;
  String? address;
  bool? state;
  int? userType;
  UserInformation.fromJson(dynamic json)
  {
  //  id=json['id'];
    lang=json['lng'];
    lat=json['lat'];
    name=json['name'];
    phone=json['phone'];
    address=json['address'];
    email=json['email'];
    state=json['state'];
    userType=json['user_type'];
  }
}