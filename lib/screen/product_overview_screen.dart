import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khaksarfirstapp/screen/cart_screen.dart';
import 'package:khaksarfirstapp/widgets/21.1%20badge.dart';
import 'package:khaksarfirstapp/widgets/drawer.dart';
import 'package:khaksarfirstapp/widgets/gridviewproductoverview.dart';
import 'package:khaksarfirstapp/provider/cart.dart';
import 'package:khaksarfirstapp/provider/product.dart';
enum filteroptions{
  fovorite,
  all,

}
class productoverviewScreen extends StatefulWidget{
  static const routname='/productoverviewscreen';
  @override
  _productoverviewScreenState createState() => _productoverviewScreenState();
}

class _productoverviewScreenState extends State<productoverviewScreen> {
var init=false;
  var _isloading = false;

  @override
  void initState() {
    if(init==false) {
      Provider.of<Products>(context, listen: false).fetchandset();
    //init=true;
    }
    super.initState();

  }

@override
  void didChangeDependencies() {
    if(init==false) {
      Provider.of<Products>(context).fetchandset();
      init=true;
    }
    super.didChangeDependencies();
  }





Future <void>refreshindicator(BuildContext context) async{
setState(() {
  Provider.of<Products>(context,listen: false).fetchandset();
});


  }
var showfavoriteonly=false;
  @override
  Widget build(BuildContext context) {
    print('overview build method');
    return
    Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(icon: Icon(Icons.more_vert),
              onSelected: (filteroptions selectedvalue) {
                if (selectedvalue == filteroptions.fovorite) {
                  setState(() {

                    showfavoriteonly = true;
                  });
                }

                else{
                  setState(() {
                    showfavoriteonly = false;
                  });
                }
              },
              itemBuilder: (_) =>
              [
                PopupMenuItem(
                  child: Text('Fovorite'), value: filteroptions.fovorite,),
                PopupMenuItem(child: Text('Show All'), value: filteroptions.all),

              ]),
          Consumer<Cart>(builder: (context,cart,child)=>badge(
            child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routname);
                },
                icon:Icon(Icons.shopping_cart_sharp)),
            value: cart.itemcount.toString(),
          ))

        ],
      ),
      drawer: drawer(),

      body: _isloading?Center(
        child: CircularProgressIndicator(),
      ) :gridview(showfavoriteonly),
    );
  }
}
