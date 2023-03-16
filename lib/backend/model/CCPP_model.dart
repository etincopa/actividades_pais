class CCPPFld {
  static String ubigeo = 'ubigeo_ccpp';
  static String nombre = 'nombre_ccpp';
  static String snip = 'snip';
  static String poblacion = 'poblacion_ccpp';
  static String viviendas = 'viviendas_ccpp';
  static String latitud = 'latitud';
  static String longitud = 'longitud';
  static String altitud = 'altitud_ccpp';
  static String region = 'region_natural';
  static String rango = 'rango_region_natural';
}

class CCPPModel {
  String? ubigeo;
  String? nombre;
  double? snip;
  double? poblacion;
  double? viviendas;
  double? latitud;
  double? longitud;
  double? altitud;
  String? region;
  String? rango;

  CCPPModel.empty() {}

  CCPPModel(
      {this.ubigeo,
      this.nombre,
      this.snip,
      this.poblacion,
      this.viviendas,
      this.latitud,
      this.longitud,
      this.altitud,
      this.region,
      this.rango});

  factory CCPPModel.fromJson(Map<String, dynamic> json) {
    return CCPPModel(
      ubigeo: json[CCPPFld.ubigeo],
      nombre: json[CCPPFld.nombre],
      snip: json[CCPPFld.snip],
      poblacion: json[CCPPFld.poblacion],
      viviendas: json[CCPPFld.viviendas],
      latitud: json[CCPPFld.latitud],
      longitud: json[CCPPFld.longitud],
      altitud: json[CCPPFld.altitud],
      region: json[CCPPFld.region],
      rango: json[CCPPFld.rango],
    );
  }
}
