import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop_app_flutter/providers/cart.dart';

class OrderItem {
  final int id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: Random(100).nextInt(100),
            amount: total,
            dateTime: DateTime.now(),
            products: cartProducts));
            notifyListeners();
  }


}