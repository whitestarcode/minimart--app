import 'package:flutter/material.dart';
import 'package:minimart_app/constants/app_images.dart';
import 'package:minimart_app/provider/carts_provider.dart';
import 'package:minimart_app/screen/cart_page.dart';
import 'package:minimart_app/screen/favorite_page.dart';
import 'package:minimart_app/screen/home_page.dart';
import 'package:minimart_app/screen/user_page.dart';
import 'package:provider/provider.dart';

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({super.key});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int _selectIndex = 0;
  final List<Widget> pages = [
    HomeScreen(),
    CartPage(),
    FavoritePage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectIndex],
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) => BottomNavigationBar(
          currentIndex: _selectIndex,
          onTap: (index) => setState(() => _selectIndex = index),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(AppImages.homeIcon),
                width: 20,
                height: 18,
                color: _selectIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Image(
                    image: AssetImage(AppImages.cartIcon),
                    width: 50,
                    height: 20,
                    color: _selectIndex == 1
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  if (cart.cartCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.cartCount}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(AppImages.favouriteIcon),
                width: 20,
                height: 18,
                color: _selectIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(AppImages.userIcon),
                width: 20,
                height: 18,
                color: _selectIndex == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
