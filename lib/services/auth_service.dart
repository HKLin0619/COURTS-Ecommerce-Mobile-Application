import 'package:courts_ecommerce/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {

  var url = '${dotenv.env['URL']}';

  Future<User?> login(String username, String password) async {

    final response = await http.post(

      Uri.parse('$url/userLogin.php'),
      body: {'username': username, 'password': password},

    );

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'success') {

        final userData = jsonData['data'];

        return User(
          userID: int.parse(userData['userID'].toString()),
          username: userData['username'],
          email: userData['email'],
          password: userData['password'],
        );

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

        throw Exception('Failed to login: Empty input');

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

        throw Exception('Failed to login: User Not Found');

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

        throw Exception('Failed to login: Invalid Password');

      } else {

        throw Exception('Failed to login: ${jsonData['status']}');

      }

    } else {

      throw Exception('Failed to login');

    }

  }

  Future<bool> register({
    required TextEditingController usernameController,
    required TextEditingController userEmailController,
    required TextEditingController userPasswordController,
    required TextEditingController userConfirmPasswordController,
  }) async {
    try {

      final response = await http.post(
          Uri.parse('$url/createAccount.php'),
          body:{
            'username': usernameController.text,
            'email': userEmailController.text,
            'password': userPasswordController.text,
            'confirmPassword': userConfirmPasswordController.text,
          }
      );

      if (response.statusCode == 200) {

        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {

          return true;

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

          throw Exception('Failed to register: Empty input');

        } else if (jsonData['status'] == 'invalidPassword') {

          Fluttertoast.showToast(
            msg: 'Invalid password confirmation !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );

          throw Exception('Failed to register: Invalid password');

        } else if (jsonData['status'] == 'invalidUsername') {

          Fluttertoast.showToast(
            msg: 'Username Unavailable !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );

          throw Exception('Failed to register: invalid username');

        } else {

          throw Exception('Unexpected status: ${jsonData['status']}');

        }

      } else {

        throw Exception('Failed to register');

      }

    } catch (error) {

      throw Exception('An unexpected error occurred: $error');

    }

  }
}
