class TipoGobierno {
  String? idTipoGobierno;
  String? nombre;

  TipoGobierno({this.idTipoGobierno, this.nombre});

  TipoGobierno.fromJson(Map<String, dynamic> json) {
    idTipoGobierno = json['id_tipo_gobierno'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tipo_gobierno'] = idTipoGobierno;
    data['nombre'] = nombre;
    return data;
  }
}