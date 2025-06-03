import 'package:flutter/material.dart';
import 'package:minimart_app/constants/app_images.dart';
import 'package:minimart_app/constants/colors.dart';
import 'package:minimart_app/models/product.dart';
import 'package:minimart_app/provider/favorites_provider.dart';
import 'package:minimart_app/widget/elevated_button_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Builder(
        builder: (context) => product == null
            ? Center(child: Text('No product selected'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      color: Colors.white,
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
                                Image.asset(AppImages.logo),
                                Text(
                                  "DELIVERY ADDRESS",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Image.asset(AppImages.notificationIcon),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Umuezike Road, Oyo State",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Image.asset(AppImages.arrowLeft),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Go back",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.1),
                          bottom: BorderSide(width: 0.1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      product!.imageUrl,
                                      width: double.infinity,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Consumer<FavoriteProvider>(
                                      builder: (context, favorite, child) {
                                        final isFavorite = favorite.isFavorite(
                                          product!,
                                        );
                                        return IconButton(
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavorite
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            Provider.of<FavoriteProvider>(
                                              context,
                                              listen: false,
                                            ).toggleFavorite(product!);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  product!.title,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${product!.storage} | ${product!.color}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Text(
                              '\$${product!.price}',
                              style: TextStyle(
                                fontSize: 32.75,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                            if (product!.description != null &&
                                product!.description!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About this item',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: descriptionTextColor,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      product!.description!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: descriptionTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButtonWidget(
                        label: "Add to Cart",
                        onPressed: () {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              padding: EdgeInsets.zero,
                              content: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 3,
                                      color: Colors.green,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Item has been added to cart',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
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
                              actions: [SizedBox.shrink()],
                            ),
                          );

                          Future.delayed(Duration(seconds: 2), () {
                            ScaffoldMessenger.of(
                              context,
                            ).hideCurrentMaterialBanner();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
