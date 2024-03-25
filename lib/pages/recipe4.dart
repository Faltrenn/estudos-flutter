import 'dart:developer';

import 'package:flutter/material.dart';

var dataObjects = [
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"}
];

class Rcp4 extends StatelessWidget {
  const Rcp4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: DataBodyWidget(objects: dataObjects),
          bottomNavigationBar: const NewNavBar(),
        ));
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
  DataBodyWidget({super.key, this.objects = const []});

  @override
  Widget build(BuildContext context) {
    var columnNames = ["Nome", "Estilo", "IBU"],
        propertyNames = ["name", "style", "ibu"];

    return DataTable(
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
    );
  }
}
