import 'package:aami/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final int orderID;

  const OrderCard({Key? key, required this.order, required this.orderID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order No: ${orderID}',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text(
                '${order.status}',
                style: TextStyle(
                  fontSize: 14,
                  color: order.status == 'Delivered'
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total Amount: \$${order.totalAmount}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'Items:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          ...order.orderItems.map((item) {
            return Text(
              '${item.quantity} x ${item.product.title}',
              style: Theme.of(context).textTheme.bodySmall,
            );
          }).toList(),
        ],
      ),
    );
  }
}
