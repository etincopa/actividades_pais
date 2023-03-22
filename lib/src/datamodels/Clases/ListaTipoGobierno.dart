class TipoGobierno {
  String? idTipoGobierno;
  String? nombre;

  TipoGobierno({this.idTipoGobierno, this.nombre});

  TipoGobierno.fromJson(Map<String, dynamic> json) {
    idTipoGobierno = json['id_tipo_gobierno'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tipo_gobierno'] = this.idTipoGobierno;
    data['nombre'] = this.nombre;
    return data;
  }
}