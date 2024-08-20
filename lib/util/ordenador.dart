import 'decididor.dart';

class Ordenador {
  List ordenarItem(List item, Decididor decididor) {
    List itemOrdenadas = List.of(item);

    bool trocouAoMenosUm;

    do {
      trocouAoMenosUm = false;

      for (int i = 0; i < itemOrdenadas.length - 1; i++) {
        var atual = itemOrdenadas[i];

        var proximo = itemOrdenadas[i + 1];

        if (decididor.precisaTrocarAtualPeloProximo(atual, proximo)) {
          var aux = itemOrdenadas[i];

          itemOrdenadas[i] = itemOrdenadas[i + 1];

          itemOrdenadas[i + 1] = aux;

          trocouAoMenosUm = true;
        }
      }
    } while (trocouAoMenosUm);

    return itemOrdenadas;
  }

  List ordenarItem2(List item, Function funcaoCall) {
    List itemOrdenadas = List.of(item);

    bool trocouAoMenosUm;

    final funcao = funcaoCall;

    do {
      trocouAoMenosUm = false;

      for (int i = 0; i < itemOrdenadas.length - 1; i++) {
        var atual = itemOrdenadas[i];

        var proximo = itemOrdenadas[i + 1];

        if (funcao(atual, proximo)) {
          var aux = itemOrdenadas[i];

          itemOrdenadas[i] = itemOrdenadas[i + 1];

          itemOrdenadas[i + 1] = aux;

          trocouAoMenosUm = true;
        }
      }
    } while (trocouAoMenosUm);

    return itemOrdenadas;
  }

  List ordenarFuderoso(List objetos, String property) {
    List objetosOrdenados = List.of(objetos);

    bool trocouAoMenosUm;

    do {
      trocouAoMenosUm = false;

      for (int i = 0; i < objetosOrdenados.length - 1; i++) {
        var atual = objetosOrdenados[i];

        var proximo = objetosOrdenados[i + 1];

        if (atual[property].compareTo(proximo[property]) > 0) {
          var aux = objetosOrdenados[i];

          objetosOrdenados[i] = objetosOrdenados[i + 1];

          objetosOrdenados[i + 1] = aux;

          trocouAoMenosUm = true;
        }
      }
    } while (trocouAoMenosUm);

    return objetosOrdenados;
  }
}

