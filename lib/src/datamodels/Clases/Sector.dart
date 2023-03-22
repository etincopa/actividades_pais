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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sector'] = this.idSector;
    data['nombre_sector'] = this.nombreSector;
    data['nombre_largo'] = this.nombreLargo;
    data['id_tipo_gobierno'] = this.idTipoGobierno;
    return data;
  }
}