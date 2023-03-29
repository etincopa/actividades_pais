class PersonalTamboFld {
  static String nombres = "nombres";
  static String descripcion = "descripcion";
}

class PersonalTambo {
  String? nombres;
  String? descripcion;

  PersonalTambo.empty() {}

  PersonalTambo({
    this.nombres,
    this.descripcion,
  });

  factory PersonalTambo.fromJson(Map<String, dynamic> json) {
    return PersonalTambo(
      nombres: json[PersonalTamboFld.nombres],
      descripcion: json[PersonalTamboFld.descripcion],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
