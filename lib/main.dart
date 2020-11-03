import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/auth.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/providers/orders.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/screens/orders_screen.dart';
import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:shop_app_flutter/screens/products_overview_screen.dart';
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
<<<<<<< HEAD
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (ctx, auth, previousProducts) => Products(
                  auth.token,
                  previousProducts == null ? [] : previousProducts.items,
                  auth.userId),
              create: null),
=======
          ChangeNotifierProvider(create: (ctx) => Products()),
>>>>>>> c60f227dda59b984d8443e10f98c25acf25c6445
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                previousOrders == null ? [] : previousOrders.orders,
                auth.userId),
            create: null,
          )
        ],
<<<<<<< HEAD
        child: Consumer<Auth>(
            builder: (ctx, auth, child) => MaterialApp(
                    title: 'My Shop',
                    theme: ThemeData(
                        accentColor: Colors.teal,
                        primarySwatch: Colors.amber,
                        fontFamily: 'Lato'),
                    home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
                    routes: {
                      ProductDetailScreen.routeName: (ctx) =>
                          ProductDetailScreen(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      OrdersScreen.routeName: (ctx) => OrdersScreen(),
                      UserProductsScreen.routeName: (ctx) =>
                          UserProductsScreen(),
                      EditProductScreen.routeName: (ctx) => EditProductScreen(),
                    })));
=======
        child: MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
                accentColor: Colors.teal,
                primarySwatch: Colors.amber,
                fontFamily: 'Lato'),
            home: AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }));
>>>>>>> c60f227dda59b984d8443e10f98c25acf25c6445
  }
}
