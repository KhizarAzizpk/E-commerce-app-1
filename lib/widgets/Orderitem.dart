import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/provider/order.dart';
import 'package:intl/intl.dart';

class orderItemw extends StatefulWidget {
  final OrderItem orderItem;
  orderItemw(this.orderItem);
  @override
  _orderItemwState createState() => _orderItemwState();
}

class _orderItemwState extends State<orderItemw> {
 var _expand=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.orderItem.amount.toString(),),
            subtitle: Text(DateFormat.yMMMd().format( widget.orderItem.datatime)),
trailing: IconButton(icon: Icon(!_expand?Icons.expand_more:Icons.expand_less),onPressed: (){
  setState(() {
    _expand=!_expand;
  });
},),
          ),
          if(_expand)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.orderItem.products.length*20.0+10,180),
              child: ListView(
                children: widget.orderItem.products.map((e) =>

                    Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(e.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                    Text('${e.quantity}x \$${e.price}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                  ],

                )).toList(),
            ),
            ),
    ]
    ),
    );
  }
}
