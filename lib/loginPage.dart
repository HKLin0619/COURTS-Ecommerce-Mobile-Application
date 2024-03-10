import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

loginAccount(

    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController) async{
  try {
    final response = await http.post(
        Uri.parse('http://192.168.0.33/bit311Assignment/userLogin.php'),
        body:{
          'username': usernameController.text,
          'password': passwordController.text,
        }
    );

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'success') {

        final userData = user.fromJson(jsonData['data']);

        if (usernameController.text == 'admin' && passwordController.text == 'admin123') {

          Navigator.pushNamed(
            context,
            '/admin',
            arguments: userData,
          );

        } else {

          // Navigator.pushNamed(
          //   context,
          //   '/login',
          // );

        }

      } else if (jsonData['status'] == 'userNotFound') {
        Fluttertoast.showToast(
          msg: 'User not found !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );

        usernameController.clear();
        passwordController.clear();

      } else if (jsonData['status'] == 'emptyInput') {
        Fluttertoast.showToast(
          msg: 'Please fill in the information !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );

      } else if (jsonData['status'] == 'invalidPassword') {
        Fluttertoast.showToast(
          msg: 'Incorrect Password !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );

        passwordController.clear();

      }
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An unexpected error occurred. Please try again.'),
      ),
    );
  }
}

class loginPage extends StatefulWidget {

  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  bool _isPasswordVisible = false;

  //\Future<user>? _futureUser;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 25),
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'COURTS',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: Color(0xFF0000FF), // Use theme color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 270,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21,
                                  color: Color(0xFF101213), // Use theme color
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: Text(
                                  'Fill out the information below in order to access your account.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xFF57636C), // Use theme color
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: usernameController,
                                    autofocus: false,
                                    autofillHints: [AutofillHints.username],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: passwordController,
                                    autofocus: false,
                                    autofillHints: [AutofillHints.password],
                                    obscureText: !_isPasswordVisible,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Color(0xFF57636C),
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible = !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        loginAccount(context,
                                            usernameController,
                                            passwordController,
                                        );
                                      });
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlueAccent,// Set button color
                                      padding: EdgeInsets.zero,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      side: BorderSide(
                                        color: Colors.black, // Transparent border
                                        width: 1,
                                      ),
                                      fixedSize: Size(110, 40),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Don\'t have an account?  ',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: 'Sign Up here',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            Navigator.pushNamed(
                                              context,
                                              '/signUp',
                                            );
                                          },
                                        ),
                                      ],
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}















