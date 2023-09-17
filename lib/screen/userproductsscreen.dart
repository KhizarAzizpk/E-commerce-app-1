import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:khaksarfirstapp/screen/addproductscreen.dart';
import 'package:khaksarfirstapp/widgets/drawer.dart';
import 'package:khaksarfirstapp/widgets/userproductitem.dart';

import '../modules/product.dart';



class UserproductScreen extends StatefulWidget {
  const UserproductScreen({Key? key}) : super(key: key);
static const routname='/userproductscreen';
  @override
  _UserproductScreenState createState() => _UserproductScreenState();
}

class _UserproductScreenState extends State<UserproductScreen> {
String? uid;
Future <void>refreshindicator(BuildContext context) async{
await  Provider.of<Products>(context,listen: false).fetchandset();
}
@override
  void didChangeDependencies() {
   uid=FirebaseAuth.instance.currentUser!.uid;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
print(uid);
    final prod=Provider.of<Products>(context).gatmyitems(uid!);
   


    return Scaffold(
      appBar: AppBar(title:Text('Your Products'),
        actions: <Widget>[
          IconButton(onPressed:(){
            Navigator.of(context).pushNamed(addProductScreen.routname);
          }, icon: Icon(Icons.add))
        ],),
  drawer: drawer(),
body:
    RefreshIndicator(
      onRefresh: (){
return refreshindicator(context);
      },
      child: ListView.builder(
       itemCount:prod.length ,

       itemBuilder:(_,i){
        return Column(children: <Widget>[
         UserProductItem(
             prod[i].id,prod[i].title,prod[i].imageUrl),
         Divider()
       ],);}  ,),
    )

    );
  }
}
