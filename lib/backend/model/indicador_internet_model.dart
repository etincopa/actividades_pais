class IndicadorInternetField {
  static String idTambo = "idTambo";
  static String nomTambo = "nomTambo";
  static String snip = "snip";
  static String idOperadorInternet = "idOperadorInternet";
  static String nomOperadorInternet = "nomOperadorInternet";
  static String numAsignados = "numAsignados";
}

class IndicadorInternetModel {
  int? idTambo;
  String? nomTambo;
  String? snip;
  int? idOperadorInternet;
  String? nomOperadorInternet;
  int? numAsignados;

  IndicadorInternetModel.empty() {}

  IndicadorInternetModel({
    this.idTambo,
    this.nomTambo,
    this.snip,
    this.idOperadorInternet,
    this.nomOperadorInternet,
    this.numAsignados,
  });

  factory IndicadorInternetModel.fromJson(Map<String, dynamic> json) {
    return IndicadorInternetModel(
      idTambo: json[IndicadorInternetField.idTambo],
      nomTambo: json[IndicadorInternetField.nomTambo],
      snip: json[IndicadorInternetField.snip],
      idOperadorInternet: json[IndicadorInternetField.idOperadorInternet],
      nomOperadorInternet: json[IndicadorInternetField.nomOperadorInternet],
      numAsignados: json[IndicadorInternetField.numAsignados],
    );
  }
}
