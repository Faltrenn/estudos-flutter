import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

enum ItemType { beer, coffee, nation, none }

class DataService {
  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n) {
    _numberOfItems = n < 0
        ? MIN_N_ITEMS
        : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  get numberOfItems {
    return _numberOfItems;
  }

  ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
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
    } else if (tableStateNotifier.value['status'] == TableStatus.loading) {
      return;
    }

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
        queryParameters: {'size': '$_numberOfItems'});

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
}

final dataService = DataService();
