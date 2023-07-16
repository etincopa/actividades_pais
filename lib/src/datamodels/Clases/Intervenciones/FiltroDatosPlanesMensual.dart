class FiltroDataPlanMensual {
  String? id;
  String? estado;
  String? ut;
  int? pageIndex;
  int? pageSize;
  String? inicio;
  String? fin;

  FiltroDataPlanMensual(
      {this.id,
        this.estado,
        this.ut,
        this.pageIndex,
        this.pageSize,
        this.inicio,
        this.fin});

  FiltroDataPlanMensual.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = json['estado'];
    ut = json['ut'];
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    inicio = json['inicio'];
    fin = json['fin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['estado'] = estado;
    data['ut'] = ut;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['inicio'] = inicio;
    data['fin'] = fin;
    return data;
  }
}