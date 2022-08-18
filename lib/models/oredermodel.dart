class OrderModel
{
  bool? status;
  List<Order> order=[];
  OrderModel.fromJson(dynamic json)
  {
    status=json['state'];
    if(json['orders']!=null)
    json['orders'].forEach((element){
      order.add(Order.fromJson(element));
    });
  }
}
class Order
{
  String? idUser;
  String? idBill;
  String? stateOrder;
  String? date;
  String? total;
  Order.fromJson(dynamic json)
  {
    idUser=json['id_user'];
    idBill=json['id_bill'];
    stateOrder=json['state_order'];
    date=json['creation_date'];
    total=json['total'];
  }
}