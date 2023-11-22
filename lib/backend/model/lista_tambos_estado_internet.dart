class ListaTambosEstadoInternetField {
  static String idUt = "idUt";
  static String region = "region";
  static String provincia = "provincia";
  static String distrito = "distrito";
  static String idTambo = "idTambo";
  static String nomTambo = "nomTambo";
  static String snip = "snip";
  static String idOperador = "idOperador";
  static String proveedor = "proveedor";
  static String idEstadoInternet = "idEstadoInternet";
  static String cidEstadoInternet = "cidEstadoInternet";
  static String nomEstado = "nomEstado";
}

class ListaTambosEstadoInternetModel {
  String? idUt;
  String? region;
  String? provincia;
  String? distrito;
  String? idTambo;
  String? nomTambo;
  String? snip;
  String? idOperador;
  String? proveedor;
  String? idEstado;
  String? cidEstado;
  String? nomEstado;

  ListaTambosEstadoInternetModel.empty();

  ListaTambosEstadoInternetModel({
    this.idUt,
    this.region,
    this.provincia,
    this.distrito,
    this.idTambo,
    this.nomTambo,
    this.snip,
    this.idOperador,
    this.proveedor,
    this.idEstado,
    this.cidEstado,
    this.nomEstado,
  });

  factory ListaTambosEstadoInternetModel.fromJson(Map<String, dynamic> json) {
    return ListaTambosEstadoInternetModel(
      idUt: json[ListaTambosEstadoInternetField.idUt],
      region: json[ListaTambosEstadoInternetField.region],
      provincia: json[ListaTambosEstadoInternetField.provincia],
      distrito: json[ListaTambosEstadoInternetField.distrito],
      idTambo: json[ListaTambosEstadoInternetField.idTambo],
      nomTambo: json[ListaTambosEstadoInternetField.nomTambo],
      snip: json[ListaTambosEstadoInternetField.snip],
      idOperador: json[ListaTambosEstadoInternetField.idOperador],
      proveedor: json[ListaTambosEstadoInternetField.proveedor],
      idEstado: json[ListaTambosEstadoInternetField.idEstadoInternet],
      cidEstado: json[ListaTambosEstadoInternetField.cidEstadoInternet],
      nomEstado: json[ListaTambosEstadoInternetField.nomEstado],
    );
  }
}
