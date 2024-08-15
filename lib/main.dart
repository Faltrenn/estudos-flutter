import 'package:flutter/material.dart';
import "package:teste/pages/recipe1-2.dart";
import "package:teste/pages/recipe1-3.dart";
import "package:teste/pages/recipe1.dart";
import "package:teste/pages/recipe2.dart";
import "package:teste/pages/recipe3.dart";
import "package:teste/pages/recipe4.dart";
import "package:teste/pages/recipe5.dart";
import "package:teste/pages/recipe6.dart";
import "package:teste/pages/recipe7.dart";
import "package:teste/pages/recipe8.dart";

void main() {
  final recipes = [
    const Rcp1(),			//0
    const Rcp1_2(),		//1
    const Rcp1_3(),		//2
    const Rcp2(),			//3
    const Rcp3(),			//4
    Rcp4(),						//5
    const Rcp5(),			//6
		const Rcp6(),			//7
		const Rcp7(),			//8
		const Rcp8(),			//9
  ];
  runApp(recipes[9]);
}

