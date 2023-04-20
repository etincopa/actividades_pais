class FiltroIntervencionesTambos {
  String? id;
  String? tipo;
  String? estado;
  String? ut="x";
  String? inicio;
  String? fin;
  String? mes;
  int? anio;

  FiltroIntervencionesTambos(
      {this.id,
        this.tipo,
        this.estado,
        this.ut="x",
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['estado'] = this.estado;
    data['ut'] = this.ut;
    data['inicio'] = this.inicio;
    data['fin'] = this.fin;
    data['mes'] = this.mes;
    data['anio'] = this.anio;
    return data;
  }
}