class Distritos {
  List<Distrito> items = [];
  Distritos();
  Distritos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Distrito.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class Distrito {
  String? distritoDescripcion;
  String? distritoUbigeo;

  Distrito({this.distritoDescripcion, this.distritoUbigeo});
  Distrito.fromJson(Map<String, dynamic> json) {
    distritoDescripcion = json['distrito_descripcion'];
    distritoUbigeo = json['distrito_ubigeo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distrito_descripcion'] = distritoDescripcion;
    data['distrito_ubigeo'] = distritoUbigeo;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "distrito_descripcion": distritoDescripcion,
      "distrito_ubigeo": distritoUbigeo,

    };
  }
}
