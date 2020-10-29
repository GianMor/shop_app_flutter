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
  Map<int, CartItem> _items = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
        (key, cartItem) => total += cartItem.price * cartItem.quantity);
    return total;
  }

  void addItem({int productId, double price, String title}) {
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
          id: Random().nextInt(200),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
