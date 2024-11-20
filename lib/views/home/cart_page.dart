import 'package:aami/utils/helper%20functions/pricecalculator.dart';
import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/cart_provider.dart';
import 'package:aami/viewmodels/address_provider.dart';
import 'package:aami/viewmodels/order_provider.dart';
import 'package:aami/views/address/alladdress_page.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/cards/addresscard.dart';
import 'package:aami/widgets/cards/cartcard.dart';
import 'package:aami/widgets/loading%20cards/Laddresscard.dart';
import 'package:aami/widgets/loading%20cards/Lcartcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    // Fetch products and address when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final loginId = authProvider.loginId!;

      Provider.of<CartProvider>(context, listen: false).fetchCart(loginId);
      Provider.of<AddressProvider>(context, listen: false)
          .fetchAddresses(loginId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String subTotal =
        priceCalculator(cartProvider.cartItems, cartProvider.productQuantities)
            .toStringAsFixed(1);
    double total = double.parse(subTotal) + 20;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),

                cartProvider.isLoading
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2, // Number of loading placeholders
                        itemBuilder: (context, index) {
                          return const LoadingCartCard();
                        },
                      )
                    : cartProvider.cartItems.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                'No items in cart',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cartProvider.cartItems.length,
                            itemBuilder: (context, index) {
                              final cartProduct = cartProvider.cartItems[index];
                              return CartCard(
                                title: cartProduct.title,
                                price: cartProduct.price,
                                images: cartProduct.imageUrls,
                                size: cartProduct.size,
                                quantity: cartProvider
                                        .productQuantities[cartProduct.id] ??
                                    1,
                                onRemove: () {},
                                onDecrease: () => cartProvider
                                    .decrementQuantity(cartProduct.id),
                                onIncrease: () => cartProvider
                                    .incrementQuantity(cartProduct.id),
                              );
                            },
                          ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Address',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllAddresses(),
                              ));
                        },
                        icon: Icon(Icons.keyboard_arrow_right)),
                  ],
                ),

                // Display first address, if available
                addressProvider.isLoading
                    ? LoadingAddressCard()
                    : addressProvider.addresses.isNotEmpty
                        ? AddressCard(
                            city: addressProvider.selectedAddress!.city,
                            address: addressProvider.selectedAddress!.address,
                          )
                        : Text(
                            'No address available',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),

                SizedBox(height: 30.h),

                Text(
                  'Order Info',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text('\$ $subTotal',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text('\$ 20.0',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text('\$ ${total.toString()}',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavButton(
          onTap: () async {
            try {
              // Prepare the `orderItems`
              final orderItems = cartProvider.cartItems.map((cartProduct) {
                return {
                  'product_id': cartProduct.id, // Product ID
                  'quantity': cartProvider.productQuantities[cartProduct.id] ??
                      1, // Quantity
                  'price': cartProduct.price, // Price of the product
                };
              }).toList();

              // Create the order
              await orderProvider.createOrder(
                context: context,
                loginId: authProvider.loginId!,
                shippingAddressId: addressProvider.selectedAddress!.id!,
                orderItems: orderItems,
                totalAmount: total.toString(),
              );

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order created successfully!')),
              );
            } catch (e) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },
          title: 'Checkout',
          isLoading: orderProvider.isLoading,
        ),
      ),
    );
  }
}
