class AvanceMetasField {
  static String anio = "anio";
  static String mes = "mes";
  static String atencionesEjecutadas = "atencionesEjecutadas";
  static String atencionesProgramadas = "atencionesProgramadas";
  static String usuariosAtendidos = "usuariosAtendidos";
  static String usuariosProgramados = "usuariosProgramados";
}

class AvanceMetasModel {
  String? anio;
  String? mes;
  String? atencionesEjecutadas;
  String? atencionesProgramadas;
  String? usuariosAtendidos;
  String? usuariosProgramados;

  AvanceMetasModel.empty() {}

  AvanceMetasModel(
      {this.anio,
      this.mes,
      this.atencionesEjecutadas,
      this.atencionesProgramadas,
      this.usuariosAtendidos,
      this.usuariosProgramados});

  factory AvanceMetasModel.fromJson(Map<String, dynamic> json) {
    return AvanceMetasModel(
      anio: json[AvanceMetasField.anio],
      mes: json[AvanceMetasField.mes],
      atencionesEjecutadas: json[AvanceMetasField.atencionesEjecutadas],
      atencionesProgramadas: json[AvanceMetasField.atencionesProgramadas],
      usuariosAtendidos: json[AvanceMetasField.usuariosAtendidos],
      usuariosProgramados: json[AvanceMetasField.usuariosProgramados],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
