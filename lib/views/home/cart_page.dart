import 'package:aami/utils/helper%20functions/pricecalculator.dart';
import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/cart_provider.dart';
import 'package:aami/viewmodels/address_provider.dart';
import 'package:aami/views/address/addaddress_page.dart';
import 'package:aami/views/address/alladdress_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/cards/addresscard.dart';
import 'package:aami/widgets/cards/cartcard.dart';
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
                    ? Center(
                        child: CupertinoActivityIndicator(),
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
                            onDecrease: () =>
                                cartProvider.decrementQuantity(cartProduct.id),
                            onIncrease: () =>
                                cartProvider.incrementQuantity(cartProduct.id),
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
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      )
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
        bottomNavigationBar:
            CustomBottomNavButton(onTap: () {}, title: 'Checkout'),
      ),
    );
  }
}
