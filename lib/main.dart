import 'package:flutter/material.dart';
import "pages/recipe1.dart";

void main() {
  final recipes = [
    const Rcp1(),
  ];
  runApp(recipes[0]);
}
