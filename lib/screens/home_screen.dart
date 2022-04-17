import 'package:flutter/material.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          child: ProductCard(),
          onTap: () => Navigator.pushNamed(context, 'product'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}