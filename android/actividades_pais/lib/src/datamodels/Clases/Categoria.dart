class Categoria {
  String? idCategoria;
  String? nombreCategoria;

  Categoria({this.idCategoria, this.nombreCategoria});

  Categoria.fromJson(Map<String, dynamic> json) {
    idCategoria = json['id_categoria'];
    nombreCategoria = json['nombre_categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_categoria'] = idCategoria;
    data['nombre_categoria'] = nombreCategoria;
    return data;
  }
}