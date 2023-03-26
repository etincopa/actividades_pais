class CantidadTamboRegionFld {
  static String departamentoID = "departamentoID";
  static String poblacion = "poblacion";
  static String cantidad = "cantidad";
  static String nombre = "nombre";
}

class CantidadTamboRegion {
  String? departamentoID;
  String? poblacion;
  String? cantidad;
  String? nombre;

  CantidadTamboRegion.empty() {}

  CantidadTamboRegion({
    this.departamentoID,
    this.poblacion,
    this.cantidad,
    this.nombre,
  });

  factory CantidadTamboRegion.fromJson(Map<String, dynamic> json) {
    return CantidadTamboRegion(
      departamentoID: json[CantidadTamboRegionFld.departamentoID],
      poblacion: json[CantidadTamboRegionFld.poblacion],
      cantidad: json[CantidadTamboRegionFld.cantidad],
      nombre: json[CantidadTamboRegionFld.nombre],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
