class TipoDocumentoAcredita {
  int? idDocumentoAcredita;
  String? nombreDocumentoAcredita;

  TipoDocumentoAcredita(
      {this.idDocumentoAcredita, this.nombreDocumentoAcredita});

  TipoDocumentoAcredita.fromJson(Map<String, dynamic> json) {
    idDocumentoAcredita = json['id_documento_acredita'];
    nombreDocumentoAcredita = json['nombre_documento_acredita'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_documento_acredita'] = idDocumentoAcredita;
    data['nombre_documento_acredita'] = nombreDocumentoAcredita;
    return data;
  }
}