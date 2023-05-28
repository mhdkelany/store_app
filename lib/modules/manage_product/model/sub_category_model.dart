class SubCategoryModel
{
  late String message;
  late bool status;
  List<DataOfSubCategory> dataOfSubCategory=[];
  SubCategoryModel.fromJson(Map<String,dynamic> json)
  {
    message=json['message'];
    status=json['state'];
    if(json['data']!=null)
    json['data'].forEach((element){
      dataOfSubCategory.add(DataOfSubCategory.fromJson(element));
    });
  }
}
class DataOfSubCategory
{
  late String name;
  late String id;
  late String image;
  DataOfSubCategory.fromJson(Map<String,dynamic> json)
  {
    name=json['name'];
    id=json['id_cate'];
    image=json['img'];
  }
}