import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:courts_ecommerce/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {

  var url = '${dotenv.env['URL']}';

  Future<User> getUserById(String userID) async {
    final response = await http.post(
      Uri.parse('$url/getUserById.php'),
      body: {'userID': userID},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final userData = jsonData['userData'];

      return User(
        userID: userData['userID'].toString(),
        username: userData['username'],
        fullName: userData['fullName'],
        email: userData['email'],
        phoneNumber: userData['phoneNumber'],
        homeAddress: userData['homeAddress'],
        password: userData['password']
      );
    } else {
      throw Exception('User Not Found');
    }
  }

  Future<bool> editProfile({
    required String userID,
    required TextEditingController userFullNameController,
    required TextEditingController userEmailController,
    required TextEditingController userPhoneNumberController,
    required TextEditingController userHomeAddressController,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/editProfile.php'),
        body: {
          'userID': userID,
          'fullName': userFullNameController.text,
          'email': userEmailController.text,
          'phoneNumber': userPhoneNumberController.text,
          'homeAddress': userHomeAddressController.text,
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return true;
        } else if (jsonData['status'] == 'unsuccess') {
          Fluttertoast.showToast(
            msg: 'Non-compliant User Information !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );
          throw Exception('Failed to update profile: Unsuccess');
        } else {
          throw Exception('Unexpected status: ${jsonData['status']}');
        }
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (error) {
      throw Exception('An unexpected error occurred: $error');
    }
  }

  Future<List<User>> fetchData() async {
    final response = await http.get(
        Uri.parse('$url/listUser.php')
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<User> userList = [];
      for (var item in jsonData) {
        userList.add(User(
          userID: item['userID'],
          username: item['username'],
          fullName: item['fullName'],
          email: item['email'],
          phoneNumber: item['phoneNumber'],
          homeAddress: item['homeAddress'],
          password: item['password'],
        ));
      }
      return userList;
    } else {
      throw Exception('Unexpected error occured !');
    }
  }

}
