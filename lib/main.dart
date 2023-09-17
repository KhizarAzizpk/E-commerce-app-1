import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/provider/cart.dart';
import 'package:khaksarfirstapp/provider/order.dart';
import 'package:khaksarfirstapp/provider/product.dart';
import 'package:khaksarfirstapp/screen/addproductscreen.dart';
import 'package:khaksarfirstapp/screen/cart_screen.dart';
import 'package:khaksarfirstapp/screen/loginscreen.dart';
import 'package:khaksarfirstapp/screen/orderScreen.dart';
import 'package:khaksarfirstapp/screen/product_overview_screen.dart';
import 'package:khaksarfirstapp/screen/userproductsscreen.dart';
import 'package:khaksarfirstapp/widgets/products_detail_screen.dart';
import 'package:khaksarfirstapp/widgets/theme.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
        ChangeNotifierProvider(
        create: (ctx)=>Products(),
        ),
ChangeNotifierProvider(
create:(ctx)=>Cart(),
),
      ChangeNotifierProvider(
        create: (ctx)=>Order(),
      ),
    ],

     child: MaterialApp(
       debugShowCheckedModeBanner: false,
     title: 'Shop App',
      theme: EcommerceAppTheme.getAppTheme(),
      home:StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder:(context,snapshot){
        if(snapshot.hasData){
        return  productoverviewScreen();
        }
        return SignUpScreen();
      } ),

      routes: {
         productoverviewScreen.routname:(ctx)=>productoverviewScreen(),
       productdetailscreen.routname:(ctx)=>productdetailscreen(),
        CartScreen.routname:(ctx)=>CartScreen(),
        OrderScreen.routname:(context)=>OrderScreen(),
        UserproductScreen.routname:(context)=>UserproductScreen(),
        addProductScreen.routname:(context)=>addProductScreen(),

      },
    ),
    );
  }
}
