class FiltroIntervencionesTambos {
  String? id = "x";
  String? tipo;
  String? estado;
  String? ut = "x";
  String? inicio = "x";
  String? fin;
  String? mes;
  int? anio;

  FiltroIntervencionesTambos(
      {this.id = "x",
      this.tipo = "x",
      this.estado = "x",
      this.ut = "x",
      this.inicio,
      this.fin,
      this.mes,
      this.anio});

  FiltroIntervencionesTambos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    estado = json['estado'];
    ut = json['ut'];
    inicio = json['inicio'];
    fin = json['fin'];
    mes = json['mes'];
    anio = json['anio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = tipo;
    data['estado'] = estado;
    data['ut'] = ut;
    data['inicio'] = inicio;
    data['fin'] = fin;
    data['mes'] = mes;
    data['anio'] = anio;
    return data;
  }
}
