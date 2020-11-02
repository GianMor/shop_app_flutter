import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
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
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
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

  void addItem({String productId, double price, String title}) {
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
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (!_items.containsKey(prodId)) {}
    if (_items[prodId].quantity > 1) {
      _items.update(
          prodId,
          (cart) => CartItem(
              id: cart.id,
              title: cart.title,
              quantity: cart.quantity - 1,
              price: cart.price));
    } else {
      _items.remove(prodId);
    }
    notifyListeners();
  }
}
