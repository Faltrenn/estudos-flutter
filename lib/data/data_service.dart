import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste/util/decididor.dart';
import 'dart:convert';
import '../util/ordenador.dart';

enum TableStatus { idle, loading, ready, error }

enum ItemType {
  beer,
  coffee,
  nation,
  none;

  String get asString => '$name';
  List<String> get columns => this == coffee
      ? ["Nome", "Origem", "Intensidade"]
      : this == beer
          ? ["Nome", "Estilo", "IBU"]
          : this == nation
              ? ["Nome", "Idioma", "Capital"]
              : [];

  List<String> get properties => this == coffee
      ? ["blend_name", "origin", "intensifier"]
      : this == beer
          ? ["name", "style", "ibu"]
          : this == nation
              ? ["nationality", "language", "capital"]
              : [];
}

class DataService {
  static const MAX_N_ITEMS = 30;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 10;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n) {
    _numberOfItems = n < 0
        ? MIN_N_ITEMS
        : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  void carregar(index) {
    final params = [ItemType.coffee, ItemType.beer, ItemType.nation];
    carregarPorTipo(params[index]);
  }

  void ordenarEstadoAtual(String propriedade, [bool cresc = true]) {
    List objetos = tableStateNotifier.value['dataObjects'] ?? [];
    if (objetos.isEmpty) return;
    Ordenador ord = Ordenador();
    var objetosOrdenados = [];
    bool crescente = cresc;
    bool precisaTrocar(atual, proximo) {
      final ordemCorreta = crescente ? [atual, proximo] : [proximo, atual];
      return ordemCorreta[0][propriedade]
              .compareTo(ordemCorreta[1][propriedade]) >
          0;
    }

    objetosOrdenados = ord.ssOrdenar(objetos, precisaTrocar);
    emitirEstadoOrdenado(objetosOrdenados, propriedade);
  }

  void filtrarEstadoAtual(final String filtro) {
    List objetos = tableStateNotifier.value['previousObjects'] ?? [];
    if (objetos == []) return;
    List propriedades = tableStateNotifier.value['propertyNames'];
    Filtrador fil = Filtrador();
    DecididorFiltro d = DecididorFiltroJSON(propriedades);
    var objetosFiltrados = fil.filtrar(objetos, filtro, d.dentroDoFiltro);
    emitirEstadoFiltrado(objetos, objetosFiltrados, filtro);
  }

  void emitirEstadoOrdenado(List objetosOrdenados, String propriedade) {
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);
    estado['dataObjects'] = objetosOrdenados;
    tableStateNotifier.value = estado;
  }

  Uri montarUri(ItemType type) {
    return Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/${type.asString}/random_${type.asString}',
        queryParameters: {'size': '$_numberOfItems'});
  }

  Future<List<dynamic>> acessarApi(Uri uri) async {
    var jsonString = await http.read(uri);
    var json = jsonDecode(jsonString);
    json = [...tableStateNotifier.value['dataObjects'], ...json];
    return json;
  }

  void emitirEstadoFiltrado(
      List objetosOriginais, List objetosFiltrados, String filtro) {
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);
    estado['previousObjects'] = objetosOriginais;
    estado['dataObjects'] = objetosFiltrados;
    estado['filterCriteria'] = filtro;
    tableStateNotifier.value = estado;
  }

  void emitirEstadoCarregando(ItemType type) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': type
    };
  }

  void emitirEstadoPronto(ItemType type, var json) {
    tableStateNotifier.value = {
      'itemType': type,
      'status': TableStatus.ready,
      'dataObjects': json,
      'propertyNames': type.properties,
      'columnNames': type.columns
    };
  }

  bool temRequisicaoEmCurso() =>
      tableStateNotifier.value['status'] == TableStatus.loading;
  bool mudouTipoDeItemRequisitado(ItemType type) =>
      tableStateNotifier.value['itemType'] != type;

  void carregarPorTipo(ItemType type) async {
    if (temRequisicaoEmCurso()) return;
    if (mudouTipoDeItemRequisitado(type)) {
      emitirEstadoCarregando(type);
    }

    var uri = montarUri(type);
    var json = await acessarApi(uri);
    emitirEstadoPronto(type, json);
  }
}

final dataService = DataService();

class DecididorJson implements Decididor {
  final String prop;
  final bool crescente;

  DecididorJson(this.prop, [this.crescente = true]);
  @override
  bool precisaTrocarAtualPeloProximo(
      dynamic atual, dynamic proximo, bool crescente) {
    try {
      final ordemCorreta = crescente ? [atual, proximo] : [proximo, atual];
      return ordemCorreta[0][prop].compareTo(ordemCorreta[1][prop]) > 0;
    } catch (error) {
      return false;
    }
  }
}

class DecididorFiltroJSON extends DecididorFiltro {
  final List propriedades;

  DecididorFiltroJSON(this.propriedades);

  @override
  bool dentroDoFiltro(objeto, filtro) {
    bool achouAoMenosUm = false;
    for (int i = 0; i < propriedades.length - 1; i++) {
      achouAoMenosUm = objeto[propriedades[i]].contains(filtro) ? true : false;
      if (achouAoMenosUm) break;
    }

    return achouAoMenosUm;
  }
}

