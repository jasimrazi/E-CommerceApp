import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/order_provider.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/ordercard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() {
    // Fetch orders after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.fetchOrders(authProvider.loginId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'My Orders',
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (provider.orders.isEmpty) {
            return const Center(
              child: Text(
                'No orders available.',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: provider.orders.length,
              itemBuilder: (context, index) {
                final order = provider.orders[index];
                return OrderCard(
                  order: order,
                  orderID: index + 1,
                );
              },
            );
          }
        },
      ),
    );
  }
}
