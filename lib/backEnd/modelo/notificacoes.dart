// ignore_for_file: non_constant_identifier_names

class Notificacoes {
  int? idNotificacoes;
  String? nomeAluno;
  String? usuarioAluno;
  int? grau;
  String? faixa;
  String?
      is_Faixa; //*Vem do DB como true ou false; Verifica se a notificação é faixa ou grau

  Notificacoes(this.idNotificacoes, this.usuarioAluno, this.nomeAluno,
      this.grau, this.faixa, this.is_Faixa);

  int? get getIdNotificacoes {
    return idNotificacoes;
  }

  set setIdNotificacoes(int idNotificacoes) {
    this.idNotificacoes = idNotificacoes;
  }

  String? get getNomeAluno {
    return nomeAluno;
  }

  set setNomeAluno(String nomeAluno) {
    this.nomeAluno = nomeAluno;
  }

  String? get getUsuarioAluno {
    return usuarioAluno;
  }

  set setUsuarioAluno(String usuarioAluno) {
    this.usuarioAluno = usuarioAluno;
  }

  int? get getGrau {
    return grau;
  }

  set setGrau(int grau) {
    this.grau = grau;
  }

  String? get getFaixa {
    return faixa;
  }

  set setFaixa(String faixa) {
    this.faixa = faixa;
  }

  String? get getIs_Faixa {
    return is_Faixa;
  }

  set setIs_Faixa(String is_Faixa) {
    this.is_Faixa = is_Faixa;
  }
}

class ListaNoti {
  List notificacoes = [];

  ListaNoti(this.notificacoes);
}
