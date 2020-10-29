import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/orders.dart' show Orders;
import 'package:shop_app_flutter/widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your orders')),
      body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
          itemCount: orderData.orders.length),
    );
  }
}
