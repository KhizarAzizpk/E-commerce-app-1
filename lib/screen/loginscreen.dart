import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  var toggleObscure=true;
  void save() {
    // Perform sign-up logic here
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    if(togglelogin){
      signUp(email, password);
    }
    else{
      signIn(email, password);
    }
    // Add your sign-up implementation
    // e.g., call an API or register the user in Firebase
  }

var togglelogin=true;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      // User sign-up successful


        await users.doc(user!.uid).set({
          'name': nameController.text,
          'email': user.email,
          'uid': user.uid,
        });
        print('User data posted successfully!');
      } catch (e) {
        print('Error posting user data: $e');


      } catch (e) {
      // Handle sign-up errors
      print('Sign-up error: $e');
    }

  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      // User sign-in successful
    } catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32.0),
              if(togglelogin)
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
      Stack(
        children: [
        TextFormField(

        controller: passwordController,
        obscureText: toggleObscure,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
      ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: Icon(toggleObscure?Icons.visibility_off:Icons.visibility),
              onPressed: () {
                setState(() {
                  toggleObscure=!toggleObscure;
                });
                // Handle button press event
              },
            ),
          ),
        ],
      ),


              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: save,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  child: Text(
                   togglelogin? 'Sign Up':'Log In',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      togglelogin=!togglelogin;
                    });

                  },
                  child: Text(togglelogin?'I already have an acount: Log in ':'Create New Acount: Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}
