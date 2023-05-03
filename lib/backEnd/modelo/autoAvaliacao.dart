// ignore_for_file: non_constant_identifier_names

class AutoAvaliacao {
  String? id;
  int? alimentacao;
  int? atividade_fisica;
  int? auto_controle;
  int? defesa_pessoal;
  int? relacionamento;
  int? espiritual;
  int? prevencao;
  String? aluno_id;

  String? get getId {
    return id;
  }

  set setId(String id) {
    this.id = id;
  }

  int? get getAlimentacao {
    return alimentacao;
  }

  set setAlimentacao(int alimentacao) {
    this.alimentacao = alimentacao;
  }
}
