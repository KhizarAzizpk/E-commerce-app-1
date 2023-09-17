import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/provider/product.dart';
import 'package:khaksarfirstapp/screen/addproductscreen.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
final String title;
final String imgurl;
final String id;
const UserProductItem(this.id,this.title,this.imgurl, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imgurl),),
      trailing: Container(
        width: 100,
        child:Row(
          children: <Widget>[
            IconButton(onPressed:(){

              Navigator.of(context).pushNamed(addProductScreen.routname,arguments: id);
            }, icon: Icon(Icons.edit,color: Colors.lightGreen,)),
            IconButton(onPressed:(){
              Provider.of<Products>(context,listen: false).deleteproduct(id);
            }, icon: Icon(Icons.delete,color: Theme.of(context).errorColor,)),
          ],
        ),
      ) ,
    );
  }
}
