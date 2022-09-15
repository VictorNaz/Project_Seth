class Faixa {
  Faixa(
      {required this.id,
      required this.faixa,
      required this.grau,
      required this.quantAulas});

  int id;
  int faixa;
  int grau;
  int quantAulas;

  int get getId {
    return id;
  }

  set setId(int id) {
    this.id = id;
  }

  int get getFaixa {
    return faixa;
  }

  set setFaixa(int faixa) {
    this.faixa = faixa;
  }

  int get getGrau {
    return grau;
  }

  set setGrau(int grau) {
    this.grau = grau;
  }

  int get getQuantAulas {
    return quantAulas;
  }

  set setQuantAulas(int quantAulas) {
    this.quantAulas = quantAulas;
  }
}
