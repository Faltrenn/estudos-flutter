import 'dart:math';
import 'package:flutter/material.dart';

class Rcp1_2 extends StatelessWidget {
  const Rcp1_2({super.key});

  @override
  Widget build(BuildContext context) {
    var rows = [
      const DataRow(cells: [
        DataCell(Text("La Fin Du Monde")),
        DataCell(Text("Sour Ale")),
        DataCell(Text("65")),
      ]),
      const DataRow(cells: [
        DataCell(Text("Sapporo Premium")),
        DataCell(Text("Sour Ale")),
        DataCell(Text("54")),
      ]),
      const DataRow(cells: [
        DataCell(Text("Duvel")),
        DataCell(Text("Pilsner")),
        DataCell(Text("82")),
      ]),
    ];
    const names = ["La Fin Du Monde", "Sapporo Premium", "Duvel"];
    const styles = ["Bock", "Sour Ale", "Pilsner"];
    for (var i = 0; i < 20; i++) {
      var name = names[Random().nextInt(names.length)];
      var style = styles[Random().nextInt(styles.length)];
      var ibu = Random().nextInt(60) + 40;
      rows.add(DataRow(cells: [
        DataCell(Text(name)),
        DataCell(Text(style)),
        DataCell(Text(ibu.toString())),
      ]));
    }
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.brown)),
      home: Scaffold(
        appBar: AppBar(title: const Text("Cervejas")),
        body: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Nome")),
              DataColumn(label: Text("Estilo")),
              DataColumn(label: Text("IBU")),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}
