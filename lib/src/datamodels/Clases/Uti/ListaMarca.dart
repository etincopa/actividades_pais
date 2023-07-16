class ListaMarcas {
  List<Marca> items = [];

  ListaMarcas();

  ListaMarcas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual =
      Marca.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class Marca {
  int? idMarca;
  String? descripcionMarca;

  Marca({this.idMarca =0, this.descripcionMarca = ''});

  Marca.fromJson(Map<String, dynamic> json) {
    idMarca = json['id_marca']?? 0;
    descripcionMarca = json['descripcion_marca']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_marca'] = idMarca;
    data['descripcion_marca'] = descripcionMarca;
    return data;
  }
}