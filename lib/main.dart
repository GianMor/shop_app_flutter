import 'package:flutter/material.dart';
import 'package:shop_app_flutter/helpers/custom_route.dart';
import 'package:shop_app_flutter/providers/auth.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/providers/orders.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/screens/orders_screen.dart';
import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:shop_app_flutter/screens/products_overview_screen.dart';
import 'package:shop_app_flutter/screens/splash-screen.dart';
import 'package:shop_app_flutter/screens/user_products_screen.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (ctx, auth, previousProducts) => Products(
                  auth.token,
                  previousProducts == null ? [] : previousProducts.items,
                  auth.userId),
              create: null),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                previousOrders == null ? [] : previousOrders.orders,
                auth.userId),
            create: null,
          )
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, child) => MaterialApp(
                    title: 'My Shop',
                    theme: ThemeData(
                        accentColor: Colors.teal,
                        primarySwatch: Colors.amber,
                        fontFamily: 'Lato',
                        pageTransitionsTheme: PageTransitionsTheme(builders: {
                          TargetPlatform.android: CustomPageTransitionBuilder(),
                          TargetPlatform.iOS: CustomPageTransitionBuilder(),
                        })),
                    home: auth.isAuth
                        ? ProductsOverviewScreen()
                        : FutureBuilder(
                            future: auth.tryAutoLogin(),
                            builder: (ctx, _) =>
                                _.connectionState == ConnectionState.waiting
                                    ? SplashScreen()
                                    : AuthScreen()),
                    routes: {
                      ProductDetailScreen.routeName: (ctx) =>
                          ProductDetailScreen(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      OrdersScreen.routeName: (ctx) => OrdersScreen(),
                      UserProductsScreen.routeName: (ctx) =>
                          UserProductsScreen(),
                      EditProductScreen.routeName: (ctx) => EditProductScreen(),
                    })));
  }
}
