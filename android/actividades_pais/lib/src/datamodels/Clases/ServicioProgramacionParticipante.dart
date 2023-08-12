class ServicioProgramacionParticipante {
  int id_programacion_participante_servicio;
  int idProgramacionesParticipante;
  int idServicio;
  int id_programacion;
  String tipo;
  int idUsuario;
  String txtIpmaq;

  ServicioProgramacionParticipante({
    this.id_programacion_participante_servicio = 0,
    this.idProgramacionesParticipante = 0,
    this.idServicio = 0,
    this.id_programacion = 0,
    this.idUsuario = 0,
    this.tipo = '',
    this.txtIpmaq = '',
  });

  factory ServicioProgramacionParticipante.fromJson(Map<String, dynamic> json) {
    return ServicioProgramacionParticipante(
        idProgramacionesParticipante: json['idProgramacionesParticipante'],
        id_programacion_participante_servicio: json['id_programacion'],
        idServicio: json['id_participante'],
        id_programacion: json['id_programacion'],
        tipo: json['tipo']);
  }

  factory ServicioProgramacionParticipante.fromMap(Map<String, dynamic> json) =>
      ServicioProgramacionParticipante(
        idProgramacionesParticipante: json['id_programacion_participante'],
        id_programacion: json['id_programacion'],
        id_programacion_participante_servicio:
            json['id_programacion_participante_servicio'],
        idServicio: json['id_servicio'],
        tipo: json['tipo'],
       // idUsuario: json['idUsuario'],
       // txtIpmaq: json['txtIpmaq'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['idProgramacionesParticipante'] = idProgramacionesParticipante;
    data['id_programacion'] = id_programacion;
    data['id_programacion_participante_servicio'] =
        id_programacion_participante_servicio;
    data['idServicio'] = idServicio;
    data['tipo'] = tipo;
    data['idUsuario'] = idUsuario;
    data['txtIpmaq'] = txtIpmaq;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "id_programacion_participante": idProgramacionesParticipante,
      "id_programacion": id_programacion,
      "id_programacion_participante_servicio":
          id_programacion_participante_servicio,
      "id_servicio": idServicio,
      "tipo": tipo,
    };
  }
}
