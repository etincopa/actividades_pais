class PersonalTamboFld {
  static String nombres = "nombres";
}

class PersonalTambo {
  String? nombres;

  PersonalTambo.empty() {}

  PersonalTambo({
    this.nombres,
  });

  factory PersonalTambo.fromJson(Map<String, dynamic> json) {
    return PersonalTambo(
      nombres: json[PersonalTamboFld.nombres],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
