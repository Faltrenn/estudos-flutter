import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

var dataObjects = [];

class Rcp5 extends StatelessWidget {
  const Rcp5({super.key});

  @override
  Widget build(BuildContext context) {
    print("Build da classe Rcp5");
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: DataTableWidget(jsonObjects: dataObjects),
        bottomNavigationBar: NewNavBar2(),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  const NewNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    print("Build da classe NewNavBar");
    var state = useState(1);
    return BottomNavigationBar(
      onTap: (i) => state.value = i,
      currentIndex: state.value,
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
      ],
    );
  }
}

class NewNavBar2 extends StatefulWidget {
  const NewNavBar2({super.key});

  @override
  State<StatefulWidget> createState() => _NewNavBar2();
}

class _NewNavBar2 extends State<NewNavBar2> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    print("Build da classe NewNavBar2");
    return BottomNavigationBar(
      onTap: (i) => setState(() { index = i; }),
      currentIndex: index,
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
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  const DataTableWidget({super.key, this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    print("Build da classe DataTableWidget");
    var columnNames = ["Nome", "Estilo", "IBU"],
        propertyNames = ["name", "style", "ibu"];

    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          )
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
