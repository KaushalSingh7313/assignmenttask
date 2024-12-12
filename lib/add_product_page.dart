import 'package:assignmenttask/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final productsString = prefs.getStringList('products') ?? [];
      final products = productsString.map((e) => Product.fromJson(e)).toList();

      if (products.any((p) => p.name == _nameController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product already exists')),
        );
        return;
      }

      final newProduct =  Product(
        name: _nameController.text,
        price: double.parse(_priceController.text),
      );

      products.add(newProduct);
      prefs.setStringList(
        'products',
        products.map((e) => e.toJson()).toList(),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



