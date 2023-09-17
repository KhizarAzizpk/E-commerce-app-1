import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/screen/orderScreen.dart';
import 'package:khaksarfirstapp/screen/product_overview_screen.dart';
import 'package:khaksarfirstapp/screen/userproductsscreen.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  String name='';
  String email='';
  String uid ='';
  Future<void> fetchUserData(String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    try {
      DocumentSnapshot snapshot = await users.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
        name = userData!['name'];
         email = userData['email'];
        uid = userData['uid'];
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }


  }

  @override
  Future<void> didChangeDependencies() async {
    String uid= FirebaseAuth.instance.currentUser!.uid;
   await fetchUserData(uid);
print(name);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //surfaceTintColor: ,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name), // Replace with user's name
            accountEmail: Text(email), // Replace with user's email
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person,size: 50,),
            //  backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with user's profile picture
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(35, 180, 185, 1), // Customize the background color
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(context, productoverviewScreen.routname);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routname);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () {
              Navigator.pushReplacementNamed(context, UserproductScreen.routname);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Log out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Log out'),
                      ),
                    ],
                  );
                },
              );
            },
          ),

        ],
      ),
    );

  }
}
