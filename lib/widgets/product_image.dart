import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _boxDecoration(),
        width: double.infinity,
        height: 450,
        child: const ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: FadeInImage(
            image: NetworkImage('http://via.placeholder.com/400x300/green'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0,5)
      )
    ]
  );
}