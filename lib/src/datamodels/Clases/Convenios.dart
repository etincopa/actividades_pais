class Convenios {
  String? idConvenio;
  String? nombrePrograma;

  Convenios({this.idConvenio, this.nombrePrograma});

  Convenios.fromJson(Map<String, dynamic> json) {
    idConvenio = json['id_convenio'];
    nombrePrograma = json['nombre_programa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_convenio'] = this.idConvenio;
    data['nombre_programa'] = this.nombrePrograma;
    return data;
  }
}