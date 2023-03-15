class PlanMantenimientoFld {
  static String idRegion = 'idRegion';
  static String region = 'region';
  static String mes = 'mes';
  static String anio = 'anio';
  static String personalAsignado = 'personalAsignado';
  static String equipos = 'equipos';

  static String numeroDocumentoTecnico = 'numeroDocumento';
  static String apellidoPaternoTecnico = 'apellidoPaterno';
  static String apellidoMaternoTecnico = 'apellidoMaterno';
  static String nombresTecnico = 'nombres';
  static String correoTecnico = 'correo';
  static String celularTecnico = 'celular';
  static String nombreFoto = 'nombreFoto';
  static String rutaFoto = 'rutaFoto';
}

class PlanMantenimientoModel {
  String? idRegion;
  String? region;
  String? mes;
  String? anio;
  String? personalAsignado;
  String? equipos;
  String? numeroDocumentoTecnico;
  String? apellidoPaternoTecnico;
  String? apellidoMaternoTecnico;
  String? nombresTecnico;
  String? correoTecnico;
  String? celularTecnico;
  String? nombreFoto;
  String? rutaFoto;

  PlanMantenimientoModel.empty() {}

  PlanMantenimientoModel(
      {this.idRegion,
      this.region,
      this.mes,
      this.anio,
      this.personalAsignado,
      this.equipos,
      this.numeroDocumentoTecnico,
      this.apellidoPaternoTecnico,
      this.apellidoMaternoTecnico,
      this.nombresTecnico,
      this.correoTecnico,
      this.celularTecnico,
      this.nombreFoto,
      this.rutaFoto});

  factory PlanMantenimientoModel.fromJson(Map<String, dynamic> json) {
    return PlanMantenimientoModel(
      idRegion: json[PlanMantenimientoFld.idRegion],
      region: json[PlanMantenimientoFld.region],
      mes: json[PlanMantenimientoFld.mes],
      anio: json[PlanMantenimientoFld.anio],
      personalAsignado: json[PlanMantenimientoFld.personalAsignado],
      equipos: json[PlanMantenimientoFld.equipos],
      numeroDocumentoTecnico: json[PlanMantenimientoFld.numeroDocumentoTecnico],
      apellidoPaternoTecnico: json[PlanMantenimientoFld.apellidoPaternoTecnico],
      apellidoMaternoTecnico: json[PlanMantenimientoFld.apellidoMaternoTecnico],
      nombresTecnico: json[PlanMantenimientoFld.nombresTecnico],
      correoTecnico: json[PlanMantenimientoFld.correoTecnico],
      celularTecnico: json[PlanMantenimientoFld.celularTecnico],
      nombreFoto: json[PlanMantenimientoFld.nombreFoto],
      rutaFoto: json[PlanMantenimientoFld.rutaFoto],
    );
  }
}
