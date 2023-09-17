import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:khaksarfirstapp/widgets/griditems.dart';
class gridview extends StatelessWidget{

var showfavoriteonly;
gridview(this.showfavoriteonly);
  @override
  Widget build(BuildContext context) {

print('build grid view');
   final productdata=Provider.of<Products>(context,listen: false);
   final products= showfavoriteonly? productdata.favitems:productdata.items;
       return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3/2,crossAxisSpacing: 10,mainAxisSpacing: 10),
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (ctx,index){
         return   ChangeNotifierProvider.value(
            value:products[index],
             child: productsitems(),
          );},
        );
     }

  }

