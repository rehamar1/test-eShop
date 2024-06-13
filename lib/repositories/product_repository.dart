import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart';


class ProductRepository {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts({int skip = 0, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?skip=$skip&limit=$limit'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['products'] as List).map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}