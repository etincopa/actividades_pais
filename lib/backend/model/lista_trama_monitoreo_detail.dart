class MonitoreoDetailaFld {
  static String numSnip = 'numSnip';
  static String idTambo = 'idTambo';
  static String tambo = 'tambo';
  static String idPlataforma = 'idPlataforma';
  static String idMonitoreo = 'idMonitoreo';
  static String idUsuario = 'idUsuario';
  static String usuario = 'usuario';
  static String fechaMonitoreo = 'fechaMonitoreo';
  static String idEstadoMonitoreo = 'idEstadoMonitoreo';
  static String estadoMonitoreo = 'estadoMonitoreo';
  static String idEstadoAvance = 'idEstadoAvance';
  static String nombreAvance = 'nombreAvance';
  static String avanceFisicoAcumulado = 'avanceFisicoAcumulado';
  static String idRol = 'idRol';
  static String rol = 'rol';
  static String cui = 'cui';
  static String observaciones = 'observaciones';
  static String fechaTerminoEstimado = 'fechaTerminoEstimado';
  static String latitud = 'latitud';
  static String longitud = 'longitud';
  static String idProblemaIdentificado = 'idProblemaIdentificado';
  static String problemaIdentificado = 'problemaIdentificado';
  static String idAlternativaSolucion = 'idAlternativaSolucion';
  static String alternativaSolucion = 'alternativaSolucion';
  static String idRiesgoIdentificado = 'idRiesgoIdentificado';
  static String riesgoIdentificado = 'riesgoIdentificado';
  static String idActividad = 'idActividad';
  static String idAvanceFisicoPartida = 'idAvanceFisicoPartida';
  static String avanceFisicoPartida = 'avanceFisicoPartida';
  static String imgProblema1 = 'imgProblema1';
  static String imgProblema2 = 'imgProblema2';
  static String imgProblema3 = 'imgProblema3';
  static String imgRiesgo1 = 'imgRiesgo1';
  static String imgRiesgo2 = 'imgRiesgo2';
  static String imgRiesgo3 = 'imgRiesgo3';
  static String imgActividad1 = 'imgActividad1';
  static String imgActividad2 = 'imgActividad2';
  static String imgActividad3 = 'imgActividad3';
  static String txtIpReg = 'txtIpReg';
}

class MonitoreoDetailModel {
  String? numSnip;
  int? idTambo;
  String? tambo;
  int? idPlataforma;
  String? idMonitoreo;
  int? idUsuario;
  String? usuario;
  String? fechaMonitoreo;
  int? idEstadoMonitoreo;
  String? estadoMonitoreo;
  int? idEstadoAvance;
  String? nombreAvance;
  double? avanceFisicoAcumulado;
  int? idRol;
  String? rol;
  String? cui;
  String? observaciones;
  String? fechaTerminoEstimado;
  String? latitud;
  String? longitud;
  int? idProblemaIdentificado;
  String? problemaIdentificado;
  int? idAlternativaSolucion;
  String? alternativaSolucion;
  int? idRiesgoIdentificado;
  String? riesgoIdentificado;
  int? idActividad;
  int? idAvanceFisicoPartida;
  double? avanceFisicoPartida;
  String? imgProblema1;
  String? imgProblema2;
  String? imgProblema3;
  String? imgRiesgo1;
  String? imgRiesgo2;
  String? imgRiesgo3;
  String? imgActividad1;
  String? imgActividad2;
  String? imgActividad3;
  String? txtIpReg;

  MonitoreoDetailModel.empty();

