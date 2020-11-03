import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/products.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/widget/app_drawer.dart';
import 'package:shop_app_flutter/widget/user_product_item.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProcuts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProductScreen.routeName))
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, _) {
          return _.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: Consumer<Products>(
                    builder: (ctx, productsData, _) => Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, i) => Column(
                                children: [
                                  UserProductItem(
                                    id: productsData.items[i].id,
                                    title: productsData.items[i].title,
                                    imageUrl: productsData.items[i].imageUrl,
                                  ),
                                  Divider()
                                ],
                              )),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
