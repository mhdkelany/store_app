class EditProfileModel
{
  bool? status;
  String? token;
  EditProfileModel.fromJson(dynamic json)
  {
    status=json['state'];
    token=json['Authorization'];
  }
}