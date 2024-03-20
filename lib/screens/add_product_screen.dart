import 'package:flutter/material.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _addProductScreenPageState createState() => _addProductScreenPageState();
}

class _addProductScreenPageState extends State<AddProductScreen> {

  String? _selectedValue;

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
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: TextFormField(
                            // controller: productNameController,
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
                            // controller: productPriceController,
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
                              contentPadding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              prefix: Text(
                                'RM ',
                                style: TextStyle(
                                  color: Colors.black, // 设置字体颜色为黑色
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  DropdownButton<String>(
                            value: _selectedValue,
                            onChanged: (String? val) {
                              setState(() {
                                _selectedValue = val!;
                                // productCategoryController.text = val!;
                              });
                            },
                            items: [
                              'Dining & Kitchen',
                              'Home Furnishings',
                              'Home Office',
                              'Living Rooms'
                            ]
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
                            ).toList(),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                              size: 21,
                            ),
                            hint: Text(
                              'Product Category',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            isExpanded: true,
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
                            // controller: productDescriptionController,
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
                            // controller: productLocationController,
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
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // _imageController.text.isEmpty ?
                                         Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          color: Color(0xFF808080),
                                          size: 42,
                                        ),
                                        Text(
                                          'Upload Your Image',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF808080),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    // ) : Padding(
                                    //   padding: EdgeInsets.all(1),
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     child: Image.file(
                                    //       File(_imageController.text),
                                    //       width: MediaQuery.of(context).size.width,
                                    //       height: MediaQuery.of(context).size.height * 0.29,
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
                                         ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: ElevatedButton(

                                  onPressed: (){},

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    elevation: 4,
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.upload,
                                          color: Colors.black,
                                          size: 19,
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                          child: Text(
                                            'Upload',
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
                        // setState(() {
                        //   addProduct(context,
                        //     productNameController,
                        //     productPriceController,
                        //     productCategoryController,
                        //     productDescriptionController,
                        //     productLocationController,
                        //     _imageController,
                        //   );
                        // });
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















