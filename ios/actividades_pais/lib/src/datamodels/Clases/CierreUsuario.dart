class CierreUsuario {
  int id;
  String descripcion;
  dynamic imagen;
  String dni;
  int snip;
  String latitud;
  String longitud;
  String fechaHora;
  int idLugarDeprestacion;
  int idUnidTerritoriales;
  int idUnidadesOrganicas;
  int idPlataforma;

  CierreUsuario({
    this.id = 0,
    this.descripcion = '',
    this.imagen,
    this.dni = '',
    this.snip = 0,
    this.latitud = '',
    this.longitud = '',
    this.fechaHora = '',
    this.idLugarDeprestacion = 0,
    this.idUnidTerritoriales = 0,
    this.idUnidadesOrganicas = 0,
    this.idPlataforma = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "descripcion": descripcion,
      "imagen": imagen,
      "dni": dni,
      "snip": snip,
      "latitud": latitud,
      "longitud": longitud,
      "fechaHora": fechaHora,
      "idLugarDeprestacion": idLugarDeprestacion,
      "idUnidTerritoriales": idUnidTerritoriales,
      "idUnidadesOrganicas": idUnidadesOrganicas,
      "idPlataforma": idPlataforma
    };
  }

  factory CierreUsuario.fromMap(Map<String, dynamic> map) => CierreUsuario(
      descripcion: map['actividad'],
      imagen: map['imagen'],
      snip: map['snip'],
      dni: map['dni'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      fechaHora: map['fechaHora'],
      idLugarDeprestacion: map['idLugarDeprestacion'],
      idUnidTerritoriales: map['idUnidTerritoriales'],
      idUnidadesOrganicas: map['idUnidadesOrganicas'],
      idPlataforma: map['idPlataforma']);
}
