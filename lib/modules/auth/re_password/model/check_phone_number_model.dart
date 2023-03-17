class CheckPhoneNumberModel
{
  bool? status;
  String? message;
 CheckPhoneNumberModel.fromJson(Map<String, dynamic> json)
 {
   status=json['state'];
   message=json['message'];
 }

}