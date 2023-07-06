class ActividadesDiariasField {
  static String idUt = "idUt";
  static String region = "region";
  static String nomTambo = "nomTambo";
  static String idTambo = "idTambo";
  static String fechaActividad = "fechaActividad";
  static String gitLaborando = "gitLaborando";
  static String motivo = "motivo";

  static String actividad = "actividad";
  static String lugar = "lugar";
  static String tipoIntervencion = "tipoIntervencion";
}

class ActividadesDiariasModel {
  String? idUt;
  String? region;
  String? nomTambo;
  String? idTambo;
  String? fechaActividad;
  String? gitLaborando;
  String? motivo;

  String? actividad;
  String? lugar;
  String? tipoIntervencion;

  ActividadesDiariasModel.empty();

  ActividadesDiariasModel(
      {this.idUt,
      this.region,
      this.nomTambo,
      this.idTambo,
      this.fechaActividad,
      this.gitLaborando,
      this.motivo,
      this.actividad,
      this.lugar,
      this.tipoIntervencion});

  factory ActividadesDiariasModel.fromJson(Map<String, dynamic> json) {
    return ActividadesDiariasModel(
      idUt: json[ActividadesDiariasField.idUt],
      region: json[ActividadesDiariasField.region],
      nomTambo: json[ActividadesDiariasField.nomTambo],
      idTambo: json[ActividadesDiariasField.idTambo],
      fechaActividad: json[ActividadesDiariasField.fechaActividad],
      gitLaborando: json[ActividadesDiariasField.gitLaborando],
      motivo: json[ActividadesDiariasField.motivo],
      actividad: json[ActividadesDiariasField.actividad],
      lugar: json[ActividadesDiariasField.lugar],
      tipoIntervencion: json[ActividadesDiariasField.tipoIntervencion],
    );
  }
}
