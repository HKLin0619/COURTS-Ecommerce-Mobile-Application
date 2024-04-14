import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/services/order_service.dart';
import 'package:courts_ecommerce/services/review_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'video.dart';
import 'package:courts_ecommerce/models/product.dart';
import 'package:courts_ecommerce/models/review.dart';

class ProductDetailsWidget extends StatelessWidget {
  final String productId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImageURL;
  final String productVideoURL;

  ProductDetailsWidget({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImageURL,
    required this.productVideoURL,
  });

  final OrderService _orderService = OrderService();
  final ReviewService _reviewService = ReviewService();

  Future<List<Review>> fetchReviews() async {
    var reviews = await _reviewService.fetchReviews();
    return reviews.where((review) => review.productId == productId).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          base64Decode(productImageURL),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => VideoWidget(
                                            productVideoURL: productVideoURL),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  child: Text('Demo'),
                                ),
                                IconButton(
                                  onPressed: () {
                                    shareProduct(context);
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        '\$$productPrice',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 5),
                      child: Text(
                        productDescription,
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 70,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Adjusted to CrossAxisAlignment.start
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    "1",
                                    // '$totalRating',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 28,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' of Ratings',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        "1",
                                        // '$avgRating',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 28,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                      child: Icon(
                                        Icons.star_rounded,
                                        color: Colors
                                            .yellow, // Change color here if needed
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Avg. Rating',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Container(
                        width: 400,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .backgroundColor, // Use the theme's background color
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            width: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: SingleChildScrollView(
                            child: FutureBuilder<List<Review>>(
                                future: fetchReviews(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  } else if (snapshot.hasData) {
                                    List<Review> reviews = snapshot.data!;
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: reviews.map((review) {
                                        return Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Container(
                                            width: 400,
                                            height: 130,
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    review.reviewId,
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    child: RatingBarIndicator(
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star_rounded,
                                                        color: Colors.amber,
                                                      ),
                                                      direction:
                                                          Axis.horizontal,
                                                      rating: review
                                                          .rating, // Use review's rating here
                                                      unratedColor:
                                                          Color(0xFF95A1AC),
                                                      itemCount: 5,
                                                      itemSize: 24,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    review.comment,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    print('Button pressed ...');
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    try {
                      bool success = await _orderService.addOrder(
                        orderDate: formattedDate,
                        orderAmount: productPrice.toString(),
                        userID: user.userID,
                        productID: productId,
                      );

                      if (success) {
                        // Handle successful order addition
                        print('Order added successfully!');
                        // Add further actions or UI updates here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Succesfully purchased product!'),
                          ),
                        );
                      } else {
                        // Handle unsuccessful order addition
                        print('Failed to add order.');
                        // Add error handling or UI feedback
                      }
                    } catch (e) {
                      // Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
                      print(e);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.amber), // Set the button background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text('Purchase'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void shareProduct(BuildContext context) {
    final String text =
        'Check out this product: ${productName}\nPrice: \$${productPrice}\nDescription: ${productDescription}\nPage URL: https://example.com/product/${productId}\nImage image: ${productImageURL}';

    Share.share(text);
  }
}
