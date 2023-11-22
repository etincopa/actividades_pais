class AsistenciaModel {
  int id;
  int snip;
  String tipoTrabajo;
  String tipoasistencia;
  int idUnidadTerritorial;
  String dni;
  String tipoCheck;
  String latitud;
  String longitud;
  String fechaHora;
  String idLugarPrestacion;
  String idUnidadOrganica;
  String tipohor;
  int isSelected;
  String imei;
  AsistenciaModel({
    this.id = 0,
    this.snip = 0,
    this.tipoTrabajo = '',
    this.tipoasistencia = '',
    this.idUnidadTerritorial = 0,
    this.dni = '',
    this.tipoCheck = '',
    this.latitud = '',
    this.longitud = '',
    this.fechaHora = '',
    this.idLugarPrestacion = '',
    this.idUnidadOrganica = '',
    this.tipohor = '',
    this.isSelected = 0,
    this.imei = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "snip": snip,
      "tipoTrabajo": tipoTrabajo,
      "tipoasistencia": tipoasistencia,
      "idUnidadTerritorial": idUnidadTerritorial,
      "dni": dni,
      "tipoCheck": tipoCheck,
      "latitud": latitud,
      "longitud": longitud,
      "fechaHora": fechaHora,
      "idLugarPrestacion": idLugarPrestacion,
      "idUnidadOrganica": idUnidadOrganica,
      "tipohor": tipohor,
      "isSelected": isSelected,
      "imei": imei
    };
  }

  factory AsistenciaModel.fromMap(Map<String, dynamic> map) => AsistenciaModel(
      id: map["id"],
      snip: map['snip'],
      tipoTrabajo: map['tipoTrabajo'],
      tipoasistencia: map['tipoasistencia'],
      idUnidadTerritorial: map['idUnidadTerritorial'],
      dni: map['dni'],
      tipoCheck: map['tipoCheck'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      fechaHora: map['fechaHora'],
      idLugarPrestacion: map['idLugarPrestacion'],
      idUnidadOrganica: map['idUnidadOrganica'],
      tipohor: map['tipohor'],
      isSelected: map['isSelected'],
      imei: map["imei"]);

  factory AsistenciaModel.fromJson(Map<String, dynamic> parsedJson) {
    return AsistenciaModel(
        id: parsedJson["id"],
        snip: parsedJson['snip'],
        tipoTrabajo: parsedJson['tipoTrabajo'],
        tipoasistencia: parsedJson['tipoasistencia'],
        idUnidadTerritorial: parsedJson['idUnidadTerritorial'],
        dni: parsedJson['dni'],
        tipoCheck: parsedJson['tipoCheck'],
        latitud: parsedJson['latitud'],
        longitud: parsedJson['longitud'],
        fechaHora: parsedJson['fechaHora'],
        idLugarPrestacion: parsedJson['idLugarPrestacion'],
        idUnidadOrganica: parsedJson['idUnidadOrganica'],
        tipohor: parsedJson['tipohor'],
        isSelected: parsedJson['isSelected'],
        imei: parsedJson["imei"]);
  }
}
