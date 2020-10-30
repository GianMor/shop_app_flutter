import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imgFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  var _editProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  @override
  void initState() {
    _imgFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imgFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imgFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imgFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print(_editProduct.title);
    print(_editProduct.description);
    print(_editProduct.price);
    print(_editProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (_) => _editProduct = Product(
                      id: null,
                      title: _,
                      price: _editProduct.price,
                      description: _editProduct.description,
                      imageUrl: _editProduct.imageUrl),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descFocusNode),
                  validator: (_) {
                    if (_.isEmpty) {
                      return 'Enter a price';
                    }
                    if (double.tryParse(_) == null) {
                      return 'Enter a valid number';
                    }
                    if (double.parse(_) <= 0) {
                      return 'Enter a number greater than 0';
                    }
                    return null;
                  },
                  onSaved: (_) => _editProduct = Product(
                      id: null,
                      title: _editProduct.title,
                      price: double.parse(_),
                      description: _editProduct.description,
                      imageUrl: _editProduct.imageUrl),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descFocusNode,
                  validator: (_) {
                    if (_.isEmpty) {
                      return 'Enter a description';
                    }
                    if (_.length < 10) {
                      return 'At least 10 characters';
                    }
                    return null;
                  },
                  onSaved: (_) => _editProduct = Product(
                      id: null,
                      title: _editProduct.title,
                      price: _editProduct.price,
                      description: _,
                      imageUrl: _editProduct.imageUrl),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a url')
                            : FittedBox(
                                child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ))),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onEditingComplete: () => setState(() {}),
                        focusNode: _imgFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (_) {
                          if (_.isEmpty) {
                            return 'Enter an url';
                          }
                          if (!_.startsWith('http') && !_.startsWith('https')) {
                            return 'Enter a valid url';
                          }
                          if (!_.endsWith('.png') &&
                              !_.endsWith('.jpg') &&
                              !_.endsWith('.jpeg')) {
                            return 'Enter a valid image url';
                          }
                          return null;
                        },
                        onSaved: (_) => _editProduct = Product(
                            id: null,
                            title: _editProduct.title,
                            price: _editProduct.price,
                            description: _editProduct.description,
                            imageUrl: _),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
