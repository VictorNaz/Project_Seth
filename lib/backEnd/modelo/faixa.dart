class Faixa {
  String? id;
  String? faixa;
  String? grau;
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

  String? get getGrau {
    return grau;
  }

  set setGrau(String grau) {
    this.grau = grau;
  }

  int? get getQuantAulas {
    return quantAulas;
  }

  set setQuantAulas(int quantAulas) {
    this.quantAulas = quantAulas;
  }
}
