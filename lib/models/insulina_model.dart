import 'dart:convert';

class InsulinaModel {
  String? id;
  String? nome;
  DateTime? dataAbertura;
  int? diasValidade;
  int? mililitro;
  int? uiMililitro;
  int? uiDiario;
  DateTime? dataVencimento;
  int? totalDeAplicacoes;

  InsulinaModel({
    this.id,
    this.nome = '',
    this.dataAbertura,
    this.diasValidade,
    this.mililitro,
    this.uiMililitro,
    this.uiDiario,
    this.dataVencimento,
    this.totalDeAplicacoes,
  });

  InsulinaModel copyWith({
    String? id,
    String? nome,
    DateTime? dataAbertura,
    int? diasValidade,
    int? mililitro,
    int? uiMililitro,
    int? uiDiario,
    DateTime? dataVencimento,
    int? totalDeAplicacoes,
  }) {
    return InsulinaModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      dataAbertura: dataAbertura ?? this.dataAbertura,
      diasValidade: diasValidade ?? this.diasValidade,
      mililitro: mililitro ?? this.mililitro,
      uiMililitro: uiMililitro ?? this.uiMililitro,
      uiDiario: uiDiario ?? this.uiDiario,
      dataVencimento: dataVencimento ?? this.dataVencimento,
      totalDeAplicacoes: totalDeAplicacoes ?? this.totalDeAplicacoes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'dataAbertura': dataAbertura != null ? dataAbertura.toString() : null,
      'diasValidade': diasValidade,
      'mililitro': mililitro,
      'uiMililitro': uiMililitro,
      'uiDiario': uiDiario,
      'dataVencimento':
          dataVencimento != null ? dataVencimento.toString() : null,
      'totalDeAplicacoes': totalDeAplicacoes,
    };
  }

  factory InsulinaModel.fromMap(Map<String, dynamic> map) {
    return InsulinaModel(
      id: map['id'],
      nome: map['nome'],
      dataAbertura: DateTime.fromMillisecondsSinceEpoch(
          DateTime.parse(map['dataAbertura']).millisecondsSinceEpoch),
      diasValidade: map['diasValidade'],
      mililitro: map['mililitro'],
      uiMililitro: map['uiMililitro'],
      uiDiario: map['uiDiario'],
      dataVencimento: DateTime.fromMillisecondsSinceEpoch(
          DateTime.parse(map['dataVencimento']).millisecondsSinceEpoch),
      totalDeAplicacoes: map['totalDeAplicacoes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InsulinaModel.fromJson(String source) =>
      InsulinaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InsulinaModel(id: $id, nome: $nome, dataAbertura: $dataAbertura, diasValidade: $diasValidade, mililitro: $mililitro, uiMililitro: $uiMililitro, uiDiario: $uiDiario, dataVencimento: $dataVencimento, totalDeAplicacoes: $totalDeAplicacoes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InsulinaModel &&
        other.id == id &&
        other.nome == nome &&
        other.dataAbertura == dataAbertura &&
        other.diasValidade == diasValidade &&
        other.mililitro == mililitro &&
        other.uiMililitro == uiMililitro &&
        other.uiDiario == uiDiario &&
        other.dataVencimento == dataVencimento &&
        other.totalDeAplicacoes == totalDeAplicacoes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        dataAbertura.hashCode ^
        diasValidade.hashCode ^
        mililitro.hashCode ^
        uiMililitro.hashCode ^
        uiDiario.hashCode ^
        dataVencimento.hashCode ^
        totalDeAplicacoes.hashCode;
  }
}
