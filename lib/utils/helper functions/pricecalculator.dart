import 'package:aami/models/cartproduct_model.dart';

double priceCalculator(
    List<CartProduct> cartItems, Map<int, int> productQuantities) {
  double total = 0;

  for (var item in cartItems) {
    double itemPrice = double.tryParse(item.price) ?? 0;
    int quantity = productQuantities[item.id] ?? 1;
    total += itemPrice * quantity;
  }

  return total;
}
