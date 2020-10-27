import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/product_provider.dart';
import 'package:shop_app_flutter/widget/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final product = productsData.items;
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: product.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ProductItem(
              id: product[i].id,
              title: product[i].title,
              imageUrl: product[i].imageUrl,
            ));
  }
}
