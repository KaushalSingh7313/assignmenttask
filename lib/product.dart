import 'dart:convert';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  String toJson() => '{"name": "$name", "price": $price}';

  static Product fromJson(String json) {
    final data = jsonDecode(json);
    return Product(name: data['name'], price: data['price']);
  }
}
