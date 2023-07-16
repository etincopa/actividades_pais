class ResumenParqueInformaticoFld {
  static String descripcion = "descripcion";
  static String estado = "estado";
  static String cantidad = "cantidad";
}

class ResumenParqueInformatico {
  String? descripcion;
  String? estado;
  int? cantidad;

  ResumenParqueInformatico.empty();

  ResumenParqueInformatico({
    this.descripcion,
    this.estado,
    this.cantidad,
  });

  factory ResumenParqueInformatico.fromJson(Map<String, dynamic> json) {
    return ResumenParqueInformatico(
      descripcion: json[ResumenParqueInformaticoFld.descripcion],
      estado: json[ResumenParqueInformaticoFld.estado],
      cantidad: json[ResumenParqueInformaticoFld.cantidad],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
