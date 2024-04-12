import 'package:flutter/material.dart';
import 'form.dart';
import 'package:courts_ecommerce/models/order.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> orders = [
      Order(
        orderId: '1001',
        orderDate: '2024-04-05',
        orderAmount: 49.99,
        productImageUrl: 'https://picsum.photos/seed/52/600',
      ),
      Order(
        orderId: '1002',
        orderDate: '2024-04-06',
        orderAmount: 99.99,
        productImageUrl: 'https://picsum.photos/seed/52/600',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      appBar: AppBar(
        title: Text('Order'),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 4, 0),
                child: Text(
                  'Below are your most recent orders',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0,
                    fontSize: 16, // Set your desired font size
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    orders.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 350),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        orders[index].productImageUrl,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 100,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: orders[index].orderId,
                                                  style: TextStyle(
                                                    color: Colors.indigo[900],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            child: Text(
                                              orders[index].orderDate,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 12),
                                            child: Text(
                                              '\$${orders[index].orderAmount.toStringAsFixed(2)}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                letterSpacing: 0,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    height: 100,
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Navigate to the FormWidget when the button is clicked
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormWidget(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Review',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[700],
                                              minimumSize: Size(70, 35),
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              elevation: 3,
                                              side: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          child: Text(
                                            'Receipt',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              fontSize: 14,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue[700],
                                            minimumSize: Size(70, 35),
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            elevation: 3,
                                            side: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
