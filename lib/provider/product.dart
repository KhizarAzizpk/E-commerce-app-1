import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/modules/product.dart';
import 'package:http/http.dart' as http;
class Products with ChangeNotifier{
List <Product> _items=[];
List <Product> get items{
  return [..._items];
}
List<Product> gatmyitems(String uid){

  return [..._items.where((element) => element.uid==uid)];
}
List<Product> get favitems{
  return _items.where((element) => element.isfavorite).toList();
}
Product findbyid(String id){
  return _items.firstWhere((element) => element.id==id);
}




Future<void> fetchandset() async{
  String uid= FirebaseAuth.instance.currentUser!.uid;
try {

  QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection('products').get();

  final List <Product> loadedproducts=[];

  // Retrieve all documents in the collection

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> productdata=doc.data() as Map<String,dynamic>;
      if (productdata.containsKey(uid)) {
        loadedproducts.add(Product(
            id: doc.id,
            title: productdata['title'],
            description: productdata['description'],
            imageUrl: productdata['imageurl'],
            price: productdata['price'],
            isfavorite: productdata[uid],
            uid: productdata['uid']

        ));
      } else {
        loadedproducts.add(Product(
        id: doc.id,
        title: productdata['title'],
        description: productdata['description'],
        imageUrl: productdata['imageurl'],
        price: productdata['price'],
        isfavorite: productdata['isfavorite'],
        uid: productdata['uid']

        ));
      }


    }

_items=loadedproducts;
notifyListeners();
}
catch(error){
  throw ('error fetch and set -=====$error');
}
}


Future<void> addproduct(Product product)async {
 String uid= FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection('products');

  try{
    users.add({
      'title':product.title,
      'description':product.description,
      'imageurl':product.imageUrl,
      'price':product.price,
      'isfavorite':product.isfavorite,
      'uid':uid,
    }).then((value) {
      print("Data set successfully!");
    }).catchError((error) {
      print("Failed to set data: $error");
    });

  final newProduct=Product(
  id: json.decode(users.id),
  title: product.title,
  description:product.description,
  imageUrl: product.imageUrl,
  price:product.price,
    isfavorite: product.isfavorite,
      uid: product.uid,
  );
  _items.add(newProduct);
  notifyListeners();
}
catch (error){
    throw error;

}
}
Future<void> updateproduct(String id,Product newproduct) async{

  final productindex=  _items.indexWhere((element) => element.id==id);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get a reference to the document
  DocumentReference userRef = firestore.collection('products').doc(id);

  // Update the document
  userRef.update({
    'title':newproduct.title,
    'description':newproduct.description,
    'price':newproduct.price,
    'imageurl':newproduct.imageUrl,
  }).then((_) {
    print("Document updated successfully!");
  }).catchError((error) {
    print("Failed to update document: $error");
  });
_items[productindex]=newproduct;

notifyListeners();
}



void deleteproduct(String id){
  final existingproductindex=_items.indexWhere((element) => element.id==id);
  var existingproduct=_items[existingproductindex];
  _items.removeAt(existingproductindex);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get a reference to the document
  DocumentReference userRef = firestore.collection('products').doc(id);

  // Delete the document
  userRef.delete().then((_) {
    print("Document deleted successfully!");
  }).catchError((error) {
    print("Failed to delete document: $error");
  });
  notifyListeners();
}

Future<void> updateproductfav(String id,Product newproduct) async{
  String uid= FirebaseAuth.instance.currentUser!.uid;
  final productindex=  _items.indexWhere((element) => element.id==id);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get a reference to the document
  DocumentReference userRef = firestore.collection('products').doc(id);

  // Update the document
  userRef.update({
     uid:newproduct.isfavorite
  }).then((_) {
    print("Document updated successfully!");
  }).catchError((error) {
    print("Failed to update document: $error");
  });
  _items[productindex]=newproduct;

  notifyListeners();
}
Future<void> addComment(String id, String comment) async {
  print(id);
  String? email = FirebaseAuth.instance.currentUser!.email;
  final productindex = _items.indexWhere((element) => element.id == id);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get a reference to the document
  DocumentReference productRef = firestore.collection('products').doc(id);

  // Update the document
  productRef.update({
    'comments.${email}': comment,
  }).then((_) {
    print("Document updated successfully!");
  }).catchError((error) {
    print("Failed to update document: $error");
  });

  notifyListeners();
}

Future<Map<String, String>> getComments(String id) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get a reference to the document
  DocumentReference productRef = firestore.collection('products').doc(id);

  // Retrieve the document
  DocumentSnapshot snapshot = await productRef.get();

  // Check if the document exists and contains the 'comments' field
  if (snapshot.exists) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('comments')) {
      Map<String, dynamic> commentsData = data['comments'];
      Map<String, String> comments = {};

      commentsData.forEach((key, value) {
        if (value is Map<String, dynamic> &&
            value.containsKey('com') &&
            value['com'] is String) {
          comments[key] = value['com'];
        }
      });

      return comments;
    }
  }

  // Return an empty map if there are no comments or the document doesn't exist
  return {};
}






}