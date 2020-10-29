import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:shop_app_flutter/screens/products_overview_screen.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart())
        ],
        child: MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
                accentColor: Colors.teal,
                primarySwatch: Colors.amber,
                fontFamily: 'Lato'),
            home: ProductsOverviewScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen()
            }));
  }
}
