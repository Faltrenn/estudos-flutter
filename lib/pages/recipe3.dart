import 'dart:developer';

import 'package:flutter/material.dart';

class Rcp3 extends StatelessWidget {
  const Rcp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBar(),
        body: DataBodyWidget(
          objects: const [
            "La Fin Du Monde - Bock - 65 ibu",
            "Sapporo Premiume - Sour Ale - 54 ibu",
            "Duvel - Pilsner - 82 ibu",
          ],
        ),
        bottomNavigationBar: NewNavBar(
          drinks: [
            Drink("Café", const Icon(Icons.coffee_outlined)),
            Drink("Cervejas", const Icon(Icons.local_drink_outlined)),
            Drink("Nações", const Icon(Icons.flag_outlined)),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends AppBar {
  MyAppBar({super.key}) : super(title: const Text("Dicas"));
}

class Drink {
  String label;
  Icon icon;
  Drink(this.label, this.icon);
}

class NewNavBar extends StatelessWidget {
  List<Drink> drinks;
  NewNavBar({super.key, this.drinks = const []});

  void botaoFoiTocado(int index) {
    log("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: botaoFoiTocado,
      items: drinks
          .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
          .toList(),
    );
  }
}

class DataBodyWidget extends StatelessWidget {
  List<String> objects;
  DataBodyWidget({super.key, this.objects = const []});
  @override
  Widget build(BuildContext context) {
    return Column(
        children: objects.map((e) => Expanded(child: Text(e))).toList());
  }
}

