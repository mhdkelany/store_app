class CartProducts
{
  int ?quantityProduct;
  String? idProduct;
  dynamic? price;
  dynamic? result;
  String? productName;
  dynamic? quantity;
  String? image;
  CartProducts({
    this.result,
    this.idProduct,
     this.image,
     this.price,
     this.productName,
     this.quantity,
    this.quantityProduct
  });
  CartProducts.fromJson(dynamic json)
  {
   // json['idProduct']=idProduct;
    idProduct=json['id_pro'];
    productName=json['name'];
    quantity=json['quantity'];
    image=json['image'];
    price=json['price'];
  }

  Map<String,dynamic> toJson()
  {
    return{
      'id_pro':idProduct,
      'price':result,
      'quantity':quantity
    };
  }
}
