class IncidenciasField {
  static String snip = "snip_tambo";
  static String idIncidencia = "id_incidencia";
  static String fechaAveria = "fec_averia";
  static String ticket = "ticket";
  static String estado = "estado";
  static String diasPasados = "dias_pasados";
  static String observacion = "observacion";
  static String tipoAveria = "tipo_averia";
}

class IncidentesInternetModel {
  int? snip;
  int? idIncidencia;
  String? fechaAveria;
  String? ticket;
  String? estado;
  int? diasPasados;
  String? observacion;
  String? tipoAveria;

  IncidentesInternetModel.empty() {}

  IncidentesInternetModel(
      {this.snip,
      this.idIncidencia,
      this.fechaAveria,
      this.ticket,
      this.estado,
      this.diasPasados,
      this.observacion,
      this.tipoAveria});

  factory IncidentesInternetModel.fromJson(Map<String, dynamic> json) {
    return IncidentesInternetModel(
        snip: json[IncidenciasField.snip],
        idIncidencia: json[IncidenciasField.idIncidencia],
        fechaAveria: json[IncidenciasField.fechaAveria],
        ticket: json[IncidenciasField.ticket],
        estado: json[IncidenciasField.estado],
        diasPasados: json[IncidenciasField.diasPasados],
        observacion: json[IncidenciasField.observacion],
        tipoAveria: json[IncidenciasField.tipoAveria]);
  }
}
