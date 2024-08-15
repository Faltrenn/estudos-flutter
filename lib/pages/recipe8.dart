import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({"status": TableStatus.idle, "dataObjects": []});

  void carregar(index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes, carregarVeiculos];
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': []
    };
    funcoes[index]();
  }

  Future<void> carregarCafes() async {
    var coffeeUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/coffee/random_coffee',
        queryParameters: {'size': '5'});

    try {
      var jsonString = await http.read(coffeeUri);
      var coffeeJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        "status": TableStatus.ready,
        "dataObjects": coffeeJson,
        "propertyNames": ["blend_name", "origin", "variety"],
        "columnNames": ["Blend", "Origin", "Variety"]
      };
    } catch (e) {
      tableStateNotifier.value = {
        "status": TableStatus.error,
        "message": "Falha ao carregar dados."
      };
    }
  }

  void carregarNacoes() {
    var nationsUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/nation/random_nation',
        queryParameters: {'size': '5'});

    http.read(nationsUri).then((jsonString) {
      var nationJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        "status": TableStatus.ready,
        "dataObjects": nationJson,
        "propertyNames": ["nationality", "language", "capital"],
        "columnNames": ["Nationality", "Language", "Capital"]
      };
    }).catchError((e) {
      tableStateNotifier.value = {"status": TableStatus.error};
    });
  }

  void carregarCervejas() {
    var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/beer/random_beer',
        queryParameters: {'size': '5'});

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        "status": TableStatus.ready,
        "dataObjects": beersJson,
        "propertyNames": ["name", "style", "ibu"],
        "columnNames": ["Name", "style", "ibu"]
      };
    }).catchError((e) {
      tableStateNotifier.value = {"status": TableStatus.error};
    });
  }

  void carregarVeiculos() {
    var vehicleUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/vehicle/random_vehicle',
        queryParameters: {'size': '5'});

    http.read(vehicleUri).then((jsonString) {
      var vehicleJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        "status": TableStatus.ready,
        "dataObjects": vehicleJson,
        "propertyNames": ["make_and_model", "transmission", "car_type"],
        "columnNames": ["Model", "transmission", "type"]
      };
    }).catchError((e) {
      tableStateNotifier.value = {"status": TableStatus.error};
    });
  }
}

final dataService = DataService();

class Rcp8 extends StatelessWidget {
  const Rcp8({super.key});

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
                switch (value['status']) {
                  case TableStatus.idle:
                    return const Center(
                        child: Text(
                            "Escolha alguma das opções abaixo e aguarde as informações"));

                  case TableStatus.loading:
                    return const Center(child: CircularProgressIndicator());

                  case TableStatus.ready:
                    return DataTableWidget(
                        jsonObjects: value['dataObjects'],
                        propertyNames: value["propertyNames"],
                        columnNames: value["columnNames"]);

                  case TableStatus.error:
                    return const Center(child: Text("Houve um erro na busca dos dados"));
                }

                return const Text("...");
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  const NewNavBar({super.key, itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int);

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;

          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined)),
          BottomNavigationBarItem(
              label: "Veículos", icon: Icon(Icons.car_crash))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  const DataTableWidget(
      {super.key,
      this.jsonObjects = const [],
      this.columnNames = const [],
      this.propertyNames = const []});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: const TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}
