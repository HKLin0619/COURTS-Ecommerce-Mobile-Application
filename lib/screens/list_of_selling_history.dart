import 'dart:convert';

import 'package:courts_ecommerce/locales/language.dart';
import 'package:courts_ecommerce/models/order.dart';
import 'package:courts_ecommerce/models/user.dart';
import 'package:courts_ecommerce/services/order_service.dart';
import 'package:courts_ecommerce/services/user_service.dart';
import 'package:flutter/material.dart';

class ListOfSellingHistoryScreen extends StatefulWidget {

  const ListOfSellingHistoryScreen({Key? key}) : super(key: key);

  @override
  _listOfSellingHistoryScreenPageState createState() => _listOfSellingHistoryScreenPageState();
}

class _listOfSellingHistoryScreenPageState extends State<ListOfSellingHistoryScreen> {

  late Future<List<Order>> _orderListFuture;
  final OrderService _orderService = OrderService();

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _orderListFuture = _orderService.orderData();
    _filterOrderList(_searchController.text);
  }

  Future<List<Order>> _filteredOrderList(String query) async {
    List<Order> orderList = await _orderListFuture;
    return orderList.where((order) {
      return order.orderId.toLowerCase().contains(query.toLowerCase()) ||
             order.orderDate.toLowerCase().contains(query.toLowerCase()) ||
             order.productPrice.toString().contains(query.toLowerCase()) ||
             order.productName.toLowerCase().contains(query.toLowerCase()) ||
             order.fullName.toLowerCase().contains(query.toLowerCase()) ||
             order.phoneNumber.toLowerCase().contains(query.toLowerCase()) ||
             order.homeAddress.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void _filterOrderList(String query) {
    setState(() {
      if (query.isEmpty) {
        _orderListFuture = _orderService.orderData();
      } else {
        _orderListFuture = _filteredOrderList(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Locale locale = Localizations.localeOf(context);
    AppLocalizations translations = AppLocalizations();

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: Text(
            translations.translate('Selling History', locale),
            // 'Selling History',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black, // Use theme color
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (String value) {
                        if (value.isEmpty) {
                          _filterOrderList("");
                        }
                      },
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: translations.translate('Search history...', locale),
                        labelStyle: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF57636C),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4B39EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(15, 15, 10, 10),
                      ),
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                      onPressed: () {
                        _filterOrderList(_searchController.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder <List<Order>> (
                future: _orderListFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Order> orderList = snapshot.data!;
                    return
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: orderList?.length,
                          itemBuilder: (context, index) {
                            Order order = orderList[index];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 6,
                                              color: Color(0x32000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      translations.translate('Order ID:', locale) +  ' ${order.orderId}',
                                                      // 'Order ID: ${order.orderId}',
                                                      style: TextStyle(
                                                        fontFamily: 'Plus Jakarta Sans',
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                                      child: Text(
                                                        translations.translate('Selling Date:', locale) +  ' ${order.orderDate}',
                                                        // 'Selling Date: ${order.orderDate}',
                                                        style: TextStyle(
                                                          fontFamily: 'Plus Jakarta Sans',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return SizedBox(
                                                        height: 500,
                                                        width: MediaQuery.sizeOf(context).width,
                                                        child: Padding(
                                                          padding: EdgeInsets.all(20),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                height: 5,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.black,
                                                                  borderRadius: BorderRadius.circular(3),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(90, 20, 0, 20),
                                                                child: Container(
                                                                  width: 100,
                                                                  height: 100,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(8),
                                                                    child:Image.memory(
                                                                      base64Decode('${order.productImgVideo}'),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      translations.translate('Product Name', locale),
                                                                      // 'Product Name',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),

                                                                    Text(
                                                                      ': ${order.productName}',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      translations.translate('Product Price', locale),
                                                                      // 'Product Price',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),

                                                                    Text(
                                                                      ': RM ${order.productPrice}',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      translations.translate('Buyer', locale),
                                                                      // 'Buyer',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),

                                                                    Text(
                                                                      ': ${order.fullName}',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      translations.translate('Buyer Contact Number', locale),
                                                                      //'Buyer Contact Number',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),

                                                                    Text(
                                                                      ': ${order.phoneNumber}',
                                                                      style: TextStyle(
                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    transitionAnimationController: AnimationController(
                                                      vsync: Navigator.of(context),
                                                      duration: Duration(seconds: 1), // Adjust the duration as needed
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  translations.translate('View', locale),
                                                  // 'View',
                                                  style: TextStyle(
                                                    fontFamily: 'Plus Jakarta Sans',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.lightBlue,// Set button color
                                                  padding: EdgeInsets.zero,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  side: BorderSide(
                                                    color: Colors.black, // Transparent border
                                                    width: 1,
                                                  ),
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
                            );
                          }
                      );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  };
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}















