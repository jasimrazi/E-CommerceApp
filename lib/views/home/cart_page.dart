import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/cards/addresscard.dart';
import 'package:aami/widgets/cards/cartcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartData = [
    {
      "cart_items": [
        {
          "product": {
            "id": 1,
            "title": "Nike Club Fleece",
            "price": "120.00",
            "images": [
              "http://res.cloudinary.com/fakestore/image/upload/v1730878670/mmw1cwpici7eh2js8i5w.jpg",
              "http://res.cloudinary.com/fakestore/image/upload/v1730878671/f04u1eoz1nafs3tygmzj.avif",
              "http://res.cloudinary.com/fakestore/image/upload/v1730878672/imqpfis76yibnwludkgb.avif",
            ]
          },
          "quantity": 10
        },
      ]
    },
  ];

  final Map<String, dynamic> address = {
    "addresses": [
      {
        "user": 1,
        "name": "Shibin",
        "country": "India",
        "city": "Calicut",
        "phone_number": "1234567890",
        "address": "Shibin veed, Padikkal"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartData.length,
                  itemBuilder: (context, index) {
                    final cart = cartData[index];
                    final cartItems = cart['cart_items'] as List;

                    return Column(
                      children: cartItems.map<Widget>((item) {
                        final product = item['product'];
                        return CartCard(
                          title: product['title'],
                          price: product['price'],
                          images: List<String>.from(product['images']),
                          quantity: item['quantity'],
                          onDecrease: () {},
                          onIncrease: () {},
                        );
                      }).toList(),
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
                AddressCard(
                  city: address['addresses'][0]['city'],
                  address: address['addresses'][0]['address'],
                ),
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
                    Text(
                      '120.00',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
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
