class ListaMarcas {
  List<Marca> items = [];

  ListaMarcas();

  ListaMarcas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual =
      new Marca.fromJson(item);
      items.add(_listarasistenciaActual);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_marca'] = this.idMarca;
    data['descripcion_marca'] = this.descripcionMarca;
    return data;
  }
}