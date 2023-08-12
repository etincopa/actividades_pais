class ActividadesDiariasResumenField {
  static String idUt = "idUt";
  static String region = "region";
  static String conActividades = "conActividades";
  static String sinActividades = "sinActividad";
  static String fecha = "fechaActividad";
}

class ActividadesDiariasResumenModel {
  String? idUt;
  String? region;
  String? conActividades;
  String? sinActividades;
  String? fecha;

  ActividadesDiariasResumenModel.empty();

  ActividadesDiariasResumenModel({
    this.idUt,
    this.region,
    this.conActividades,
    this.sinActividades,
    this.fecha,
  });

  factory ActividadesDiariasResumenModel.fromJson(Map<String, dynamic> json) {
    return ActividadesDiariasResumenModel(
      idUt: json[ActividadesDiariasResumenField.idUt],
      region: json[ActividadesDiariasResumenField.region],
      conActividades: json[ActividadesDiariasResumenField.conActividades],
      sinActividades: json[ActividadesDiariasResumenField.sinActividades],
      fecha: json[ActividadesDiariasResumenField.fecha],
    );
  }
}
