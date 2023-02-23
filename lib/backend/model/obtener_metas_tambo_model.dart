class MetasTamboFld {
  static String numSnip = 'numSnip';
  static String idTambo = 'idTambo';
  static String anio = 'anio';
  static String numTipoMeta = 'numTipoMeta';
  static String metaTotal = 'metaTotal';
  static String mes = 'mes';
}

class MetasTamboModel {
  int? idTambo;
  String? nombreFisicoFoto;
  String? anio;
  int? numTipoMeta;
  int? metaTotal;
  String? mes;

  MetasTamboModel.empty() {}

  MetasTamboModel({
    this.nombreFisicoFoto,
    this.idTambo,
    this.anio,
    this.numTipoMeta,
    this.mes,
    this.metaTotal,
  });

  factory MetasTamboModel.fromJson(Map<String, dynamic> json) {
    return MetasTamboModel(
      nombreFisicoFoto: json[MetasTamboFld.numSnip],
      idTambo: json[MetasTamboFld.idTambo],
      anio: json[MetasTamboFld.anio],
      numTipoMeta: json[MetasTamboFld.numTipoMeta],
      metaTotal: json[MetasTamboFld.metaTotal],
      mes: json[MetasTamboFld.mes],
    );
  }
}
