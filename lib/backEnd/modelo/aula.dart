class Aula {
  Aula({required this.id, required this.pilar, required this.aula});

  int id;
  int pilar;
  int aula;

  int get getId {
    return id;
  }

  set setId(int id) {
    this.id = id;
  }

  int get getPilar {
    return pilar;
  }

  set setPilar(int pilar) {
    this.pilar = pilar;
  }

  int get getAula {
    return aula;
  }

  set setAula(int aula) {
    this.aula = aula;
  }
}
