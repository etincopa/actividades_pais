class IncidenciasField {
  static String idTambo = "idTambo";
  static String nomTambo = "nomTambo";
  static String snip = "snip";
  static String idIncidencia = "idIncidencia";
  static String fechaAveria = "fechaAveria";
  static String diasPasados = "diasPasados";
  static String idIncidenciaEstado = "idIncidenciaEstado";
  static String nomEstado = "nombreEstado";
  static String ticket = "ticket";
  static String estadoInternet = "estadoInternet";
  static String fechaCierre = "fechaCierre";

  static String tipoAveria = "tipoAveria";
  static String region = "region";
  static String provincia = "provincia";
  static String distrito = "distrito";
  static String idOPeradorInternet = "idOPeradorInternet";
}

class IncidentesInternetModel {
  String? idTambo;
  String? nomTambo;
  String? snip;
  String? idIncidencia;
  String? fechaAveria;
  String? diasPasados;
  String? idIncidenciaEstado;
  String? nomEstado;
  String? ticket;
  String? estadoInternet;
  String? fechaCierre;

  String? tipoAveria;
  String? region;
  String? provincia;
  String? distrito;
  int? idOPeradorInternet;

  IncidentesInternetModel.empty();

  IncidentesInternetModel(
      {this.idTambo,
      this.nomTambo,
      this.snip,
      this.idIncidencia,
      this.fechaAveria,
      this.diasPasados,
      this.idIncidenciaEstado,
      this.nomEstado,
      this.ticket,
      this.estadoInternet,
      this.fechaCierre,
      this.tipoAveria,
      this.region,
      this.provincia,
      this.distrito,
      this.idOPeradorInternet});

  factory IncidentesInternetModel.fromJson(Map<String, dynamic> json) {
    return IncidentesInternetModel(
        idTambo: json[IncidenciasField.idTambo],
        nomTambo: json[IncidenciasField.nomTambo],
        snip: json[IncidenciasField.snip],
        idIncidencia: json[IncidenciasField.idIncidencia],
        fechaAveria: json[IncidenciasField.fechaAveria],
        fechaCierre: json[IncidenciasField.fechaCierre],
        tipoAveria: json[IncidenciasField.tipoAveria],
        diasPasados: json[IncidenciasField.diasPasados],
        idIncidenciaEstado: json[IncidenciasField.idIncidenciaEstado],
        nomEstado: json[IncidenciasField.nomEstado],
        ticket: json[IncidenciasField.ticket],
        estadoInternet: json[IncidenciasField.estadoInternet],
        region: json[IncidenciasField.region],
        provincia: json[IncidenciasField.provincia],
        distrito: json[IncidenciasField.distrito],
        idOPeradorInternet: json[IncidenciasField.idOPeradorInternet]);
  }
}
