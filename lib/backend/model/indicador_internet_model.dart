class IndicadorInternetField {
  static String idTambo = "idTambo";
  static String nomTambo = "nomTambo";
  static String region = "region";
  static String provincia = "provincia";
  static String distrito = "distrito";
  static String snip = "snip";
  static String idOperadorInternet = "idOperadorInternet";
  static String nomOperadorInternet = "nomOperadorInternet";
  static String numAsignados = "numAsignados";

  static String numOperativos = "numOperativos";
  static String codOperativo = "codOperativo";
  static String numInoperativos = "numInoperativos";
  static String codInoperativo = "codInoperativo";
  static String numEnProceso = "numEnProceso";
  static String codEnProceso = "codEnProceso";
}

class IndicadorInternetModel {
  int? idTambo;
  String? nomTambo;
  String? snip;
  String? region;
  String? provincia;
  String? distrito;
  int? idOperadorInternet;
  String? nomOperadorInternet;
  int? numAsignados;
  int? operativos;
  String? codOperativo;
  int? inoperativos;
  String? codInoperativo;
  int? enproceso;
  String? codEnProceso;

  IndicadorInternetModel.empty();

  IndicadorInternetModel({
    this.idTambo,
    this.nomTambo,
    this.region,
    this.provincia,
    this.distrito,
    this.snip,
    this.idOperadorInternet,
    this.nomOperadorInternet,
    this.numAsignados,
    this.operativos,
    this.codOperativo,
    this.inoperativos,
    this.codInoperativo,
    this.enproceso,
    this.codEnProceso,
  });

  factory IndicadorInternetModel.fromJson(Map<String, dynamic> json) {
    return IndicadorInternetModel(
      idTambo: json[IndicadorInternetField.idTambo],
      nomTambo: json[IndicadorInternetField.nomTambo],
      region: json[IndicadorInternetField.region],
      provincia: json[IndicadorInternetField.provincia],
      distrito: json[IndicadorInternetField.distrito],
      snip: json[IndicadorInternetField.snip],
      idOperadorInternet: json[IndicadorInternetField.idOperadorInternet],
      nomOperadorInternet: json[IndicadorInternetField.nomOperadorInternet],
      numAsignados: json[IndicadorInternetField.numAsignados],
      operativos: json[IndicadorInternetField.numOperativos],
      codOperativo: json[IndicadorInternetField.codOperativo],
      inoperativos: json[IndicadorInternetField.numInoperativos],
      codInoperativo: json[IndicadorInternetField.codInoperativo],
      enproceso: json[IndicadorInternetField.numEnProceso],
      codEnProceso: json[IndicadorInternetField.codEnProceso],
    );
  }
}
