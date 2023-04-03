class LugarIntervencion {
  int? idLugarIntervencion;
  String? nombreLugarIntervencion;

  LugarIntervencion({this.idLugarIntervencion, this.nombreLugarIntervencion});

  LugarIntervencion.fromJson(Map<String, dynamic> json) {
    idLugarIntervencion = json['id_lugar_intervencion'];
    nombreLugarIntervencion = json['nombre_lugar_intervencion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lugar_intervencion'] = this.idLugarIntervencion;
    data['nombre_lugar_intervencion'] = this.nombreLugarIntervencion;
    return data;
  }
}