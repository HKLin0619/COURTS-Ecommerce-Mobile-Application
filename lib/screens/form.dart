import 'package:courts_ecommerce/services/order_service.dart';
import 'package:courts_ecommerce/services/review_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, required this.orderID}) : super(key: key);
  final String orderID;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget>
    with SingleTickerProviderStateMixin {
  late double _ratingBarValue;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late String _productName = '';
  late String _productID = '';
  final ReviewService _reviewService = ReviewService();

  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _ratingBarValue = 3;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500), // Set animation duration
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start off-screen at bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _commentController = TextEditingController();

    // Start the animation when the widget is built
    _animationController.forward();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    try {
      final orderService = OrderService();
      final result = await orderService.getOrderForm(widget.orderID);

      setState(() {
        _productName = result['productName'];
        _productID = result['productID'];
      });
    } catch (error) {
      // Handle error fetching order details
      print('Error fetching order details: $error');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 103, 103),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _offsetAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    16, 40, 16, 16), // Top padding set to 15
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              10, 10, 10, 10), // Top padding set to 15
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _productName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        _animationController
                                            .reverse()
                                            .then((_) {
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Text(
                                  'Order ID: ${widget.orderID}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: RatingBar.builder(
                                    onRatingUpdate: (newValue) {
                                      setState(() {
                                        _ratingBarValue = newValue;
                                      });
                                    },
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                    ),
                                    direction: Axis.horizontal,
                                    initialRating: _ratingBarValue,
                                    unratedColor: Colors.grey,
                                    itemCount: 5,
                                    itemSize: 40,
                                    glowColor:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 300,
                                constraints: BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 190,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  border: Border.all(
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Semantics(
                                    label: 'Review',
                                    hint: 'Enter your comment here',
                                    child: TextFormField(
                                      autofocus: true,
                                      controller:
                                          _commentController, // Use _commentController here
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                        hintText: 'Comment',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).errorColor,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).errorColor,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      maxLines: 3,
                                      minLines: null,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: TextButton(
                                        onPressed: () {
                                          print('Cancel button pressed ...');
                                          _animationController
                                              .reverse()
                                              .then((_) {
                                            Navigator.pop(context);
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(10),
                                          backgroundColor: Colors.red,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final orderID = widget.orderID;
                                        final productID = _productID;
                                        final comment =
                                            _commentController.text.trim();
                                        final rating = _ratingBarValue;

                                        // Validate inputs before showing the SnackBar
                                        if (comment.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please enter a comment.'),
                                            ),
                                          );
                                          return;
                                        }

                                        if (rating == 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please rate the product.'),
                                            ),
                                          );
                                          return;
                                        }

                                        // Display a SnackBar with the review details

                                        int parsedOrderID = int.tryParse(
                                                orderID) ??
                                            0; // Convert orderID to int (default value 0 if parsing fails)
                                        int parsedProductID =
                                            int.tryParse(productID) ?? 0;

                                        _reviewService
                                            .addReview(
                                          orderID: parsedOrderID,
                                          productID: parsedProductID,
                                          comment: comment,
                                          rating: rating.toInt(),
                                        )
                                            .then((success) {
                                          if (success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Review submitted successfully'),
                                              ),
                                            );
                                            _animationController
                                                .reverse()
                                                .then((_) {
                                              Navigator.pop(context);
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Failed to submit review'),
                                              ),
                                            );
                                          }
                                        }).catchError((error) {
                                          print(
                                              'Error submitting review: $error');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Review submitted before'),
                                            ),
                                          );
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.blue[700],
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        elevation: 1,
                                        side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white),
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
          );
        },
      ),
    );
  }
}
