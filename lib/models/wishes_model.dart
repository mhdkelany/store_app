class WishesModel
{
  bool? status;
  String? message;
  WishesModel.fromJson(dynamic json)
  {
    status=json['state'];
    message=json['message'];
  }
}