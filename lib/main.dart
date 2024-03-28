import 'package:courts_ecommerce/providers/product_provider.dart';
import 'package:courts_ecommerce/screens/add_product_screen.dart';
import 'package:courts_ecommerce/screens/admin_profile_screen.dart';
import 'package:courts_ecommerce/screens/create_account_screen.dart';
import 'package:courts_ecommerce/screens/list_of_customer_screen.dart';
import 'package:courts_ecommerce/screens/list_of_selling_histort.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/screens/admin_screen.dart';
import 'package:courts_ecommerce/screens/customer_screen.dart';
import 'package:courts_ecommerce/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Failed to load .env file: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
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
          '/createAccount': (context) => CreateAccountScreen(),
          '/adminProfile': (context) => AdminProfileScreen(),
          '/listOfCustomer': (context) => ListOfCustomerScreen(),
          '/listOfSellingHistory': (context) => ListOfSellingHistoryScreen(),
        },
      ),
    );
  }
}
