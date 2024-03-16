class product{
  final String productID;
  final String productName;
  final double productPrice;
  final String productDescription;
  final String productImgVideo;
  final String productCategory;
  final String productLocation;

  product({
    required this.productID,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productImgVideo,
    required this.productCategory,
    required this.productLocation
  });

  String getId() {
    return this.productID;
  }

  factory product.fromJson(Map<String, dynamic> json){
    return product(
      productID: json['productID'],
      productName: json['productName'],
      productPrice: double.parse(json['productPrice']),
      productDescription: json['productDescription'],
      productImgVideo: json['productImgVideo'],
      productCategory: json['productCategory'],
      productLocation: json['productLocation'],
    );
  }
}