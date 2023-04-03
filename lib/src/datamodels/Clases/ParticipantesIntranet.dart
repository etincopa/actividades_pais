class PariticipantesIntranet {
  List<Data>? data;
  String? total;

  PariticipantesIntranet({this.data, this.total});

  PariticipantesIntranet.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Data {
  String? correlativo;
  String? idProgramacionParticipante;
  String? idProgramacion;
  String? idParticipante;
  String? nombreResidencia;
  String? nombre;
  String? nombre2;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? dni;
  String? edad;
  String? fechaNacimiento;
  String? sexo;
  Null? paisNombre;
  Null? tipoDocumentoSiglas;
  String? nombrePrograma;
  String? estadoPadron;
  String? servicio;
  String? total;

  Data(
      {this.correlativo,
        this.idProgramacionParticipante,
        this.idProgramacion,
        this.idParticipante,
        this.nombreResidencia,
        this.nombre,
        this.nombre2,
        this.apellidoPaterno,
        this.apellidoMaterno,
        this.dni,
        this.edad,
        this.fechaNacimiento,
        this.sexo,
        this.paisNombre,
        this.tipoDocumentoSiglas,
        this.nombrePrograma,
        this.estadoPadron,
        this.servicio,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    correlativo = json['correlativo'];
    idProgramacionParticipante = json['id_programacion_participante'];
    idProgramacion = json['id_programacion'];
    idParticipante = json['id_participante'];
    nombreResidencia = json['nombre_residencia'];
    nombre = json['nombre'];
    nombre2 = json['nombre2'];
    apellidoPaterno = json['apellidoPaterno'];
    apellidoMaterno = json['apellidoMaterno'];
    dni = json['dni'];
    edad = json['edad'];
    fechaNacimiento = json['fecha_nacimiento'];
    sexo = json['sexo'];
    paisNombre = json['pais_nombre'];
    tipoDocumentoSiglas = json['tipo_documento_siglas'];
    nombrePrograma = json['nombre_programa'];
    estadoPadron = json['estado_padron'];
    servicio = json['servicio'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correlativo'] = this.correlativo;
    data['id_programacion_participante'] = this.idProgramacionParticipante;
    data['id_programacion'] = this.idProgramacion;
    data['id_participante'] = this.idParticipante;
    data['nombre_residencia'] = this.nombreResidencia;
    data['nombre'] = this.nombre;
    data['nombre2'] = this.nombre2;
    data['apellidoPaterno'] = this.apellidoPaterno;
    data['apellidoMaterno'] = this.apellidoMaterno;
    data['dni'] = this.dni;
    data['edad'] = this.edad;
    data['fecha_nacimiento'] = this.fechaNacimiento;
    data['sexo'] = this.sexo;
    data['pais_nombre'] = this.paisNombre;
    data['tipo_documento_siglas'] = this.tipoDocumentoSiglas;
    data['nombre_programa'] = this.nombrePrograma;
    data['estado_padron'] = this.estadoPadron;
    data['servicio'] = this.servicio;
    data['total'] = this.total;
    return data;
  }
}