  MonitoreoDetailModel({
    this.numSnip,
    this.idTambo,
    this.tambo,
    this.idPlataforma,
    this.idMonitoreo,
    this.idUsuario,
    this.usuario,
    this.fechaMonitoreo,
    this.idEstadoMonitoreo,
    this.estadoMonitoreo,
    this.idEstadoAvance,
    this.nombreAvance,
    this.avanceFisicoAcumulado,
    this.idRol,
    this.rol,
    this.cui,
    this.observaciones,
    this.fechaTerminoEstimado,
    this.latitud,
    this.longitud,
    this.idProblemaIdentificado,
    this.problemaIdentificado,
    this.idAlternativaSolucion,
    this.alternativaSolucion,
    this.idRiesgoIdentificado,
    this.riesgoIdentificado,
    this.idActividad,
    this.idAvanceFisicoPartida,
    this.avanceFisicoPartida,
    this.imgProblema1,
    this.imgProblema2,
    this.imgProblema3,
    this.imgRiesgo1,
    this.imgRiesgo2,
    this.imgRiesgo3,
    this.imgActividad1,
    this.imgActividad2,
    this.imgActividad3,
    this.txtIpReg,
  });

  factory MonitoreoDetailModel.fromJson(Map<String, dynamic> json) {
    return MonitoreoDetailModel(
      numSnip: json[MonitoreoDetailaFld.numSnip],
      idTambo: json[MonitoreoDetailaFld.idTambo],
      tambo: json[MonitoreoDetailaFld.tambo],
      idPlataforma: json[MonitoreoDetailaFld.idPlataforma],
      idMonitoreo: json[MonitoreoDetailaFld.idMonitoreo],
      idUsuario: json[MonitoreoDetailaFld.idUsuario],
      usuario: json[MonitoreoDetailaFld.usuario],
      fechaMonitoreo: json[MonitoreoDetailaFld.fechaMonitoreo],
      idEstadoMonitoreo: json[MonitoreoDetailaFld.idEstadoMonitoreo],
      estadoMonitoreo: json[MonitoreoDetailaFld.estadoMonitoreo],
      idEstadoAvance: json[MonitoreoDetailaFld.idEstadoAvance],
      nombreAvance: json[MonitoreoDetailaFld.nombreAvance],
      avanceFisicoAcumulado: json[MonitoreoDetailaFld.avanceFisicoAcumulado],
      idRol: json[MonitoreoDetailaFld.idRol],
      rol: json[MonitoreoDetailaFld.rol],
      cui: json[MonitoreoDetailaFld.cui],
      observaciones: json[MonitoreoDetailaFld.observaciones],
      fechaTerminoEstimado: json[MonitoreoDetailaFld.fechaTerminoEstimado],
      latitud: json[MonitoreoDetailaFld.latitud],
      longitud: json[MonitoreoDetailaFld.longitud],
      idProblemaIdentificado: json[MonitoreoDetailaFld.idProblemaIdentificado],
      problemaIdentificado: json[MonitoreoDetailaFld.problemaIdentificado],
      idAlternativaSolucion: json[MonitoreoDetailaFld.idAlternativaSolucion],
      alternativaSolucion: json[MonitoreoDetailaFld.alternativaSolucion],
      idRiesgoIdentificado: json[MonitoreoDetailaFld.idRiesgoIdentificado],
      riesgoIdentificado: json[MonitoreoDetailaFld.riesgoIdentificado],
      idActividad: json[MonitoreoDetailaFld.idActividad],
      idAvanceFisicoPartida: json[MonitoreoDetailaFld.idAvanceFisicoPartida],
      avanceFisicoPartida: json[MonitoreoDetailaFld.avanceFisicoPartida],
      imgProblema1: json[MonitoreoDetailaFld.imgProblema1],
      imgProblema2: json[MonitoreoDetailaFld.imgProblema2],
      imgProblema3: json[MonitoreoDetailaFld.imgProblema3],
      imgRiesgo1: json[MonitoreoDetailaFld.imgRiesgo1],
      imgRiesgo2: json[MonitoreoDetailaFld.imgRiesgo2],
      imgRiesgo3: json[MonitoreoDetailaFld.imgRiesgo3],
      imgActividad1: json[MonitoreoDetailaFld.imgActividad1],
      imgActividad2: json[MonitoreoDetailaFld.imgActividad2],
      imgActividad3: json[MonitoreoDetailaFld.imgActividad3],
      txtIpReg: json[MonitoreoDetailaFld.txtIpReg],
    );
  }
}
