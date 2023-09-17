import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
class CartItem with ChangeNotifier{
final String id;
final String title;
final int quantity;
final double price;

CartItem({required this.id,
  required this.title,
  required this.quantity,
  required this.price});
}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items={};

Map<String,CartItem> get items{
  return {..._items};
}
void addItem(String productId,String title,double Price,int Quantity){
  String uid= FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection('Cart').doc('products').collection(uid);

  try{
    users.add({
      'id':productId,
      'title':title,
      'price':Price,
      'quantity':Quantity,
    }).then((value) {
      print("Data set successfully!");
    }).catchError((error) {
      print("Failed to set data: $error");
    });

    if(_items.containsKey(productId)){
      _items.update(productId, (existingitem) => CartItem(id:existingitem.id,
          title: existingitem.title,
          quantity:existingitem.quantity+1, price: existingitem.price));
    }
    else{
      _items.putIfAbsent(productId, ()=>CartItem(id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: Price));
    }
    notifyListeners();
  }
  catch (error){
    throw error;

  }
  if(_items.containsKey(productId)){
_items.update(productId, (existingitem) => CartItem(id:existingitem.id,
    title: existingitem.title,
    quantity:existingitem.quantity+1, price: existingitem.price));
  }
  else{
    _items.putIfAbsent(productId, ()=>CartItem(id: DateTime.now().toString(),
        title: title,
        quantity: 1,
        price: Price));
  }
notifyListeners();
}

  Future<void> fetchCartAndSet() async {
    try {

      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Query the Firestore collection to retrieve cart items for the current user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.
      collection('Cart').doc('products').collection(uid)
          .get();

      Map<String, CartItem> loadedProducts = {};

      // Iterate over each document in the query snapshot
      for (var doc in querySnapshot.docs) {

        // Retrieve the data of the document as a Map
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;

        // Create a CartItem object using the retrieved data
        CartItem cartItem = CartItem(
          id: productData['id'],
          title: productData['title'],
          price: productData['price'],
          quantity: productData['quantity'],
        );

        // Add the CartItem object to the loadedProducts map using its ID as the key
        loadedProducts[cartItem.id] = cartItem;

      }

      // Update the _items list with the loadedProducts map
      _items = loadedProducts;
      //print(loadedProducts);
      notifyListeners();
    } catch (error) {
      throw ('Error fetching and setting cart items: $error');
    }
  }

int get itemcount{
  return _items==null ? 0 : _items.length;

}
double get total{
var totalsum=0.0;
_items.forEach((key, value) {
 totalsum+=value.price*value.quantity;
});

  return totalsum;
}
void deletecart(String id){
  _items.remove(id);
  notifyListeners();
}

void removesinglecart(String productid){
  if(!_items.containsKey(productid)){
    return;

  }
  else if(_items.containsKey(productid as int >  1)){
    _items.update(productid, (existingitem) => CartItem(
        id: existingitem.id,
        title: existingitem.title,
        quantity: existingitem.quantity-1,
        price: existingitem.price));
  }
  else{

    _items.remove(productid);
  }

}

void clearcart(){
  _items={};
  notifyListeners();
}

}