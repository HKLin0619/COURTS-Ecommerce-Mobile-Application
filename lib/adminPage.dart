import 'package:flutter/material.dart';

class adminPage extends StatefulWidget {

  const adminPage({Key? key}) : super(key: key);

  @override
  _adminPageState createState() => _adminPageState();

}

class _adminPageState extends State<adminPage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Color(0xFFf1f4f8),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(21, 0, 26, 0),
                          child: Container(
                            width: 55,
                            height: 55,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network('https://t3.ftcdn.net/jpg/06/04/79/52/360_F_604795233_5zIpEvhWizTN7bUxSADUdrQQFGj315G3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: 390,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: TabBar(
                            padding: EdgeInsets.all(4),
                            tabs: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_cart_sharp,),
                                  Tab(text: 'Furniture',),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.analytics,),
                                  Tab(text: 'Analyze ',),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 0),
                                        spreadRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 289,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Management Furniture',
                                                        style: TextStyle(
                                                          fontFamily: 'Plus Jakarta Sans',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Description',
                                                        style: TextStyle(
                                                          fontFamily: 'Plus Jakarta Sans',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add_rounded,
                                                  color: Theme.of(context).textTheme.bodyText1?.color,
                                                  size: 24,
                                                ),
                                                onPressed: () {
                                                  print('IconButton pressed ...');
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                                            child: Card(
                                              clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                              color: Colors.white,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    height: 100,
                                                    child: VerticalDivider(
                                                      width: 5,
                                                      thickness: 5,
                                                      color: Color(0xFFf1f4f8),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      child: Image.network(
                                                        'https://picsum.photos/seed/473/600',
                                                        width: 80,
                                                        height: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                    child: Container(
                                                      width: 206,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Product Name',
                                                            style: TextStyle(
                                                              fontFamily: 'Plus Jakarta Sans',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Price',
                                                            style: TextStyle(
                                                              fontFamily: 'Plus Jakarta Sans',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 100,
                                                    child: VerticalDivider(
                                                      width: 5,
                                                      thickness: 5,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 0),
                                        spreadRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                          child: Container(
                                            width:
                                            MediaQuery.sizeOf(context).width,
                                            height: 440,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.sizeOf(context).width,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(16),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xFFf1f4f8),
                                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Button',
                                                    style: Theme.of(context).textTheme.headline6?.copyWith(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(16),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xFFf1f4f8),
                                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Button',
                                                    style: Theme.of(context).textTheme.headline6?.copyWith(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
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
                        )
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
  }
}















