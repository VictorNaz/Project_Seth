class Faixa {
  String? id;
  String? faixa;
  int? grau;
  int? quantAulas;

  String? get getId {
    return id;
  }

  set setId(String id) {
    this.id = id;
  }

  String? get getFaixa {
    return faixa;
  }

  set setFaixa(String faixa) {
    this.faixa = faixa;
  }

  int? get getGrau {
    return grau;
  }

  set setGrau(int grau) {
    this.grau = grau;
  }

  int? get getQuantAulas {
    return quantAulas;
  }

  set setQuantAulas(int quantAulas) {
    this.quantAulas = quantAulas;
  }
}
