import 'package:courts_ecommerce/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/screens/admin_screen.dart';
import 'package:courts_ecommerce/screens/customer_screen.dart';
import 'package:courts_ecommerce/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) {
            final user = Provider.of<UserProvider>(context).user;
            return user != null && user.username == 'admin'
                ? AdminScreen()
                : CustomerScreen();
          },
          '/addProduct': (context) => AddProductScreen(),
        },
      ),
    );
  }
}
