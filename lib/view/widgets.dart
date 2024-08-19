import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../data/data_service.dart';

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
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: columnNames
                    .map((name) => DataColumn(
                        label: Expanded(
                            child: Text(name,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic)))))
                    .toList(),
                rows: jsonObjects
                    .map((obj) => DataRow(
                        cells: propertyNames
                            .map((propName) => DataCell(Text(obj[propName])))
                            .toList()))
                    .toList())));
  }
}
