import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier{
  String id;
  String title;
  String imageUrl;
  double price;
  String description;
  String uid;
  bool isfavorite;
  bool iscart;
  Product({required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isfavorite,
    required this.uid,
  this.iscart=false});

  void oldstatusf(bool oldst){
    isfavorite=oldst;
    notifyListeners();
  }

Future <void> togglefavorite() async{
  var oldstatus = isfavorite;
  isfavorite = !isfavorite;
 /* final url='https://flutterfirst-17528-default-rtdb.firebaseio.com/$id.json';


 try {
   final response = await http.patch(Uri.parse(url), body: json.encode({
     'isfavorite': isfavorite
   }));

   if (response.statusCode>=400) {
oldstatusf(oldstatus);
   }
 }
catch(error){
   isfavorite=oldstatus;
   notifyListeners();
}*/
  notifyListeners();
}
  void togglecart(){
    iscart=true;
    notifyListeners();
  }

}
