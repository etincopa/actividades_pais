class ServiciosBasicosFld {
  static String idTipoConexion = 'idTipoConexion';
  static String nomTipoConexion = 'nomTipoConexion';
  static String cantidad = 'cantidad';
  static String idUterritorial = 'idUterritorial';
  static String region = 'region';
  static String provincia = 'provincia';
  static String distrito = 'distrito';
  static String idTambo = 'idTambo';
  static String nomTambo = 'nomTambo';
  static String snip = 'snip';
  static String idServicio = 'idServicio';
  static String nomServicio = 'nomServicio';
  static String idProveedorServicio = 'idProveedorServicio';
  static String proveedorServicio = 'proveedorServicio';
}

class ServiciosBasicosResumenModel {
  int? idTipoConexion = 0;
  String? nomTipoConexion = '';
  int? cantidad = 0;
  int? idUterritorial = 0;
  String? region = '';
  String? provincia = '';
  String? distrito = '';
  int? idTambo = 0;
  String? nomTambo = '';
  String? snip = '';
  int? idServicio = 0;
  String? nomServicio = '';
  int? idProveedorServicio = 0;
  String? proveedorServicio = '';

  ServiciosBasicosResumenModel.empty();

  ServiciosBasicosResumenModel({
    this.idTipoConexion,
    this.nomTipoConexion,
    this.cantidad,
    this.idUterritorial,
    this.region,
    this.provincia,
    this.distrito,
    this.idTambo,
    this.nomTambo,
    this.snip,
    this.idServicio,
    this.nomServicio,
    this.idProveedorServicio,
    this.proveedorServicio,
  });

  factory ServiciosBasicosResumenModel.fromJson(Map<String, dynamic> json) {
    return ServiciosBasicosResumenModel(
        idTipoConexion: json[ServiciosBasicosFld.idTipoConexion],
        nomTipoConexion: json[ServiciosBasicosFld.nomTipoConexion],
        cantidad: json[ServiciosBasicosFld.cantidad],
        idUterritorial: json[ServiciosBasicosFld.idUterritorial],
        region: json[ServiciosBasicosFld.region],
        provincia: json[ServiciosBasicosFld.provincia],
        distrito: json[ServiciosBasicosFld.distrito],
        idTambo: json[ServiciosBasicosFld.idTambo],
        nomTambo: json[ServiciosBasicosFld.nomTambo],
        snip: json[ServiciosBasicosFld.snip],
        idServicio: json[ServiciosBasicosFld.idServicio],
        nomServicio: json[ServiciosBasicosFld.nomServicio],
        idProveedorServicio: json[ServiciosBasicosFld.idProveedorServicio],
        proveedorServicio: json[ServiciosBasicosFld.proveedorServicio]);
  }
}
