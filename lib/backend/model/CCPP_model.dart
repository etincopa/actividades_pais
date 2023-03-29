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
  static String distancia_m = 'distancia_metros';
  static String distancia_km = 'distancia_km';
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
  String? distancia_m;
  String? distancia_km;

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
      this.rango,
      this.distancia_m,
      this.distancia_km});

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
      distancia_m: json[CCPPFld.distancia_m],
      distancia_km: json[CCPPFld.distancia_km],
    );
  }
}
