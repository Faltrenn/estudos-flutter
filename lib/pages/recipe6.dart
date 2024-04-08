import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataTableInfo {
  var jsonObjects = [];
  List<String> propertyNames = [];
  List<String> columnNames = [];
  DataTableInfo({
    this.jsonObjects = const [],
    this.propertyNames = const [],
    this.columnNames = const [],
  });
}

class DataService {
  final ValueNotifier<DataTableInfo> tableStateNotifier =
      ValueNotifier(DataTableInfo());
  var listas = [];
  DataService() {
    listas = [carregarCafes, carregarCervejas, carregarNacoes];
  }

  void carregar(index) {
    listas[index]();
  }

  void carregarCafes() {
    tableStateNotifier.value = DataTableInfo(
      jsonObjects: [
        {"name": "Três corações", "style": "Amargo", "score": "75"},
        {"name": "Pilão", "style": "Meio amargo", "score": "64"},
        {"name": "União", "style": "Amargo", "score": "82"}
      ],
      propertyNames: ["name", "style", "score"],
      columnNames: ["Name", "Estilo", "Nota"],
    );
  }

  void carregarCervejas() {
    tableStateNotifier.value = DataTableInfo(
      jsonObjects: [
        {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
        {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
        {"name": "Duvel", "style": "Pilsner", "ibu": "82"}
      ],
      propertyNames: ["name", "style", "ibu"],
      columnNames: ["Name", "Estilo", "Nota"],
    );
  }

  void carregarNacoes() {
    tableStateNotifier.value = DataTableInfo(
      jsonObjects: [
        {"name": "Brasil", "reality": "Corrupto", "score": "13"},
        {"name": "Venezuela", "reality": "Fome", "score": "-3"},
        {"name": "Argentina", "reality": "Pobre", "score": "22"}
      ],
      propertyNames: ["name", "reality", "score"],
      columnNames: ["Name", "Realidade", "Nota"],
    );
  }
}

final dataService = DataService();

class Rcp6 extends StatelessWidget {
  const Rcp6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            if (value.jsonObjects.isNotEmpty) {
              return DataTableWidget(
                jsonObjects: value.jsonObjects,
                propertyNames: value.propertyNames,
                columnNames: value.columnNames,
              );
            }
						return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar:
            NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  var itemSelectedCallback; //esse atributo será uma função

  NewNavBar({super.key, this.itemSelectedCallback}) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(-1);
    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          itemSelectedCallback(index);
        },
				fixedColor: state.value == -1 ? Colors.grey[600] : null,
        currentIndex: state.value != -1 ? state.value : 0,
        items: const [
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

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  const DataTableWidget({
    super.key,
    this.jsonObjects = const [],
    this.columnNames = const [],
    this.propertyNames = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames
          .map((name) => DataColumn(
                label: Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ))
          .toList(),
      rows: jsonObjects
          .map((obj) => DataRow(
              cells: propertyNames
                  .map((propName) => DataCell(Text(obj[propName])))
                  .toList()))
          .toList(),
    );
  }
}
