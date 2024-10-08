import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

enum ItemType { beer, coffee, nation, none }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  final funcoes = [
    {
      "path": "coffee/random_coffee",
      "itemType": ItemType.coffee,
      'propertyNames': ["blend_name", "origin", "variety"],
      'columnNames': ["Nome", "Origem", "Tipo"]
    },
    {
      "path": "beer/random_beer",
      "itemType": ItemType.beer,
      'propertyNames': ["name", "style", "ibu"],
      'columnNames': ["Nome", "Estilo", "IBU"]
    },
    {
      "path": "nation/random_nation",
      "itemType": ItemType.nation,
      'propertyNames': ["nationality", "capital", "language", "national_sport"],
      'columnNames': ["Nome", "Capital", "Idioma", "Esporte"]
    },
  ];

  void carregar(index) {
    if (tableStateNotifier.value["itemType"] != funcoes[index]["itemType"]) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': funcoes[index]["itemType"]
      };
    } else if (tableStateNotifier.value['status'] == TableStatus.loading)
      return;

    if (tableStateNotifier.value['itemType'] != funcoes[index]["itemType"]) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': funcoes[index]["itemType"]
      };
    }

    var uri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/${funcoes[index]["path"]! as String}',
        queryParameters: {'size': '10'});

    http.read(uri).then((jsonString) {
      var json = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'itemType': funcoes[index]["itemType"],
        'status': TableStatus.ready,
        "dataObjects": [...tableStateNotifier.value['dataObjects'], ...json],
        'propertyNames': funcoes[index]["propertyNames"],
        'columnNames': funcoes[index]["columnNames"]
      };
    });
  }

  void carregarCafes() {
    //ignorar solicitação se uma requisição já estiver em curso

    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    if (tableStateNotifier.value['itemType'] != ItemType.coffee) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.coffee
      };
    }

    var coffeesUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/coffee/random_coffee',
        queryParameters: {'size': '10'});

    http.read(coffeesUri).then((jsonString) {
      var coffeesJson = jsonDecode(jsonString);

      //se já houver cafés no estado da tabela...

      if (tableStateNotifier.value['status'] != TableStatus.loading) {
        coffeesJson = [
          ...tableStateNotifier.value['dataObjects'],
          ...coffeesJson
        ];
      }

      tableStateNotifier.value = {
        'itemType': ItemType.coffee,
        'status': TableStatus.ready,
        'dataObjects': coffeesJson,
        'propertyNames': ["blend_name", "origin", "variety"],
        'columnNames': ["Nome", "Origem", "Tipo"]
      };
    });
  }
}

final dataService = DataService();

class Rcp8a extends StatelessWidget {
  Rcp8a({super.key});
  final functionsMap = {
    ItemType.beer: () => dataService.carregar(1),
    ItemType.coffee: () => dataService.carregar(0),
    ItemType.nation: () => dataService.carregar(2)
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            // ignore: prefer_interpolation_to_compose_strings
            title: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (context, value, child) {
                return Text(
                  "Dicas (${value['dataObjects'].length})",
                );
              },
            ),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                switch (value['status']) {
                  case TableStatus.idle:
                    return const Center(
                        child: Text("Toque algum botão, abaixo..."));

                  case TableStatus.loading:
                    return const Center(child: CircularProgressIndicator());

                  case TableStatus.ready:
                    return ListWidget(
                      jsonObjects: value['dataObjects'],
                      propertyNames: value['propertyNames'],
                      scrollEndedCallback: functionsMap[value['itemType']],
                    );

                  case TableStatus.error:
                    return const Text("Lascou");
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
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class ListWidget extends HookWidget {
  final dynamic _scrollEndedCallback;
  final List jsonObjects;
  final List<String> propertyNames;
  const ListWidget(
      {super.key,
      this.jsonObjects = const [],
      this.propertyNames = const [],
      void Function()? scrollEndedCallback})
      : _scrollEndedCallback = scrollEndedCallback ?? false;

  @override
  Widget build(BuildContext context) {
    var controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          if (_scrollEndedCallback is Function) _scrollEndedCallback();
        }
      });
      return null;
    }, [controller]);
    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.all(10),
      separatorBuilder: (_, __) => Divider(
        height: 5,
        thickness: 2,
        indent: 10,
        endIndent: 10,
        color: Theme.of(context).primaryColor,
      ),
      itemCount: jsonObjects.length + 1,
      itemBuilder: (_, index) {
        if (index == jsonObjects.length) {
          return const Center(child: LinearProgressIndicator());
        }
        var title = jsonObjects[index][propertyNames[0]];

        var content = propertyNames
            .sublist(1)
            .map((prop) => jsonObjects[index][prop])
            .join(" - ");

        return Card(
            shadowColor: Theme.of(context).primaryColor,
            child: Column(children: [
              const SizedBox(height: 10),

              //a primeira propriedade vai em negrito

              Text("$title\n",
                  style: const TextStyle(fontWeight: FontWeight.bold)),

              //as demais vão normais

              Text(content),

              const SizedBox(height: 10)
            ]));
      },
    );
  }
}
