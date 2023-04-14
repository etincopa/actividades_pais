class CantidadTamboRegionFld {
  static String departamentoID = "departamentoID";
  static String poblacion = "poblacion";
  static String cantidad = "cantidad";
  static String nombre = "nombre";
  static String cp = "cp";
  static String distritos = "distritos";
}

class CantidadTamboRegion {
  String? departamentoID;
  String? poblacion;
  String? cantidad;
  String? nombre;
  String? cp;
  String? distritos;

  CantidadTamboRegion.empty() {}

  CantidadTamboRegion(
      {this.departamentoID,
      this.poblacion,
      this.cantidad,
      this.nombre,
      this.cp,
      this.distritos});

  factory CantidadTamboRegion.fromJson(Map<String, dynamic> json) {
    return CantidadTamboRegion(
      departamentoID: json[CantidadTamboRegionFld.departamentoID],
      poblacion: json[CantidadTamboRegionFld.poblacion],
      cantidad: json[CantidadTamboRegionFld.cantidad],
      nombre: json[CantidadTamboRegionFld.nombre],
      cp: json[CantidadTamboRegionFld.cp],
      distritos: json[CantidadTamboRegionFld.distritos],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
