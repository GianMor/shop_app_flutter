import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  // final int productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      {this.id,
      //  this.productId,
      this.price,
      this.quantity,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.amberAccent,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 40),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to remove the item from hte cart?'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No')),
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Si'))
                ],
              )),
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItem(id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(child: FittedBox(child: Text('\$$price'))),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
