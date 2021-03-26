import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _imageUrlController = TextEditingController();
  final _imageUrlInputListener = FocusNode();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  Product _formProduct = Product.emptyInstance;

  @override
  void initState() {
    super.initState();
    _imageUrlInputListener.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    var isImageUrlValid = _imageUrlController.text.isEmpty &&
        (!_imageUrlController.text.startsWith('http://') &&
            !_imageUrlController.text.startsWith('https://')) &&
        (!_imageUrlController.text.endsWith('.png') &&
            !_imageUrlController.text.endsWith('.jpg') &&
            !_imageUrlController.text.endsWith('.jpeg'));

    if (!_imageUrlInputListener.hasFocus) {
      if (!isImageUrlValid) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    print(_formProduct.title);
    print(_formProduct.id);
    print(_formProduct.price);
    print(_formProduct.description);
    print(_formProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (title) {
                  _formProduct = _formProduct.copyWith(title: title);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (price) {
                  _formProduct =
                      _formProduct.copyWith(price: double.parse(price));
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Please enter a number freater than zero';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (description) {
                  _formProduct =
                      _formProduct.copyWith(description: description);
                },
                validator: (value) {
                  if (value.length <= 10) {
                    return 'Please enter at least 10 characters';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    margin: const EdgeInsets.only(
                      top: 8.0,
                      right: 10.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text('Enter URL'),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (imageUrl) {
                        _formProduct =
                            _formProduct.copyWith(imageUrl: imageUrl);
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL';
                        }

                        if (!value.startsWith('http://') &&
                            !value.startsWith('https://')) {
                          return 'Please enter a valid URL';
                        }

                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL';
                        }

                        return null;
                      },
                      focusNode: _imageUrlInputListener,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imageUrlInputListener.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    super.dispose();
  }
}
