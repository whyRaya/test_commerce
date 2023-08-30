import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_commerce/data/model/product_model.dart';

class ProductServices {

  final String _baseUrl = "https://fakestoreapi.com";

  Future<List<String>> getCategories() async {
    try {
      final body = await _manageResponse("$_baseUrl/products/categories");
      return List<String>.from(json.decode(body));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<ProductModel>> getProduct(int limit) async {
    try {
      final body = await _manageResponse("$_baseUrl/products?limit=$limit");
      List<dynamic> list = json.decode(body);
      return list.map((e) => ProductModel.fromJson(e)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<String> _manageResponse(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Future.error(Exception(response.reasonPhrase));
    }
  }
}
