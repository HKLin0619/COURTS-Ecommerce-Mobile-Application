import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'user.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

Future<List<product>> fetchData() async {

  final response = await http.get(Uri.parse('http://192.168.0.33/bit311Assignment/listProduct.php'));

  if (response.statusCode == 200) {

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new product.fromJson(data)).toList();

  } else {

    throw Exception('Unexpected error occured!');

  }

}

deleteProduct(String productID) async {

  try {
    final response = await http.post(
      Uri.parse('http://192.168.0.33/bit311Assignment/deleteProduct.php'),
      body: {
        'productID': productID
      },
    );

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'success') {
        Fluttertoast.showToast(
          msg: 'Delete successfully!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 12.0,
        );

      }
    }
  } catch (error) {
    print('An unexpected error occurred. Please try again.');
  }
}

class adminPage extends StatefulWidget {

  const adminPage({Key? key}) : super(key: key);

  @override
  _adminPageState createState() => _adminPageState();

}

class _adminPageState extends State<adminPage> {

  late Future <List<product>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }



  @override
  Widget build(BuildContext context) {

    final user userData = ModalRoute.of(context)!.settings.arguments as user;

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black, // Use theme color
                            ),
                          ),
                          Text(
                            '${userData.username}',
                            // 'admin',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black, // Use theme color
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0,20, 20, 0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: const CircleBorder(),
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            width: 55,
                            height: 55,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://t4.ftcdn.net/jpg/05/09/59/75/360_F_509597532_RKUuYsERhODmkxkZd82pSHnFtDAtgbzJ.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.73,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Color(0xFF808080),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                            unselectedLabelStyle: TextStyle(),
                            indicatorColor: Colors.black,
                            tabs: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.chair,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  Tab(
                                    text: 'Furniture',
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.analytics,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  Tab(
                                    text: 'Analyze',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Management Furniture',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.black, // Use theme color
                                                ),
                                              ),
                                              Text(
                                                'Edit or Delete Products',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: Colors.black, // Use theme color
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/addFurniture',
                                                arguments: userData,
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(10),
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Container(
                                              width: 31,
                                              height: 31,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.lightGreenAccent, width: 2),
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.black,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: FutureBuilder <List<product>> (
                                        future: futureData,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<product>? data = snapshot.data;
                                            return
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: data?.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  final item = data?[index];
                                                  return Dismissible(
                                                    key: UniqueKey(),
                                                    direction: DismissDirection.endToStart,
                                                    onDismissed: (direction) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text("Note !"),
                                                            content: Text("Are you sure you want to delete this product ?"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: Text("Cancel"),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  setState(() {
                                                                    data?.removeAt(index);
                                                                    deleteProduct(item!.getId());
                                                                  });
                                                                },
                                                                child: Text("Delete"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    background: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(0),
                                                      ),
                                                      color: Color(0xFFFF0206),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(15),
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacementNamed(
                                                          context,
                                                          '/editFurniture',
                                                          arguments: {
                                                            'userData': userData,
                                                            'productID': data![index].productID,
                                                            'productName': data![index].productName,
                                                            'productPrice': data![index].productPrice,
                                                            'productCategory': data![index].productCategory,
                                                            'productDescription': data![index].productDescription,
                                                            'productLocation': data![index].productLocation,
                                                            'productImgVideo': data![index].productImgVideo,
                                                          },
                                                        );
                                                      },
                                                      child: Card(
                                                        clipBehavior: Clip.none,
                                                        color: Colors.white,
                                                        elevation: 4,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors.white,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                  EdgeInsets.all(5),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(8),
                                                                    child:
                                                                    Image.file(
                                                                      File(data![index].productImgVideo),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        data![index].productName,
                                                                        style: TextStyle(
                                                                          fontFamily: 'Plus Jakarta Sans',
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 12,
                                                                          color: Colors.black, // Use theme color
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "RM ${data![index].productPrice.toStringAsFixed(2)}",
                                                                        style: TextStyle(
                                                                          fontFamily: 'Plus Jakarta Sans',
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 10,
                                                                          color: Colors.black, // Use theme color
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 100,
                                                                width: 5,
                                                                child: VerticalDivider(
                                                                  thickness: 15,
                                                                  color:
                                                                  Color(0xFFFF0206),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                          } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                          }
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}















