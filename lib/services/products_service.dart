import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{
  final String _baseUrl = "flutter-varios-e7cf2-default-rtdb.firebaseio.com";
  final List<Product> products = [];

  late Product selectedProduct;
  bool isLoading = true;
  bool isSaving = true;

  ProductsService(){
    loadProducts();
  }


  Future<List<Product>> loadProducts() async{

    isLoading = true;

    notifyListeners();

    final url = Uri.https(_baseUrl,'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future saveOrCreateProduct(Product product) async{

    isSaving = true;
    notifyListeners();

      if(product.id == null){
        // Create
      }else{
        await updateProduct(product);
      }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async{
    
    final url = Uri.https(_baseUrl,'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    // todo: update products list
    return product.id!;

  }
}