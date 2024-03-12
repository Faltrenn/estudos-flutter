import 'package:flutter/material.dart';
import "package:teste/pages/recipe1-3.dart";
import "pages/recipe1.dart";
import "pages/recipe1-2.dart";

void main() {
  final recipes = [
    const Rcp1(),
    const Rcp1_2(),
    const Rcp1_3(),
  ];
  runApp(recipes[2]);
}
