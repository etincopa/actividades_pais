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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_programacion'] = this.idProgramacion;
    data['fecha'] = this.fecha;
    data['hora_inicio'] = this.horaInicio;
    data['hora_fin'] = this.horaFin;
    data['plataforma_descripcion'] = this.plataformaDescripcion;
    data['nombre_tipo_intervencion'] = this.nombreTipoIntervencion;
    data['descripcion_intervencion'] = this.descripcionIntervencion;
    data['nombre'] = this.nombre;
    data['nombre_sector'] = this.nombreSector;
    data['nombre_programa'] = this.nombrePrograma;
    data['nombre_categoria'] = this.nombreCategoria;
    data['nombre_subcategoria'] = this.nombreSubcategoria;
    data['nombre_tipo_actividad'] = this.nombreTipoActividad;
    data['nombre_lugar_intervencion'] = this.nombreLugarIntervencion;
    data['nombre_documento_acredita'] = this.nombreDocumentoAcredita;
    data['id_evaluacion'] = this.idEvaluacion;
    data['tipo_plan'] = this.tipoPlan;
    data['codigo_plan'] = this.codigoPlan;
    data['nombre_tipo_servicio'] = this.nombreTipoServicio;
    return data;
  }
}