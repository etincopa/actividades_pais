class DetalleIntervencion {
  String? idProgramacion;
  String? fecha;
  String? horaInicio;
  String? horaFin;
  String? plataformaDescripcion;
  String? nombreTipoIntervencion;
  String? descripcionIntervencion;
  String? nombre;
  String? nombreSector;
  String? nombrePrograma;
  String? nombreCategoria;
  String? nombreSubcategoria;
  String? nombreTipoActividad;
  String? nombreLugarIntervencion;
  String? nombreDocumentoAcredita;
  String? idEvaluacion;
  String? tipoPlan;
  String? codigoPlan;
  String? nombreTipoServicio;

  DetalleIntervencion(
      {this.idProgramacion,
        this.fecha,
        this.horaInicio,
        this.horaFin,
        this.plataformaDescripcion,
        this.nombreTipoIntervencion,
        this.descripcionIntervencion,
        this.nombre,
        this.nombreSector,
        this.nombrePrograma,
        this.nombreCategoria,
        this.nombreSubcategoria,
        this.nombreTipoActividad,
        this.nombreLugarIntervencion,
        this.nombreDocumentoAcredita,
        this.idEvaluacion,
        this.tipoPlan,
        this.codigoPlan,
        this.nombreTipoServicio});

  DetalleIntervencion.fromJson(Map<String, dynamic> json) {
    idProgramacion = json['id_programacion'];
    fecha = json['fecha'];
    horaInicio = json['hora_inicio'];
    horaFin = json['hora_fin'];
    plataformaDescripcion = json['plataforma_descripcion'];
    nombreTipoIntervencion = json['nombre_tipo_intervencion'];
    descripcionIntervencion = json['descripcion_intervencion'];
    nombre = json['nombre'];
    nombreSector = json['nombre_sector'];
    nombrePrograma = json['nombre_programa'];
    nombreCategoria = json['nombre_categoria'];
    nombreSubcategoria = json['nombre_subcategoria'];
    nombreTipoActividad = json['nombre_tipo_actividad'];
    nombreLugarIntervencion = json['nombre_lugar_intervencion'];
    nombreDocumentoAcredita = json['nombre_documento_acredita'];
    idEvaluacion = json['id_evaluacion'];
    tipoPlan = json['tipo_plan'];
    codigoPlan = json['codigo_plan'];
    nombreTipoServicio = json['nombre_tipo_servicio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_programacion'] = idProgramacion;
    data['fecha'] = fecha;
    data['hora_inicio'] = horaInicio;
    data['hora_fin'] = horaFin;
    data['plataforma_descripcion'] = plataformaDescripcion;
    data['nombre_tipo_intervencion'] = nombreTipoIntervencion;
    data['descripcion_intervencion'] = descripcionIntervencion;
    data['nombre'] = nombre;
    data['nombre_sector'] = nombreSector;
    data['nombre_programa'] = nombrePrograma;
    data['nombre_categoria'] = nombreCategoria;
    data['nombre_subcategoria'] = nombreSubcategoria;
    data['nombre_tipo_actividad'] = nombreTipoActividad;
    data['nombre_lugar_intervencion'] = nombreLugarIntervencion;
    data['nombre_documento_acredita'] = nombreDocumentoAcredita;
    data['id_evaluacion'] = idEvaluacion;
    data['tipo_plan'] = tipoPlan;
    data['codigo_plan'] = codigoPlan;
    data['nombre_tipo_servicio'] = nombreTipoServicio;
    return data;
  }
}