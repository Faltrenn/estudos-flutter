import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> carregarCafes() async {
		var coffeeUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': '5'});
    
    var jsonString = await http.read(coffeeUri);
    var coffeeJson = jsonDecode(jsonString);
    tableStateNotifier.value = DataTableInfo(
      jsonObjects: coffeeJson,
      propertyNames: ["blend_name", "origin", "variety"],
      columnNames: ["Nome", "Origem", "Variedade"],
    );
  }
	
  Future<void> carregarNacoes() async {
		var nationsUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/nation/random_nation',
      queryParameters: {'size': '5'});
    
    var jsonString = await http.read(nationsUri);
    var nationJson = jsonDecode(jsonString);
    tableStateNotifier.value = DataTableInfo(
      jsonObjects: nationJson,
      propertyNames: ["nationality", "language", "capital"],
      columnNames: ["Nacionalidade", "Língua", "Capital"],
    );
  }

  Future<void> carregarCervejas() async {
		var beersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/beer/random_beer',
      queryParameters: {'size': '5'});
    
    var jsonString = await http.read(beersUri);
    var beersJson = jsonDecode(jsonString);
    tableStateNotifier.value = DataTableInfo(
      jsonObjects: beersJson,
      propertyNames: ["brand", "name", "style"],
      columnNames: ["Brand", "Nome", "Style"],
    );
  }


}

final dataService = DataService();

class Rcp7 extends StatelessWidget {
  const Rcp7({super.key});

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

