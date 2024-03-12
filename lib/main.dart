import 'package:flutter/material.dart';
import "pages/recipe1.dart";
import "pages/recipe1-2.dart";

void main() {
  final recipes = [
    const Rcp1(),
    const Rcp1_2(),
  ];
  runApp(recipes[1]);
}
