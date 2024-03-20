import 'package:courts_ecommerce/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {

  Future<User?> login(String username, String password) async {

    final response = await http.post(

      Uri.parse('http://192.168.0.33/bit311Assignment/userLogin.php'),
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
}
