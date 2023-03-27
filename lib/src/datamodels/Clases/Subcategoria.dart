class Subcategoria {
  String? idSubcategoria;
  String? nombreSubcategoria;
  String? idEntidad;

  Subcategoria({this.idSubcategoria, this.nombreSubcategoria, this.idEntidad});

  Subcategoria.fromJson(Map<String, dynamic> json) {
    idSubcategoria = json['id_subcategoria'];
    nombreSubcategoria = json['nombre_subcategoria'];
    idEntidad = json['id_entidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_subcategoria'] = this.idSubcategoria;
    data['nombre_subcategoria'] = this.nombreSubcategoria;
    data['id_entidad'] = this.idEntidad;
    return data;
  }
}