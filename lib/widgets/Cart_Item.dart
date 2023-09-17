import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khaksarfirstapp/provider/cart.dart';
import 'package:provider/provider.dart';
class Cartitem extends StatelessWidget {
 final String id;
 final String pid;
final double price;
final String title;
final int quantity;
  Cartitem(
    this.id,
    this.pid,
    this.price,
    this.title,
    this.quantity);
  @override
  Widget build(BuildContext context) {
   final cart=Provider.of<Cart>(context,listen: false);
    return Dismissible(key: ValueKey(id),
        direction: DismissDirection.endToStart,
        background: Container(
           margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(8),
      color: Theme.of(context).errorColor,
       child:IconButton(icon: Icon(
           Icons.delete,size: 40,color:Colors.white),
         onPressed: (){
         cart.deletecart(pid);
         },alignment: Alignment.centerRight,),
           ),
        confirmDismiss: (direction){
return      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: Text('Are you sure'),
        content: Text('Do you want to remove item from the Cart'),
        actions: <Widget>[
          TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: Text('Yes')),
          TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text('NO')),
        ],
      ));
        },
        onDismissed: (dimension){
cart.deletecart(pid);

    },
        child:Card(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      child: Padding(padding: EdgeInsets.only(right:8),
        child: ListTile(
          leading: CircleAvatar(maxRadius:23,child:FittedBox(child:Text('\$${price}') ,) ),
          title: Text(title),
          subtitle: Text('Total\$${(price*quantity).toStringAsFixed(2)}'),
          trailing: Text('$quantity x'),

        ),
      ),
    ));
  }
}
