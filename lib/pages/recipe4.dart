import 'dart:developer';

import 'package:flutter/material.dart';

var dataObjects = [
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
];

class Rcp4 extends StatelessWidget {
  Rcp4({super.key});

  final bodies = [
    DataBodyWidget(
      columnNames: const ["Nome", "Estilo", "IBU"],
      propertyNames: const ["name", "style", "ibu"],
      objects: dataObjects,
    ),
    MytileWidget(
      propertyNames: const ["name", "style", "ibu"],
      objects: dataObjects,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.pink),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: bodies[1],
        bottomNavigationBar: const NewNavBar(),
      ),
    );
  }
}

class NewNavBar extends StatelessWidget {
  const NewNavBar({super.key});

  void botaoFoiTocado(int index) {
    log("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [
      BottomNavigationBarItem(
        label: "Cafés",
        icon: Icon(Icons.coffee_outlined),
      ),
      BottomNavigationBarItem(
        label: "Cervejas",
        icon: Icon(Icons.local_drink_outlined),
      ),
      BottomNavigationBarItem(
        label: "Nações",
        icon: Icon(Icons.flag_outlined),
      )
    ]);
  }
}

class DataBodyWidget extends StatelessWidget {
  List objects;
  List<String> columnNames, propertyNames;
  DataBodyWidget({
    super.key,
    this.columnNames = const [],
    this.propertyNames = const [],
    this.objects = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: columnNames
            .map(
              (name) => DataColumn(
                label: Expanded(
                  child: Text(name,
                      style: const TextStyle(fontStyle: FontStyle.italic)),
                ),
              ),
            )
            .toList(),
        rows: objects
            .map(
              (obj) => DataRow(
                cells: propertyNames
                    .map(
                      (name) => DataCell(Text(obj[name])),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class MytileWidget extends StatelessWidget {
  List objects;
  List<String> propertyNames;
  MytileWidget({
    super.key,
    this.propertyNames = const [],
    this.objects = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: objects
          .map(
            (obj) => ListTile(
              title: Text(obj[propertyNames[0]]),
              subtitle: Text(obj[propertyNames[1]]),
              trailing: Text(obj[propertyNames[2]]),
            ),
          )
          .toList(),
    );
  }
}
