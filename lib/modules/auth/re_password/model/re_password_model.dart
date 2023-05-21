class RePasswordModel
{
  bool? status;
  String? message;
  RePasswordModel.fromJson(Map<String, dynamic> json)
  {
    status=json['state'];
    message=json['message'];
  }

}