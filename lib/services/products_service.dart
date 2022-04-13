import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = "https://flutter-varios-e7cf2-default-rtdb.firebaseio.com";

  final List<Product> products = [];

  //Todo make products fetch
}