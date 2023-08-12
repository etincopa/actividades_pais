class ListaTipoAtencion {
  List<TipoAtencion> items = [];
  ListaTipoAtencion();
  ListaTipoAtencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = TipoAtencion.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class TipoAtencion {
  int? id;
  String? cod;
  String? descripcion;

  TipoAtencion({this.id,this.cod, this.descripcion});

  TipoAtencion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cod = json['cod'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cod'] = cod;
    data['descripcion'] = descripcion;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "descripcion": descripcion,
    };
  }
}