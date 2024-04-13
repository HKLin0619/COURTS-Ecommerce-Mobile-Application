import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/screens/customer_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:courts_ecommerce/screens/login_screen.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'product.dart';
import 'order.dart';
import 'location.dart';
import 'userManual.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late PageController _pageController;
  late Timer _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Add GlobalKey

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_pageController.page == 2) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the user object from UserProvider
    final user = Provider.of<UserProvider>(context).user;

    // Determine the username based on user object
    final username = user != null ? user.username : 'guest';

    // Determine isLoggedIn status based on the username
    final isLoggedIn = username != 'guest';

    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        title: Text('Courts Malaysia'),
        backgroundColor: Colors.amber,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.dehaze,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            // Access the ScaffoldState using the GlobalKey and open the drawer
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

      drawer: Container(
        width: 250, // Set the width of the drawer
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 150, // Set the desired height of the DrawerHeader
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Semantics(
                  label: 'Product',
                  onTapHint: 'Tap to view Products',
                  child: Text('Product'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage()),
                  );
                },
              ),
              if (isLoggedIn)
                ListTile(
                  title: Semantics(
                    label: 'Location',
                    onTapHint: 'Tap to view Location',
                    child: Text('Location'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              if (isLoggedIn)
                ListTile(
                  title: Semantics(
                    label: 'Profile',
                    onTapHint: 'Tap to view Profile',
                    child: Text('Profile'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerProfileScreen()),
                    );
                  },
                ),
              if (isLoggedIn)
                ListTile(
                  title: Semantics(
                    label: 'Order',
                    onTapHint: 'Tap to view Orders',
                    child: Text('Order'),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => OrderPage()));
                  },
                ),
              ListTile(
                title: Semantics(
                  label: 'User manual',
                  onTapHint: 'Tap to view User manual',
                  child: Text('User manual'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserManualWidget()),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLoggedIn) {
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        // Navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.amber,
                      ), // Set the button background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ), // Set the text color
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
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
                    child: Text(isLoggedIn ? 'Logout' : 'Login'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Great Deals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 200,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.network(
                        'https://indiater.com/wp-content/uploads/2021/09/furniture-and-interior-detail-store-promotion-sale-ads-banner-on-yellow-floor-and-background-1024x395.jpg',
                        height: 200,
                        fit: BoxFit.fill,
                        alignment: Alignment(-0.5, 0),
                      ),
                      Image.network(
                        'https://pbs.twimg.com/media/DuZybCJU0AA7UIH.jpg',
                        width: 300,
                        height: 200,
                        fit: BoxFit.fill,
                        alignment: Alignment(-0.5, 0),
                      ),
                      Image.network(
                        'https://cdn.store-assets.com/s/1048187/f/11093885.png',
                        width: 300,
                        height: 200,
                        fit: BoxFit.fill,
                        alignment: Alignment(-0.5, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Shop by Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                height: 350,
                child: CarouselSlider(
                  items: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage()));
                      },
                      child: Image.network(
                        'https://assets.wfcdn.com/im/70604525/scale-h544-w448%5Ecompr-r85/2745/274566922/default_name.jpg',
                        width: 300,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage()));
                      },
                      child: Image.network(
                        'https://assets.wfcdn.com/im/91516600/scale-h732-w608%5Ecompr-r85/2727/272765743/default_name.jpg',
                        width: 300,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage()));
                      },
                      child: Image.network(
                        'https://assets.wfcdn.com/im/53887052/scale-h732-w608%5Ecompr-r85/2727/272765747/default_name.jpg',
                        width: 300,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage()));
                      },
                      child: Image.network(
                        'https://assets.wfcdn.com/im/80165687/scale-h732-w608%5Ecompr-r85/2727/272765744/default_name.jpg',
                        width: 300,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    initialPage: 1,
                    viewportFraction: 0.8,
                    disableCenter: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
