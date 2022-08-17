class OrderDetailsModel
{
  bool ?status;
  List<Orders>orders=[];
  OrderDetailsModel.fromJson(dynamic json)
  {
    status=json['state'];
    json['orders'].forEach((element){
      orders.add(Orders.fromJson(element));
    });
  }
}
class Orders
{
  String? name;
  String? sum;
  String? quantity;
  String? idBill;
  Orders.fromJson(dynamic json)
  {
    name=json['name'];
    sum=json['sum'];
    quantity=json['quantity'];
    idBill=json['id_bill'];
  }
}