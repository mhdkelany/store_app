class HomeModel
{
  bool? status;
  bool? statusProfile;
  String? message;
  List<Products>products=[];
  //List<Products>productForUser=[];
  List<Products> top=[];
  List<Products>cat=[];
  List<Banners>banners=[];
  HomeModel.fromJson(dynamic json)
  {
    if(json['state']!=null)
     status=json['state'];
     if(json['state_profile']!=null)
     statusProfile=json['state_profile'];
    message=json['message'];
     if(json['data']!=null)
       json['data'].forEach((element)
       {
         cat.add(Products.fromJson(element));
       });
    if(json['products']!=0)
    json['products'].forEach((element)
    {
      products.add(Products.fromJson(element));
    });

     if(json['top']!=0)
     json['top'].forEach((element)
     {
       top.add(Products.fromJson(element));
     });
    //products= List<Products>.from(json["products"].map((x) => Products.fromJson(x)));
     if(json['banner']!=0)
    json['banner'].forEach(( element)
    {
      banners.add(Banners.fromJson(element));
    });
  }
  HomeModel.fromJsonWithout(dynamic json)
  {
    if(json['state']!=null)
      status=json['state'];
    if(json['state_profile']!=null)
      statusProfile=json['state_profile'];
    message=json['message'];
    if(json['data']!=null)
      json['data'].forEach((element)
      {
        cat.add(Products.fromJson(element));
      });
    if(json['products']!=0)
      json['products'].forEach((element)
      {
        products.addAll(Products.fromJson(element) as Iterable<Products>);
      });

    if(json['top']!=0)
      json['top'].forEach((element)
      {
        top.addAll(Products.fromJson(element)as Iterable<Products>);
      });
    //products= List<Products>.from(json["products"].map((x) => Products.fromJson(x)));
    if(json['banner']!=0)
      json['banner'].forEach(( element)
      {
        banners.add(Banners.fromJson(element));
      });
  }
}
class Products
{
  String? idProduct;
  String? name;
  String? shortDescription;
  String? longDescription;
  dynamic price;
  dynamic quantity;
  String? discount;
  String? image;
  dynamic inFavorites;
  Products.fromJson(dynamic json)
  {
    name=json['name'];
    idProduct=json['id_pro'];
    shortDescription=json['short_description'];
    longDescription=json['long_description'];
    price=json['price'];
    quantity=json['quantity'];
    discount=json['discount'];
    image=json['img'];
    inFavorites=json['isfav'];
  }
}
class Banners
{
  String? idBanner;
  String? image;
  Banners.fromJson(dynamic json)
  {
    idBanner=json['id_banner'];
    image=json['img'];
  }
}
