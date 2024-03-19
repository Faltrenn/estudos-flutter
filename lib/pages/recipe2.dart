import "package:flutter/material.dart";

class MyDrinks extends StatelessWidget {
  const MyDrinks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Expanded(
        child: Text("La Fin Du Monde - Bock - 65 ibu"),
      ),
      Expanded(
        child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
      ),
      Expanded(
        child: Text("Duvel - Pilsner - 82 ibu"),
      )
    ]);
  }
}

class Drink {
  String label;
  Icon icon;
  Drink(this.label, this.icon);
}

class MyNavItems extends StatelessWidget {
  MyNavItems({super.key});

  var items = [
    Drink("Cafés", Icon(Icons.coffee_outlined)),
    Drink("Cervejas", Icon(Icons.local_drink_outlined)),
    Drink("Nações", Icon(Icons.flag_outlined)),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        // ignore: avoid_print
        onTap: (i) => print("Toque: $i"),
        items: items.map((e) => BottomNavigationBarItem(label: e.label, icon: e.icon)).toList());
  }
}

class MyAppBar extends AppBar {
  MyAppBar({super.key}) : super(title: const Text("Dicas"));
}

class Rcp2 extends StatelessWidget {
  const Rcp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple)),
        home: Scaffold(
          appBar: MyAppBar(),
          body: const MyDrinks(),
          bottomNavigationBar: MyNavItems(),
        ));
  }
}
