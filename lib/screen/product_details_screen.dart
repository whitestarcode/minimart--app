import 'package:flutter/material.dart';
import 'package:minimart_app/constants/app_images.dart';
import 'package:minimart_app/constants/colors.dart';
import 'package:minimart_app/models/product.dart';
import 'package:minimart_app/provider/carts_provider.dart';
import 'package:minimart_app/provider/favorites_provider.dart';
import 'package:minimart_app/widget/elevated_button_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => product == null
            ? const Center(child: Text('No product selected'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                Image.asset(
                                  AppImages.notificationIcon,
                                  width: 24,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Image.asset(
                                    AppImages.arrowLeft,
                                    width: 24,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Go back",
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

                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1, color: borderColor),
                          bottom: BorderSide(width: 1, color: borderColor),
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
                                      height: 332,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
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
                                          icon: Image(
                                            image: AssetImage(
                                              isFavorite
                                                  ? AppImages.redHeartIcon
                                                  : AppImages.heartIcon,
                                            ),
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

                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    product!.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    '${product!.storage} | ${product!.color}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: textColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product!.price}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            if (product!.description != null &&
                                product!.description!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'About this item',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: descriptionTextColor,
                                      ),
                                    ),
                                    ...product!.description!
                                        .split(';')
                                        .map((sentence) => sentence.trim())
                                        .where(
                                          (sentence) => sentence.isNotEmpty,
                                        )
                                        .map(
                                          (sentence) => Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 4,
                                                    right: 8,
                                                  ),
                                                  width: 4,
                                                  height: 4,
                                                  decoration:
                                                      const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            descriptionTextColor,
                                                      ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    sentence.replaceAll(
                                                      RegExp(r'\.*$'),
                                                      '',
                                                    ),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          descriptionTextColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButtonWidget(
                        label: "Add to Cart",
                        onPressed: () {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).addToCart(product!);
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              padding: const EdgeInsets.all(8),
                              content: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: const Border(
                                    left: BorderSide(
                                      width: 3,
                                      color: Colors.green,
                                    ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppImages.checkCircle,
                                              width: 24,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Item has been added to cart',
                                              style: TextStyle(
                                                color: textColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Image.asset(
                                          AppImages.close,
                                          width: 24,
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
                              actions: const [SizedBox.shrink()],
                            ),
                          );
                          Future.delayed(const Duration(seconds: 2), () {
                            ScaffoldMessenger.of(
                              context,
                            ).hideCurrentMaterialBanner();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }
}
