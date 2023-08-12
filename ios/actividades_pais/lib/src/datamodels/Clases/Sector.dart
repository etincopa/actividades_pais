class Sector {
  String? idSector;
  String? nombreSector;
  String? nombreLargo;
  String? idTipoGobierno;

  Sector(
      {this.idSector,
        this.nombreSector,
        this.nombreLargo,
        this.idTipoGobierno});

  Sector.fromJson(Map<String, dynamic> json) {
    idSector = json['id_sector'];
    nombreSector = json['nombre_sector'];
    nombreLargo = json['nombre_largo'];
    idTipoGobierno = json['id_tipo_gobierno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_sector'] = idSector;
    data['nombre_sector'] = nombreSector;
    data['nombre_largo'] = nombreLargo;
    data['id_tipo_gobierno'] = idTipoGobierno;
    return data;
  }
}