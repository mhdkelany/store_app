class CategoriesModel
{
  bool? status;
  String?message;
  List<Data> data=[];
  CategoriesModel.fromJson(dynamic json){
    status=json['state'];
    message=json['message'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}
class Data
{
  String? name;
  dynamic idCate;
  String? image;
  Data.fromJson(dynamic json)
  {
    name=json['name'];
    idCate=json['id_cate'];
    image=json['img'];
  }
}