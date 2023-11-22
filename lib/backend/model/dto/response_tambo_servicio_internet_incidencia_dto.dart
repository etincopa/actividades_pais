class TamboSrvInterIncFld {
  static String idTambo = "idTambo";
  static String idSeguimiento = "idSeguimiento";
  static String idIncidencia = "idIncidencia";
  static String fecSeguimiento = "fecSeguimiento";
  static String estado = "estado";
  static String nomEmpleado = "nomEmpleado";
  static String observacion = "observacion";
  static String claveWifi = "claveWifi";
  static String ticketPais = "ticketPais";
  static String snipInternet = "snipInternet";
  static String snipTelefono = "snipTelefono";
}

class TamboServicioInternetIncidenciaDto {
  int? idTambo = 0;
  int? idSeguimiento = 0;
  int? idIncidencia = 0;
  String? fecSeguimiento = "";
  String? estado = "";
  String? nomEmpleado = "";
  String? observacion = "";
  String? claveWifi = "";
  String? ticketPais = "";
  String? snipInternet = "";
  String? snipTelefono = "";

  TamboServicioInternetIncidenciaDto.empty();

  TamboServicioInternetIncidenciaDto({
    this.idTambo,
    this.idSeguimiento,
    this.idIncidencia,
    this.fecSeguimiento,
    this.estado,
    this.nomEmpleado,
    this.observacion,
    this.claveWifi,
    this.ticketPais,
    this.snipInternet,
    this.snipTelefono,
  });

  factory TamboServicioInternetIncidenciaDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return TamboServicioInternetIncidenciaDto(
      idTambo: json[TamboSrvInterIncFld.idTambo],
      idSeguimiento: json[TamboSrvInterIncFld.idSeguimiento],
      idIncidencia: json[TamboSrvInterIncFld.idIncidencia],
      fecSeguimiento: json[TamboSrvInterIncFld.fecSeguimiento],
      estado: json[TamboSrvInterIncFld.estado],
      nomEmpleado: json[TamboSrvInterIncFld.nomEmpleado],
      observacion: json[TamboSrvInterIncFld.observacion],
      claveWifi: json[TamboSrvInterIncFld.claveWifi],
      ticketPais: json[TamboSrvInterIncFld.ticketPais],
      snipInternet: json[TamboSrvInterIncFld.snipInternet],
      snipTelefono: json[TamboSrvInterIncFld.snipTelefono],
    );
  }
}
