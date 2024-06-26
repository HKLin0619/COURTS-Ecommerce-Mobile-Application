class Order {
  final String orderId;
  final String orderDate;
  final double productPrice;
  final String productName;
  final String productImgVideo;
  final String fullName;
  final String phoneNumber;
  final String homeAddress;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.productPrice,
    required this.productName,
    required this.productImgVideo,
    required this.fullName,
    required this.phoneNumber,
    required this.homeAddress,
  });
}