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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estado'] = this.estado;
    data['ut'] = this.ut;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['inicio'] = this.inicio;
    data['fin'] = this.fin;
    return data;
  }
}