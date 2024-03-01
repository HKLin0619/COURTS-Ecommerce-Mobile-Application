import 'package:flutter/material.dart';

class startPage extends StatefulWidget {

  const startPage({Key? key}) : super(key: key);

  @override
  _startPageState createState() => _startPageState();
}

class _startPageState extends State<startPage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00FFFFFF), Colors.white],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.rectangle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://logo.lusha.co/d/company_6437019_logo.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF101213),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                        child: Text(
                          'Thanks for joining! Access or create your account below, and get started on your journey!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 44),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 16),
                        child: ElevatedButton(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          child: Text('Get Started'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.zero,
                            textStyle: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF101213),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            fixedSize: Size(230, 52),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 16),
                        child: ElevatedButton(
                          onPressed: () {
                            print('My Account button pressed ...');
                          },
                          child: Text(
                            'My Account',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black, // Use theme color
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).secondaryHeaderColor, // Use theme color
                            padding: EdgeInsets.zero,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            fixedSize: Size(230, 52),
                          ),
                        ),
                      ),
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















