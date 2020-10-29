import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/providers/product.dart';
import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final int id;
  // final String title;
  // final String imageUrl;

  // const ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          //     .push(MaterialPageRoute(builder: (ctx) => ProductDetailScreen(title: title,))),

          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () => product.toggleFavoriteStatus(),
                  color: Theme.of(context).accentColor)),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => cart.addItem(
                  productId: product.id,
                  title: product.title,
                  price: product.price),
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
