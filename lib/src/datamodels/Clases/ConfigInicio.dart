class ListarConfigInicio {
  List<ConfigInicio> items = [];

  ListarConfigInicio();

  ListarConfigInicio.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = ConfigInicio.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class ConfigInicio {
  int idConfigInicio = 0;
  int idLugarPrestacion = 0;
  String lugarPrestacion = '';
  int idUnidadesOrganicas = 0;
  String unidadesOrganicas = '';
  int idPuesto = 0;
  String puesto = '';
  int idUnidTerritoriales = 0;
  String unidTerritoriales = '';
  int idTambo = 0;
  String nombreTambo = '';
  int snip = 0;
  String tipoPlataforma = '';
  String campania = '';
  String codCampania = '';
  String modalidad = '';

  ConfigInicio({
    this.idConfigInicio = 0,
    this.idLugarPrestacion = 0,
    this.lugarPrestacion = '',
    this.idUnidadesOrganicas = 0,
    this.unidadesOrganicas = '',
    this.idPuesto = 0,
    this.puesto = '',
    this.idUnidTerritoriales = 0,
    this.unidTerritoriales = '',
    this.idTambo = 0,
    this.nombreTambo = '',
    this.tipoPlataforma = '',
    this.snip = 0,
    this.campania = '',
    this.codCampania = '',
    this.modalidad = '',
  });

  Map<String, dynamic> toMap() {
    return {
      //"idConfigInicio": idConfigInicio,
      "idLugarPrestacion": idLugarPrestacion,
      "lugarPrestacion": lugarPrestacion,
      "idUnidadesOrganicas": idUnidadesOrganicas,
      "unidadesOrganicas": unidadesOrganicas,
      "idPuesto": idPuesto,
      "puesto": puesto,
      "idUnidTerritoriales": idUnidTerritoriales,
      "unidTerritoriales": unidTerritoriales,
      "idTambo": idTambo,
      "nombreTambo": nombreTambo,
      "tipoPlataforma": tipoPlataforma,
      "snip": snip,
      "campania": campania,
      "codCampania": codCampania,
      "modalidad": modalidad,
    };
  }

  factory ConfigInicio.fromJson(Map<String, dynamic> parsedJson) =>
      ConfigInicio(
          idConfigInicio: parsedJson['idConfigInicio'],
          idLugarPrestacion: parsedJson['idLugarPrestacion'],
          lugarPrestacion: parsedJson['lugarPrestacion'],
          idUnidadesOrganicas: parsedJson['idUnidadesOrganicas'],
          unidadesOrganicas: parsedJson['unidadesOrganicas'],
          idPuesto: parsedJson['idPuesto'],
          puesto: parsedJson['puesto'],
          idUnidTerritoriales: parsedJson['idUnidTerritoriales'],
          unidTerritoriales: parsedJson['unidTerritoriales'],
          idTambo: parsedJson['idTambo'],
          nombreTambo: parsedJson['nombreTambo'],
          snip: parsedJson['snip'],
          tipoPlataforma: parsedJson['tipoPlataforma'],
          campania: parsedJson['campania'],
          codCampania: parsedJson['codCampania'],
          modalidad: parsedJson['modalidad']);

  ConfigInicio.fromMap(Map<String, dynamic> map) {
    idConfigInicio = map['idConfigInicio'];
    idLugarPrestacion = map['idLugarPrestacion'];
    lugarPrestacion = map['lugarPrestacion'];
    idUnidadesOrganicas = map['idUnidadesOrganicas'];
    unidadesOrganicas = map['unidadesOrganicas'];
    idPuesto = map['idPuesto'];
    puesto = map['puesto'];
    idUnidTerritoriales = map['idUnidTerritoriales'];
    unidTerritoriales = map['unidTerritoriales'];
    idTambo = map['idTambo'];
    nombreTambo = map['nombreTambo'];
    snip = map['snip'];
    tipoPlataforma = map['tipoPlataforma'];
    campania = map['campania'];
    codCampania = map['codCampania'];
    modalidad = map['modalidad'];
  }
}
