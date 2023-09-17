import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khaksarfirstapp/provider/cart.dart';
import 'package:khaksarfirstapp/provider/order.dart';
import 'package:khaksarfirstapp/widgets/Cart_Item.dart'as ci;
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
static const routname='/cartscreen';

  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Order>(context,listen: false);
  final cart=Provider.of<Cart>(context);
  cart.fetchCartAndSet();
    return Scaffold(
      appBar: AppBar(title: Text('Cart'),),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total',style:TextStyle(fontSize: 20),),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text('${cart.total.toStringAsFixed(2)}',
                      style: TextStyle(color:Colors.white,fontSize:16 ),
                    ),
                  ),
                  TextButton(onPressed: (){
                   data.addorder(cart.items.values.toList(), cart.total);
                    cart.clearcart();

                  }, child: Text('Order Now',
                    style: TextStyle(
                        fontSize: 18,color: Theme.of(context).primaryColor),))
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(itemCount: cart.itemcount,itemBuilder:(ctx,indx)=>
                 ci.Cartitem(
                      cart.items.values.toList()[indx].id,
                      cart.items.keys.toList()[indx],
                      cart.items.values.toList()[indx].price,
                      cart.items.values.toList()[indx].title,
                      cart.items.values.toList()[indx].quantity
                  ),
              )
          ),
        ],
      ),
    );
  }
}
