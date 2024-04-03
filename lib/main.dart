import 'package:flutter/material.dart';
import "package:teste/pages/recipe1-2.dart";
import "package:teste/pages/recipe1-3.dart";
import "package:teste/pages/recipe1.dart";
import "package:teste/pages/recipe2.dart";
import "package:teste/pages/recipe3.dart";
import "package:teste/pages/recipe4.dart";
import "package:teste/pages/recipe5.dart";

void main() {
  final recipes = [
    const Rcp1(),
    const Rcp1_2(),
    const Rcp1_3(),
    const Rcp2(),
    const Rcp3(),
    Rcp4(),
    const Rcp5(),
  ];
  runApp(recipes[6]);
}
