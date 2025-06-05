import 'package:flutter/material.dart';
import 'package:minimart_app/constants/app_images.dart';
import 'package:minimart_app/constants/colors.dart';
import 'package:minimart_app/provider/carts_provider.dart';
import 'package:minimart_app/widget/bottom_navigator_bar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.items;
          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          const double shippingFee = 10.0;
          final double subtotal = cartProvider.total;
          final double totalWithShipping = subtotal + shippingFee;

          return Column(
            children: [
              const SizedBox(height: 30),
              Container(
                color: kBackgroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(AppImages.logo, width: 50),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 20),
                                Text(
                                  "DELIVERY ADDRESS",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: headerTextColor,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Umuezike Road, Oyo State",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: headerTextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Image.asset(AppImages.notificationIcon, width: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigatorBar(),
                              ),
                            ),
                            child: Image.asset(AppImages.arrowLeft, width: 24),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Your Cart",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: borderColor),
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final entry = cartItems.entries.elementAt(index);
                      final product = entry.key;
                      final quantity = entry.value;
                      return Card(
                        color: listViewColor,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.65),
                                child: Image.asset(
                                  product.imageUrl,
                                  width: 102.87,
                                  height: 106.15,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            product.title,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: cartProducttextColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            '${product.storage} | ${product.color}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: cartProducttextColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${(product.price * quantity).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: cartProducttextColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "In stock",
                                      style: TextStyle(
                                        color: inStocktextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Image.asset(
                                                AppImages.minusIcon,
                                                width: 24,
                                              ),
                                              onPressed: () {
                                                Provider.of<CartProvider>(
                                                  context,
                                                  listen: false,
                                                ).decreaseQuantity(product);
                                              },
                                            ),
                                            Text(
                                              '$quantity',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: textColor,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Image.asset(
                                                AppImages.addIcon,
                                                width: 24,
                                              ),
                                              onPressed: () {
                                                Provider.of<CartProvider>(
                                                  context,
                                                  listen: false,
                                                ).increaseQuantity(product);
                                              },
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Image.asset(
                                            AppImages.deleteIcon,
                                            width: 24,
                                          ),
                                          onPressed: () {
                                            Provider.of<CartProvider>(
                                              context,
                                              listen: false,
                                            ).removeFromCart(product);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: borderColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order Info",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '\$10.00',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '\$${totalWithShipping.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      padding: EdgeInsets.zero,
                      content: DecoratedBox(
                        decoration: BoxDecoration(
                          border: const Border(
                            left: BorderSide(width: 3, color: Colors.green),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: kBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.checkCircle,
                                      width: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        'Proceeding to checkout (${cartProvider.cartCount} items)',
                                        style: const TextStyle(
                                          color: textColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Image.asset(AppImages.close, width: 24),
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentMaterialBanner();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: const [SizedBox.shrink()],
                    ),
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(343, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(\$${totalWithShipping.toStringAsFixed(2)})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
