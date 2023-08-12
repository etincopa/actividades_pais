class AtencionesRegionField {
  static String region = "region";
  static String tambo = "tambo";
  static String periodo = "periodo";
  static String mes = "mes";
  static String atenciones = "atenciones";
  static String usuarios = "usuarios";
  static String intervenciones = "intervenciones";
  static String idUt = "idUt";
}

class AtencionesRegionModel {
  String? region;
  String? tambo;
  String? periodo;
  String? mes;
  String? atenciones;
  String? intervenciones;
  String? usuarios;
  String? idUt;

  AtencionesRegionModel.empty();

  AtencionesRegionModel(
      {this.region,
      this.tambo,
      this.periodo,
      this.mes,
      this.atenciones,
      this.intervenciones,
      this.usuarios,
      this.idUt});

  factory AtencionesRegionModel.fromJson(Map<String, dynamic> json) {
    return AtencionesRegionModel(
        region: json[AtencionesRegionField.region],
        tambo: json[AtencionesRegionField.tambo],
        periodo: json[AtencionesRegionField.periodo],
        mes: json[AtencionesRegionField.mes],
        atenciones: json[AtencionesRegionField.atenciones],
        intervenciones: json[AtencionesRegionField.intervenciones],
        usuarios: json[AtencionesRegionField.usuarios],
        idUt: json[AtencionesRegionField.idUt]);
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
