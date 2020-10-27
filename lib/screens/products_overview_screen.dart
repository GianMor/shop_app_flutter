import 'package:flutter/material.dart';
import 'package:shop_app_flutter/widget/product_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    // productsContainer.showFavoriteOnly();
                    _showOnlyFavorites = true;
                  } else {
                    // productsContainer.showAll();
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                        child: Text('Show all'), value: FilterOptions.All)
                  ])
        ],
      ),
      body: ProductGrid(showFavs: _showOnlyFavorites,),
    );
  }
}
