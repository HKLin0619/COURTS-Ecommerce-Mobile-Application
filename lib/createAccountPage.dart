import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


createAccount(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController) async{
  try {
    final response = await http.post(
        Uri.parse('http://192.168.0.33/bit311Assignment/createAccount.php'),
        body:{
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'confirmPassword': confirmPasswordController.text,
        }
    );

    if (response.statusCode == 200) {
      if (response.body.contains('successfully')) {
        Fluttertoast.showToast(
          msg: 'Registration successfully!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 12.0,
        );

        Navigator.pushNamed(
          context,
          '/login',
        );

      } else if (response.body.contains('unsuccessfully')) {
        Fluttertoast.showToast(
          msg: 'Register Unsuccessfully !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 12.0,
        );

        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

      } else if (response.body.contains('invalidUsername')) {
        Fluttertoast.showToast(
          msg: 'Username Unavailable !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );

        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

      } else if (response.body.contains('invalidPassword')) {
        Fluttertoast.showToast(
          msg: 'Invalid password confirmation !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );

        passwordController.clear();
        confirmPasswordController.clear();

      } else if (response.body.contains('emptyInput')) {
        Fluttertoast.showToast(
          msg: 'Please fill in the information !',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );
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

class createAccountPage extends StatefulWidget {

  const createAccountPage({Key? key}) : super(key: key);

  @override
  _createAccountPageState createState() => _createAccountPageState();
}

class _createAccountPageState extends State<createAccountPage> {

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<user>? _futureUser;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  alignment: AlignmentDirectional(0, -1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(32, 0, 0, 0),
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
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create an account',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: Text(
                                    'Let\'s get started by filling out the form below.',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                  child: Container(
                                    width: 250,
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
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                  child: Container(
                                    width: 250,
                                    child: TextFormField(
                                      controller: emailController,
                                      autofocus: false,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
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
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                  child: Container(
                                    width: 250,
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: Container(
                                    width: 250,
                                    child: TextFormField(
                                      controller: confirmPasswordController,
                                      autofocus: false,
                                      autofillHints: [AutofillHints.password],
                                      obscureText: !_isConfirmPasswordVisible,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
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
                                            _isConfirmPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xFF57636C),
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        createAccount(context,
                                            usernameController,
                                            emailController,
                                            passwordController,
                                            confirmPasswordController
                                        );
                                      });
                                    },
                                    child: Text(
                                      'Create Account',
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
                                      fixedSize: Size(250, 40),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Already have an account? ',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: 'Sign In here',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            Navigator.pushNamed(
                                              context,
                                              '/login',
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
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}















