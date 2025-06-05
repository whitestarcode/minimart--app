import 'package:flutter/material.dart';
import 'package:minimart_app/widget/bottom_navigator_bar.dart';
import 'package:minimart_app/provider/carts_provider.dart';
import 'package:minimart_app/provider/favorites_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MaterialApp(
        title: 'MiniMart App',
        theme: ThemeData(
          primaryColor: Color(0xFF1E88E5),
          scaffoldBackgroundColor: Color(0xFFfbfbfb),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: BottomNavigatorBar(),
      ),
    );
  }
}
