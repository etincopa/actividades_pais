class UbicacionUsuario {
  //"CREATE TABLE ubicacionUsuario (
  //id INTEGER PRIMARY KEY,
  //actividad, tipo, dni, snip, idLugarDeprestacion, idUnidTerritoriales, idUnidadesOrganicas, latitud, longitud, fechaHora)");
  int id;
  String actividad;
  String dni;
  int snip;
  int idLugarDeprestacion;
  String latitud;
  String longitud;
  String fechaHora;
  int idPlataforma;
  int tipo;
  int idUnidTerritoriales;
  int idUnidadesOrganicas;

  int idselecttipotrab;
  String selecttipotrab;
  int millisec;
  UbicacionUsuario(
      {this.id = 0,
      this.actividad = '',
      this.dni = '',
      this.snip = 0,
      this.latitud = '',
      this.longitud = '',
      this.fechaHora = '',
      this.tipo = 0,
      this.idPlataforma = 0,
      this.idLugarDeprestacion = 0,
      this.idUnidTerritoriales = 0,
      this.idUnidadesOrganicas = 0,
      this.idselecttipotrab = 0,
      this.selecttipotrab = '',
      this.millisec = 0});

  Map<String, dynamic> toMap() {
    return {
      "actividad": actividad,
      "dni": dni,
      "snip": snip,
      "latitud": latitud,
      "longitud": longitud,
      "fechaHora": fechaHora,
      "tipo": tipo,
      "idLugarDeprestacion": idLugarDeprestacion,
      "idPlataforma": idPlataforma,
      "idUnidTerritoriales": idUnidTerritoriales,
      "idUnidadesOrganicas": idUnidadesOrganicas,
      "idselecttipotrab": idselecttipotrab,
      "selecttipotrab": selecttipotrab,
      "millisec": millisec
    };
  }

  factory UbicacionUsuario.fromMap(Map<String, dynamic> map) =>
      UbicacionUsuario(
          actividad: map['actividad'],
          snip: map['snip'],
          dni: map['dni'],
          latitud: map['latitud'],
          longitud: map['longitud'],
          fechaHora: map['fechaHora'],
          tipo: map['tipo'],
          idLugarDeprestacion: map['idLugarDeprestacion'],
          idPlataforma: map['idPlataforma'],
          idUnidTerritoriales: map['idUnidTerritoriales'],
          idUnidadesOrganicas: map['idUnidadesOrganicas'],
          idselecttipotrab: map['idselecttipotrab'],
          selecttipotrab: map['selecttipotrab'],
          millisec: map['millisec']);
}
