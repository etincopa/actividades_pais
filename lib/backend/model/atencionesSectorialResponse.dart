class AtencionesSectorialesField {
  static String anio = "anio";
  static String mes = "mes";
  static String tipoUsuario = "tipoUsuario";
  static String sector = "sector";
  static String entidad = "entidad";
  static String atenciones = "atenciones";
  static String intervenciones = "intervenciones";
  static String beneficiarios = "beneficiarios";
}

class AtencionesSectorialesModel {
  String? anio;
  String? mes;
  String? tipoUsuario;
  String? sector;
  String? entidad;
  String? atenciones;
  String? intervenciones;
  String? beneficiarios;

  AtencionesSectorialesModel.empty() {}

  AtencionesSectorialesModel(
      {this.anio,
      this.mes,
      this.tipoUsuario,
      this.sector,
      this.entidad,
      this.atenciones,
      this.intervenciones,
      this.beneficiarios});

  factory AtencionesSectorialesModel.fromJson(Map<String, dynamic> json) {
    return AtencionesSectorialesModel(
        anio: json[AtencionesSectorialesField.anio],
        mes: json[AtencionesSectorialesField.mes],
        tipoUsuario: json[AtencionesSectorialesField.tipoUsuario],
        sector: json[AtencionesSectorialesField.sector],
        entidad: json[AtencionesSectorialesField.entidad],
        atenciones: json[AtencionesSectorialesField.atenciones],
        intervenciones: json[AtencionesSectorialesField.intervenciones],
        beneficiarios: json[AtencionesSectorialesField.beneficiarios]);
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
