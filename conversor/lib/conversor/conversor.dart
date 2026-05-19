// Classe pura de lógica — sem qualquer import do Flutter!
// Pode ser testada isoladamente sem rodar o app.

enum TipoConversao { temperatura, moeda, distancia, massa }

extension TipoConversaoInfo on TipoConversao {
  String get titulo => switch (this) {
        TipoConversao.temperatura => 'Temperatura',
        TipoConversao.moeda => 'Moeda',
        TipoConversao.distancia => 'Distância',
        TipoConversao.massa => 'Massa',
      };

  String get emoji => switch (this) {
        TipoConversao.temperatura => '🌡️',
        TipoConversao.moeda => '💰',
        TipoConversao.distancia => '📏',
        TipoConversao.massa => '⚖️',
      };

  List<String> get unidades => switch (this) {
        TipoConversao.temperatura => ['°C', '°F', 'K'],
        TipoConversao.moeda => ['BRL', 'USD', 'EUR'],
        TipoConversao.distancia => ['km', 'mi', 'm'],
        TipoConversao.massa => ['kg', 'lb', 'g'],
      };
}

class Conversor {
  const Conversor._();

  // Converte um valor de uma unidade para outra.
  // Retorna o próprio valor quando as unidades são iguais.
  static double converter(
    TipoConversao tipo,
    double valor,
    String de,
    String para,
  ) {
    if (de == para) return valor;

    return switch (tipo) {
      TipoConversao.temperatura => _temperatura(valor, de, para),
      TipoConversao.moeda => _moeda(valor, de, para),
      TipoConversao.distancia => _distancia(valor, de, para),
      TipoConversao.massa => _massa(valor, de, para),
    };
  }

  static double _temperatura(double valor, String de, String para) {
    // Estratégia: converte tudo para Celsius primeiro e depois para a unidade destino.
    final emCelsius = switch (de) {
      '°C' => valor,
      '°F' => (valor - 32) * 5 / 9,
      'K' => valor - 273.15,
      _ => throw ArgumentError('Unidade de temperatura inválida: $de'),
    };

    return switch (para) {
      '°C' => emCelsius,
      '°F' => emCelsius * 9 / 5 + 32,
      'K' => emCelsius + 273.15,
      _ => throw ArgumentError('Unidade de temperatura inválida: $para'),
    };
  }

  static double _moeda(double valor, String de, String para) {
    // Taxas didáticas aproximadas.
    // Em uma aplicação real, esses valores deveriam vir de uma API.
    const taxasParaBrl = {
      'BRL': 1.0,
      'USD': 5.0,
      'EUR': 5.5,
    };

    final taxaOrigem = taxasParaBrl[de];
    final taxaDestino = taxasParaBrl[para];

    if (taxaOrigem == null) {
      throw ArgumentError('Moeda de origem inválida: $de');
    }

    if (taxaDestino == null) {
      throw ArgumentError('Moeda de destino inválida: $para');
    }

    final emBrl = valor * taxaOrigem;
    return emBrl / taxaDestino;
  }

  static double _distancia(double valor, String de, String para) {
    const fatoresParaMetros = {
      'km': 1000.0,
      'mi': 1609.34,
      'm': 1.0,
    };

    final fatorOrigem = fatoresParaMetros[de];
    final fatorDestino = fatoresParaMetros[para];

    if (fatorOrigem == null) {
      throw ArgumentError('Unidade de distância de origem inválida: $de');
    }

    if (fatorDestino == null) {
      throw ArgumentError('Unidade de distância de destino inválida: $para');
    }

    final metros = valor * fatorOrigem;
    return metros / fatorDestino;
  }

  static double _massa(double valor, String de, String para) {
    const fatoresParaGramas = {
      'kg': 1000.0,
      'lb': 453.592,
      'g': 1.0,
    };

    final fatorOrigem = fatoresParaGramas[de];
    final fatorDestino = fatoresParaGramas[para];

    if (fatorOrigem == null) {
      throw ArgumentError('Unidade de massa de origem inválida: $de');
    }

    if (fatorDestino == null) {
      throw ArgumentError('Unidade de massa de destino inválida: $para');
    }

    final gramas = valor * fatorOrigem;
    return gramas / fatorDestino;
  }
}