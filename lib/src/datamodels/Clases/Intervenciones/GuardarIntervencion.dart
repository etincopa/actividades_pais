class GuardarIntervencion {
  String? fecha;
  String? descripcion;
  int? tipoIntervencion;
  String? horaInicio;
  String? horaFin;
  int? documento;
  int? realizo;
  int? convocadas;
  String? vConvenio;
  int? nConvenio;
  int? idUnidadesTerritoriales;
  String? idPlataforma;
  bool? progOtroTambo;

  List<Accion>? accion;

  GuardarIntervencion({
    this.fecha,
    this.descripcion,
    this.tipoIntervencion,
    this.horaInicio,
    this.horaFin,
    this.documento,
    this.realizo,
    this.convocadas,
    this.vConvenio,
    this.nConvenio,
    this.idUnidadesTerritoriales,
    this.idPlataforma,
    this.progOtroTambo,
    this.accion
  });

  GuardarIntervencion.fromJson(Map<String, dynamic> json) {
    fecha = json['fecha'];
    descripcion = json['descripcion'];
    tipoIntervencion = json['tipoIntervencion'];
    horaInicio = json['horaInicio'];
    horaFin = json['horaFin'];
    documento = json['documento'];
    realizo = json['realizo'];
    convocadas = json['convocadas'];
    vConvenio = json['v_convenio'];
    nConvenio = json['n_convenio'];
    idUnidadesTerritoriales = json['id_unidades_territoriales'];
    idPlataforma = json['id_plataforma'];
    progOtroTambo = json['prog_otro_tambo'];
    if (json['accion'] != null) {
      accion = <Accion>[];
      json['accion'].forEach((v) {
        accion!.add(new Accion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fecha'] = this.fecha;
    data['descripcion'] = this.descripcion;
    data['tipoIntervencion'] = this.tipoIntervencion;
    data['horaInicio'] = this.horaInicio;
    data['horaFin'] = this.horaFin;
    data['documento'] = this.documento;
    data['realizo'] = this.realizo;
    data['convocadas'] = this.convocadas;
    data['v_convenio'] = this.vConvenio;
    data['n_convenio'] = this.nConvenio;
    data['id_unidades_territoriales'] = this.idUnidadesTerritoriales;
    data['id_plataforma'] = this.idPlataforma;
    data['prog_otro_tambo'] = this.progOtroTambo;
    if (this.accion != null) {
      data['accion'] = this.accion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accion {
  String? id;
  String? usuario;
  String? sector;
  String? programa;
  String? categoria;
  String? subcategoria;
  String? actividad;
  String? servicio;
  String? idGobierno;
  String? idCategoria;
  String? idSector;
  String? idSubcategoria;
  String? idEntidad;
  String? idActividad;
  String? idServicio;
  String? descripcionEntidad;
  String? idTipoGobierno;
  String? idAccionProgramacion;
  String? idSubCategoria;
  String? idTipoActividad;


  Accion({this.id,
    this.usuario,
    this.sector,
    this.programa,
    this.categoria,
    this.subcategoria,
    this.actividad,
    this.servicio,
    this.idGobierno,
    this.idCategoria,
    this.idSector,
    this.idSubcategoria,
    this.idEntidad,
    this.idActividad,
    this.idServicio,
    this.descripcionEntidad,
    this.idTipoGobierno,
    this.idAccionProgramacion,
    this.idSubCategoria,
    this.idTipoActividad,});

  Accion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario = json['usuario'];
    sector = json['sector'];
    programa = json['programa'];
    categoria = json['categoria'];
    subcategoria = json['subcategoria'];
    actividad = json['actividad'];
    servicio = json['servicio'];
    idGobierno = json['id_gobierno'];
    idCategoria = json['id_categoria'];
    idSector = json['id_sector'];
    idSubcategoria = json['id_subcategoria'];
    idEntidad = json['id_entidad'];
    idActividad = json['id_actividad'];
    idServicio = json['id_servicio'].cast<String>();
    descripcionEntidad = json['descripcion_entidad'];
  }

  Accion.fromJsonCargarlista(Map<String, dynamic> json) {
    idAccionProgramacion = json['id_accion_programacion'];
    idTipoGobierno = json['id_tipo_gobierno'];
    idSector = json['id_sector'];
    idEntidad = json['id_entidad'];
    idCategoria = json['id_categoria'];
    idSubCategoria = json['id_sub_categoria'];
    idTipoActividad = json['id_tipo_actividad'];
    idServicio = json['id_servicio'];
    descripcionEntidad = json['descripcion_entidad'];
    usuario = json['usuario'];
    sector = json['sector'];
    programa = json['programa'];
    categoria = json['categoria'];
    subcategoria = json['subcategoria'];
    actividad = json['actividad'];
    servicio = json['servicio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['usuario'] = this.usuario;
    data['sector'] = this.sector;
    data['programa'] = this.programa;
    data['categoria'] = this.categoria;
    data['subcategoria'] = this.subcategoria;
    data['actividad'] = this.actividad;
    data['servicio'] = this.servicio;
    data['id_gobierno'] = this.idGobierno;
    data['id_categoria'] = this.idCategoria;
    data['id_sector'] = this.idSector;
    data['id_subcategoria'] = this.idSubcategoria;
    data['id_entidad'] = this.idEntidad;
    data['id_actividad'] = this.idActividad;
    data['id_servicio'] = this.idServicio;
    data['descripcion_entidad'] = this.descripcionEntidad;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario': usuario,
      'sector': sector,
      'programa': programa,
      'categoria': categoria,
      'subcategoria': subcategoria,
      'actividad': actividad,
      'servicio': servicio,
      'id_gobierno': idGobierno,
      'id_categoria': idCategoria,
      'id_sector': idSector,
      'id_subcategoria': idSubcategoria,
      'id_entidad': idEntidad,
      'id_actividad': idActividad,
      'id_servicio': idServicio
    };
  }

  factory Accion.fromMap(Map<String, dynamic> json) =>
      Accion(
        id: json['id'].toString() ?? '',
        usuario: json['usuario'],
        sector: json['sector'],
        programa: json['programa'],
        categoria: json['categoria'],
        subcategoria: json['subcategoria'],
        actividad: json['actividad'],
        servicio: json['servicio'],
        idGobierno: json['id_gobierno'],
        idCategoria: json['id_categoria'],
        idSector: json['id_sector'],
        idSubcategoria: json['id_subcategoria'],
        idEntidad: json['id_entidad'],
        idActividad: json['id_actividad'],
        idServicio: json['id_servicio'],
        descripcionEntidad: json['descripcion_entidad'],
      );
}
