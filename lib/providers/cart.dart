import 'dart:math';

import 'package:flutter/foundation.dart';

class CartItem {
  final int id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<int, CartItem> _items;

  Map<int, CartItem> get items {
    return {..._items};
  }

  void addItem(int productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exisitingItem) => CartItem(
              id: exisitingItem.id,
              price: exisitingItem.price,
              quantity: exisitingItem.quantity + 1,
              title: exisitingItem.title));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: Random().nextInt(100),
              title: title,
              quantity: 1,
              price: price));
    }
  }
}
