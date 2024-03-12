import 'package:flutter/material.dart';
import "pages/recipe1.dart";
import "pages/recipe2.dart";

void main() {
  final recipes = [
    const Rcp1(),
    const Rcp2(),
  ];
  runApp(recipes[1]);
}
