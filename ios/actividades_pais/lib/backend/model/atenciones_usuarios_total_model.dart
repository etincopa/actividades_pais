class AtencionesUsuariosFields {
  static String periodo = 'periodo';
  static String atenciones = 'atenciones';
  static String usuarios = 'usuarios';
}

class AtencionesUsuariosTotalModel {
  String? periodo;
  String? atenciones;
  String? usuuarios;

  AtencionesUsuariosTotalModel.empty();

  AtencionesUsuariosTotalModel({
    this.periodo,
    this.atenciones,
    this.usuuarios,
  });

  factory AtencionesUsuariosTotalModel.fromJson(Map<String, dynamic> json) {
    return AtencionesUsuariosTotalModel(
      periodo: json[AtencionesUsuariosFields.periodo],
      atenciones: json[AtencionesUsuariosFields.atenciones],
      usuuarios: json[AtencionesUsuariosFields.usuarios],
    );
  }
}
