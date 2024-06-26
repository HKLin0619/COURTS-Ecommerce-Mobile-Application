import 'dart:convert';
import 'package:courts_ecommerce/locales/language.dart';
import 'package:courts_ecommerce/models/product.dart';
import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final String productID;
  const EditProductScreen({Key? key, required this.productID})
      : super(key: key);

  @override
  _editProductScreenState createState() => _editProductScreenState();
}

class _editProductScreenState extends State<EditProductScreen> {
  String? _selectedValue;
  final ImagePicker _imagePicker = ImagePicker();
  late ProductService _productService;

  late String productID;
  late TextEditingController _productNameController;
  late TextEditingController _productPriceController;
  late TextEditingController _productCategoryController;
  late TextEditingController _productDescriptionController;
  late TextEditingController _productLocationController;
  late TextEditingController _productImgVideoController;
  late TextEditingController _productVideoURLController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _productPriceController = TextEditingController();
    _productCategoryController = TextEditingController();
    _productDescriptionController = TextEditingController();
    _productLocationController = TextEditingController();
    _productImgVideoController = TextEditingController();
    _productVideoURLController = TextEditingController();
    _productService = ProductService();
    _loadProduct();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productCategoryController.dispose();
    _productDescriptionController.dispose();
    _productLocationController.dispose();
    _productImgVideoController.dispose();
    _productVideoURLController.dispose();
    super.dispose();
  }

  Future<void> _loadProduct() async {
    try {
      Product product = await _productService.getProductById(widget.productID);
      _productNameController.text = product.productName;
      _productPriceController.text = product.productPrice.toString();
      _productCategoryController.text = product.productCategory;
      _productDescriptionController.text = product.productDescription;
      _productLocationController.text = product.productLocation;
      _productImgVideoController.text = product.productImgVideo;
      _productVideoURLController.text = product.productVideoUrl;
      setState(() {});
    } catch (e) {
      print('Error loading product: $e');
    }
  }

  void _pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();

      setState(() {
        _productImgVideoController.text = base64Encode(imageBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user!;

    Locale locale = Localizations.localeOf(context);
    AppLocalizations translations = AppLocalizations();

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: Text(
            translations.translate('Edit Furniture', locale),
            // 'Edit Furniture ',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
              fontSize: 18,
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
                            controller: _productNameController,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: translations.translate(
                                  'Product Name', locale),
                              // labelText: 'Product Name',
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
                            controller: _productPriceController,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: translations.translate(
                                  'Product Price', locale),
                              // labelText: 'Product Price',
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
                          child: DropdownButton<String>(
                            value: _selectedValue,
                            onChanged: (String? val) {
                              setState(() {
                                _selectedValue = val!;
                                _productCategoryController.text = val!;
                              });
                            },
                            items: [
                              translations.translate(
                                  'Dining', locale),
                              translations.translate(
                                  'Home', locale),
                              translations.translate('Office', locale),
                              translations.translate('Living Rooms', locale)
                              // 'Dining & Kitchen',
                              // 'Home Furnishings',
                              // 'Home Office',
                              // 'Living Rooms'
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
                                )
                                .toList(),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                              size: 21,
                            ),
                            hint: Text(
                              _productCategoryController.text,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.black,
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
                            controller: _productDescriptionController,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: translations.translate(
                                  'Product Description', locale),
                              // labelText: 'Product Description',
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
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 10, 10),
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
                            controller: _productLocationController,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: translations.translate(
                                  'Product Location', locale),
                              // labelText: 'Product Location',
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
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 10, 10),
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
                          child: TextFormField(
                            controller: _productVideoURLController,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: translations.translate(
                                  'Product Video URL', locale),
                              // labelText: 'Product Video URL',
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
                                    _productImgVideoController.text.isEmpty
                                        ? Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_photo_alternate,
                                                color: Color(0xFF808080),
                                                size: 42,
                                              ),
                                              Text(
                                                translations.translate(
                                                    'Upload Your Image',
                                                    locale),
                                                // 'Upload Your Image',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: Color(0xFF808080),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Padding(
                                            padding: EdgeInsets.all(1),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(
                                                base64Decode(
                                                    _productImgVideoController
                                                        .text),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.29,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: ElevatedButton(
                                  onPressed: _pickImage,
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.upload,
                                          color: Colors.black,
                                          size: 19,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 0, 0, 0),
                                          child: Text(
                                            translations.translate(
                                                'Upload', locale),
                                            // 'Upload',
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
                      onPressed: () async {
                        try {
                          bool success = await _productService.editProduct(
                              productID: widget.productID,
                              productNameController: _productNameController,
                              productPriceController: _productPriceController,
                              productCategoryController:
                                  _productCategoryController,
                              productDescriptionController:
                                  _productDescriptionController,
                              productLocationController:
                                  _productLocationController,
                              productImgVideoController:
                                  _productImgVideoController,
                              productVideoURLController:
                                  _productVideoURLController);

                          if (success) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.lightGreenAccent,
                                          size: 60,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 10, 0, 0),
                                        child: Center(
                                          child: Text(
                                            translations.translate(
                                                'Successfully!', locale),
                                            // 'Successfully!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/home',
                                            arguments: '${user.username}',
                                          );
                                        },
                                        child: Text('OK'),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (e) {
                          print("Error occurred: $e");
                        }
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
                            translations.translate('Edit', locale),
                            // 'Edit',
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
