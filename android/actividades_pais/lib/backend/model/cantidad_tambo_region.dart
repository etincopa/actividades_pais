class CantidadTamboRegionFld {
  static String departamentoID = "departamentoID";
  static String poblacion = "poblacion";
  static String cantidad = "cantidad";
  static String nombre = "nombre";
  static String cp = "cp";
  static String cp_total = "cpTotal";
  static String cp_porcentaje = "cpPorcentaje";
  static String distritos = "distritos";
  static String distritos_total = "distritosTotal";
  static String distritos_porcentaje = "distritosPorcentaje";
}

class CantidadTamboRegion {
  String? departamentoID;
  String? poblacion;
  String? cantidad;
  String? nombre;
  String? cp;
  String? cpTotal;
  String? cpPorcentaje;
  String? distritos;
  String? distritosTotal;
  String? distritosPorcentaje;

  CantidadTamboRegion.empty();

  CantidadTamboRegion(
      {this.departamentoID,
      this.poblacion,
      this.cantidad,
      this.nombre,
      this.cp,
      this.cpTotal,
      this.cpPorcentaje,
      this.distritos,
      this.distritosTotal,
      this.distritosPorcentaje});

  factory CantidadTamboRegion.fromJson(Map<String, dynamic> json) {
    return CantidadTamboRegion(
      departamentoID: json[CantidadTamboRegionFld.departamentoID],
      poblacion: json[CantidadTamboRegionFld.poblacion],
      cantidad: json[CantidadTamboRegionFld.cantidad],
      nombre: json[CantidadTamboRegionFld.nombre],
      cp: json[CantidadTamboRegionFld.cp],
      cpTotal: json[CantidadTamboRegionFld.cp_total],
      cpPorcentaje: json[CantidadTamboRegionFld.cp_porcentaje],
      distritos: json[CantidadTamboRegionFld.distritos],
      distritosTotal: json[CantidadTamboRegionFld.distritos_total],
      distritosPorcentaje: json[CantidadTamboRegionFld.distritos_porcentaje],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
