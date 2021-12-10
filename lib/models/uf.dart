class UFs {
  static List<UF> fromJson(Map<String, dynamic> json) {
    var items = <UF>[];
    if (json['UF'] != null) {
      json['UF'].forEach((v) {
        items.add(new UF.fromJson(v));
      });
    }
    return items;
  }
}

class UF {
  String nome;
  String sigla;

  UF({required this.nome, required this.sigla});

  UF.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        sigla = json['sigla'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['sigla'] = this.sigla;
    return data;
  }
}
