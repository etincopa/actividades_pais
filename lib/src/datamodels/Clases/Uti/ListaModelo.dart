class ListaModelos {
  List<Modelo> items = [];

  ListaModelos();

  ListaModelos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual = new Modelo.fromJson(item);
      items.add(_listarasistenciaActual);
    }
  }
}

class Modelo {
  int? idModelo;
  String? descripcionModelo;
  String? idMarca;

  Modelo({this.idModelo, this.descripcionModelo, this.idMarca});

  Modelo.fromJson(Map<String, dynamic> json) {
    idModelo = json['id_modelo'] ?? 0;
    descripcionModelo = json['descripcion_modelo']?? 0;
    idMarca = json['id_marca']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_modelo'] = this.idModelo;
    data['descripcion_modelo'] = this.descripcionModelo;
    data['id_marca'] = this.idMarca;
    return data;
  }
}
