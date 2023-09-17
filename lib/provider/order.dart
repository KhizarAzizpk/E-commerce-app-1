import 'package:flutter/cupertino.dart';
import 'package:khaksarfirstapp/provider/cart.dart';

class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datatime;
  OrderItem({
  required  this.id,
  required  this.amount,
  required  this.products,
  required  this.datatime
  });
}

class Order with ChangeNotifier{
List<OrderItem> _order=[];
List<OrderItem> get order{
  return [..._order ];
}
void addorder(List<CartItem>cartproducts,double total){
  _order.insert(0, OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      products:cartproducts,
      datatime: DateTime.now()
  )
  );
  notifyListeners();
}

}