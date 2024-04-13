import 'dart:io';

import 'package:courts_ecommerce/providers/product_provider.dart';
import 'package:courts_ecommerce/screens/add_product_screen.dart';
import 'package:courts_ecommerce/screens/admin_profile_screen.dart';
import 'package:courts_ecommerce/screens/create_account_screen.dart';
import 'package:courts_ecommerce/screens/customer_profile_screen.dart';
import 'package:courts_ecommerce/screens/list_of_customer_screen.dart';
import 'package:courts_ecommerce/screens/list_of_selling_history.dart';
import 'package:courts_ecommerce/screens/start_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/screens/admin_screen.dart';
import 'package:courts_ecommerce/screens/customer_screen.dart';
import 'package:courts_ecommerce/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:courts_ecommerce/locales/language.dart';

void main() async {

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Failed to load .env file: $e");
  }

  Locale initialLocale = await _getLocale();

  runApp(MyApp(initialLocale: initialLocale));
}

Future<Locale> _getLocale() async {
  String locale;
  try {
    locale = Platform.localeName.split('_').first; // Extract language code from locale
  } catch (e) {
    locale = 'en'; // Default to English if unable to fetch system locale
  }
  return Locale(locale);
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  MyApp({Key? key, required this.initialLocale}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          AppLocalizationsDelegate(), // Your custom localizations delegate
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('zh', ''), // Chinese
          const Locale('ms', ''), // Chinese
        ],
        locale: initialLocale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => StartLoadingScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) {
            final user = Provider.of<UserProvider>(context).user;
            return user != null && user.username == 'admin'
                ? AdminScreen()
                : CustomerScreen();
          },
          '/addProduct': (context) => AddProductScreen(),
          '/createAccount': (context) => CreateAccountScreen(),
          '/adminProfile': (context) => AdminProfileScreen(),
          '/customerProfile': (context) => CustomerProfileScreen(),
          '/listOfCustomer': (context) => ListOfCustomerScreen(),
          '/listOfSellingHistory': (context) => ListOfSellingHistoryScreen(),
        },
      ),
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh', 'ms'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
