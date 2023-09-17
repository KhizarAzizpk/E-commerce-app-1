import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/provider/order.dart';
import 'package:khaksarfirstapp/widgets/Orderitem.dart';
import 'package:khaksarfirstapp/widgets/drawer.dart';
class OrderScreen extends StatelessWidget {
static const routname='/orderscreen';
  @override
  Widget build(BuildContext context) {
   final orderdata=Provider.of<Order>(context);
    return Scaffold(
    appBar: AppBar(title: Text('Your Orders')),
drawer: drawer(),
body: ListView.builder(itemCount:orderdata.order.length ,itemBuilder:(context,i)=>
orderItemw(orderdata.order[i]),
),
    );
  }
}
