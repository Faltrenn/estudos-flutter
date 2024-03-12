import 'dart:ui';

import 'package:flutter/material.dart';

class Rcp1_3 extends StatelessWidget {
  const Rcp1_3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.yellow),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Boa")),
        body: const Column(
          children: [
            ExpansionTile(
              title: Text("LaFin Du Monde"),
              subtitle: Text("Beer"),
              children: [
                Column(
                  children: [
                    Text("12% alc"),
                    Text("Country: Belgium"),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Bosque dos Bois"),
              subtitle: Text("Cachaça"),
              children: [
                Column(
                  children: [
                    Text("42% alc"),
                    Text("Country: Brazil"),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Sandman"),
              subtitle: Text("Wine"),
              children: [
                Column(
                  children: [
                    Text("16% alc"),
                    Text("Country: Portugal"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
