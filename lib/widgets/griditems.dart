import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khaksarfirstapp/provider/cart.dart';
import 'package:khaksarfirstapp/widgets/products_detail_screen.dart';
import 'package:khaksarfirstapp/modules/product.dart';
import '../provider/product.dart';

class productsitems extends StatefulWidget {
productsitems();

  @override
  _productsitemsState createState() => _productsitemsState(
}

class _productsitemsState extends State<productsitems> {

  void updatefav(String id,Product newP){
    Provider.of<Products>(context,listen:false).updateproductfav(id, newP);
  }

  @override
  Widget build(BuildContext context) {
    final productdata=Provider.of<Product>(context,listen: false);
    final cart=Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(

        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(productdetailscreen.routname,arguments: productdata.id);
          },
          child: Image.network(
              productdata.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context,child,progress){
            return progress==null?child:CircularProgressIndicator(
              color:Theme.of(context).indicatorColor,

              backgroundColor: Colors.blue,value: 0.3,);
          }),),
        footer: GridTileBar(
          leading: Consumer<Product>(builder: (context,productdatac,child)=>

          IconButton(
              onPressed: (){
                 productdatac.togglefavorite();
print(productdatac.id+ productdatac.isfavorite.toString());
 updatefav(productdatac.id, productdatac);
              },
              color: Theme.of(context).accentColor,
              icon: Icon(
                  productdatac.isfavorite?  Icons.favorite
                      :Icons.favorite_border)),
          ),
          backgroundColor: Colors.black54,
          title: Text(productdata.title,textAlign: TextAlign.center,),
          trailing:Consumer<Product>(builder: (context,productdatacart,child)=>IconButton(
              onPressed: (){
                cart.addItem(productdata.id, productdata.title, productdata.price, 1);
                productdatacart.togglecart();
              },color: Theme.of(context).accentColor,
              icon: Icon(
                  productdatacart.iscart?Icons.shopping_cart_sharp:Icons.add_shopping_cart)),),
        ),
      ) ,
    );
  }


}
