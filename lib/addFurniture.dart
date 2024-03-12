import 'package:flutter/material.dart';

class addFurniturePage extends StatefulWidget {

  const addFurniturePage({Key? key}) : super(key: key);

  @override
  _addFurniturePageState createState() => _addFurniturePageState();
}

class _addFurniturePageState extends State<addFurniturePage> {

  String _selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Add Furniture ',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
              fontSize: 21,
              color: Colors.black, // Use theme color
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Product Name',
                              labelStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              alignLabelWithHint: false,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF4B39EF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            ),
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Product Price',
                              labelStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              alignLabelWithHint: false,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF4B39EF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            ),
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),







                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),

                        child: Container(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  DropdownButton<String>(
                            value: _selectedValue,
                            onChanged: (String? val) {
                              setState(() {
                                _selectedValue = val!;
                              });
                            },
                            items: ['Option 1', 'Option 2', 'Option 3']
                                .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                              size: 21,
                            ),
                            hint: Text(
                              'Category',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            isExpanded: true,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            underline: Container(
                              height: 0,
                            ),
                          ),
                        ),

                      ),







                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Product Description',
                              labelStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              alignLabelWithHint: false,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF4B39EF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 10, 10),
                            ),
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.black,
                            maxLines: 6,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Product Location',
                              labelStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              alignLabelWithHint: false,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF4B39EF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5963),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 10, 10),
                            ),
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.black,
                            maxLines: 6,
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.41,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'https://picsum.photos/seed/233/600',
                                  width: MediaQuery.sizeOf(context).width,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.3,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                    maxWidth: 500,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.upload,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                          child: Text(
                                            'Upload Product Picture',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 4,
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
    );
  }
}















