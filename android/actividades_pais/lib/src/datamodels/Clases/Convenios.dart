class Convenios {
  String? idConvenio;
  String? nombrePrograma;

  Convenios({this.idConvenio, this.nombrePrograma});

  Convenios.fromJson(Map<String, dynamic> json) {
    idConvenio = json['id_convenio'];
    nombrePrograma = json['nombre_programa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_convenio'] = idConvenio;
    data['nombre_programa'] = nombrePrograma;
    return data;
  }
}