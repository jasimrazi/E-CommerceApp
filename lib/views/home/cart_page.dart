import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/cart_provider.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/cards/addresscard.dart';
import 'package:aami/widgets/cards/cartcard.dart';
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

    // Fetch products when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      Provider.of<CartProvider>(context, listen: false)
          .fetchCart(authProvider.loginId!);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    // Fetch the CartProvider to get cart items
    final cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: cartProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      // Display cart items fetched from CartProvider
                      ListView.builder(
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
                            quantity:  cartProvider.productQuantities[cartProduct.id] ??
                                    1,
                            onRemove: (){},
                            onDecrease: () => cartProvider.decrementQuantity(cartProduct.id),
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
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      ),
                      // Display address from provider
                      // AddressCard(
                      //   city: cartProvider.address['city'],
                      //   address: cartProvider.address['address'],
                      // ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Order Info',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          // Text(
                          //   cartProvider.cartItems
                          //       .fold(
                          //           0.0,
                          //           (sum, item) =>
                          //               sum +
                          //               (double.tryParse(item.price) ?? 0) *
                          //                   item.quantity)
                          //       .toStringAsFixed(2),
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
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
