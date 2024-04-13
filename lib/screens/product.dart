import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'productDetails.dart';
import 'package:courts_ecommerce/models/product.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;
  late Future<List<Product>> _productListFuture;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );

    // Load the banner ad
    _loadBannerAd();
    _productListFuture = _productService.fetchData();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', // Replace with your Ad Unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (_, error) {
          print('Ad failed to load: $error');
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bannerAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    // Determine the username based on user object
    final username = user != null ? user.username : 'guest';

    // Determine isLoggedIn status based on the username
    final isLoggedIn = username != 'guest';

    return GestureDetector(
      onTap: () {
        if (_searchFocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(_searchFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product'),
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 8, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search for your furniture',
                        labelStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.grey, // Replace with your desired color
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.amber, // Replace with your desired color
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Replace with your desired color
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Replace with your desired color
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                            Colors.white, // Replace with your desired color
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 24), // Adjust the vertical padding here
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey, // Replace with your desired color
                          size: 16,
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      minLines: null,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.search_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Dining'),
                      Tab(text: 'Home'),
                      Tab(text: 'Office'),
                      Tab(text: 'Living Rooms'),
                    ],
                  ),
                  Expanded(
                      child: FutureBuilder<List<Product>>(
                          future: _productListFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else if (snapshot.hasData) {
                              List<Product> allProducts = snapshot.data!;
                              return TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 16, 0, 0),
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: allProducts.length,
                                          itemBuilder: (context, index) {
                                            final product = allProducts[index];
                                            if (product.productCategory !=
                                                'Dining') {
                                              return SizedBox.shrink();
                                            }
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8, 4, 8, 4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isLoggedIn) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsWidget(
                                                          productId:
                                                              product.productID,
                                                          productName: product
                                                              .productName,
                                                          productDescription:
                                                              product
                                                                  .productDescription,
                                                          productPrice: product
                                                              .productPrice,
                                                          productImageURL: product
                                                              .productImgVideo,
                                                          productVideoURL: product
                                                              .productVideoUrl,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Login required to view product details'),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child: Image.memory(
                                                              base64Decode(product
                                                                  .productImgVideo),
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                product
                                                                    .productName,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                'RM ${product.productPrice.toStringAsFixed(2)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 16, 0, 0),
                                          child: Text(
                                            'Categories', // Combine user.userID with 'Categories'
                                            style: TextStyle(
                                                fontSize:
                                                    20), // Specify the style using named argument
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: allProducts.length,
                                          itemBuilder: (context, index) {
                                            final product = allProducts[index];
                                            if (product.productCategory !=
                                                'Home') {
                                              return SizedBox
                                                  .shrink(); // Skip this item if not in the "Home" category
                                            }
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8, 4, 8, 4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isLoggedIn) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsWidget(
                                                          productId:
                                                              product.productID,
                                                          productName: product
                                                              .productName,
                                                          productDescription:
                                                              product
                                                                  .productDescription,
                                                          productPrice: product
                                                              .productPrice,
                                                          productImageURL: product
                                                              .productImgVideo,
                                                          productVideoURL: product
                                                              .productVideoUrl,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Login required to view product details'),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.memory(
                                                            base64Decode(product
                                                                .productImgVideo),
                                                            width: 70,
                                                            height: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                product
                                                                    .productName,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                '\RM ${product.productPrice.toStringAsFixed(2)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 16, 0, 0),
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: allProducts.length,
                                          itemBuilder: (context, index) {
                                            final product = allProducts[index];
                                            if (product.productCategory !=
                                                'Office') {
                                              return SizedBox
                                                  .shrink(); // Skip this item if not in the "Home" category
                                            }
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8, 4, 8, 4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isLoggedIn) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsWidget(
                                                          productId:
                                                              product.productID,
                                                          productName: product
                                                              .productName,
                                                          productDescription:
                                                              product
                                                                  .productDescription,
                                                          productPrice: product
                                                              .productPrice,
                                                          productImageURL: product
                                                              .productImgVideo,
                                                          productVideoURL: product
                                                              .productVideoUrl,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Login required to view product details'),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.memory(
                                                            base64Decode(product
                                                                .productImgVideo),
                                                            width: 70,
                                                            height: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                product
                                                                    .productName,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                '\RM ${product.productPrice.toStringAsFixed(2)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 16, 0, 0),
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: allProducts.length,
                                          itemBuilder: (context, index) {
                                            final product = allProducts[index];
                                            if (product.productCategory !=
                                                'Living Rooms') {
                                              return SizedBox
                                                  .shrink(); // Skip this item if not in the "Home" category
                                            }
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8, 4, 8, 4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isLoggedIn) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsWidget(
                                                          productId:
                                                              product.productID,
                                                          productName: product
                                                              .productName,
                                                          productDescription:
                                                              product
                                                                  .productDescription,
                                                          productPrice: product
                                                              .productPrice,
                                                          productImageURL: product
                                                              .productImgVideo,
                                                          productVideoURL: product
                                                              .productVideoUrl,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Login required to view product details'),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.memory(
                                                            base64Decode(product
                                                                .productImgVideo),
                                                            width: 70,
                                                            height: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                product
                                                                    .productName,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                '\RM ${product.productPrice.toStringAsFixed(2)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return CircularProgressIndicator();
                          })),
                  Padding(
                    padding: EdgeInsets.all(
                        3.0), // Add 16.0 pixels padding around the AdWidget
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
