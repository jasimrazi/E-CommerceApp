import 'package:aami/models/product_model.dart';

class Order {
  final int id;
  final String loginId;
  final int? shippingAddress;
  final String totalAmount;
  final String status;
  final String orderDate;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.loginId,
    this.shippingAddress,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      loginId: json['loginid'] ?? '',
      shippingAddress: json['shipping_address'],
      totalAmount: json['total_amount'] ?? '0.00',
      status: json['status'] ?? 'Pending',
      orderDate: json['order_date'] ?? '',
      orderItems: json['order_items'] != null
          ? (json['order_items'] as List<dynamic>)
              .map((item) => OrderItem.fromJson(item))
              .toList()
          : [],
    );
  }

  static List<Order> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Order.fromJson(json)).toList();
  }
}

class OrderItem {
  final Product product;
  final int quantity;
  final String price;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? '0.00',
    );
  }
}
