import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required String hinText,
    required String lableText,
    IconData? prefixIcon
  }){
    return InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.deepPurple
                  )
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2
                  )
                ),
                hintText: hinText,
                labelText: lableText,
                labelStyle:  const TextStyle(
                  color: Colors.grey
                ),
                prefixIcon:  prefixIcon != null
                ? Icon(prefixIcon, color: Colors.deepPurple)
                : null
              );
  }
}