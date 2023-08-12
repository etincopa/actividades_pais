class Provincias {
  List<Provincia> items = [];
  Provincias();
  Provincias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Provincia.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class Provincia {
  String? provinciaDescripcion;
  String? provinciaUbigeo;

  Provincia({this.provinciaDescripcion, this.provinciaUbigeo});
  Provincia.fromJson(Map<String, dynamic> json) {
    provinciaDescripcion = json['provincia_descripcion'];
    provinciaUbigeo = json['provincia_ubigeo'];
  }

  Provincia.fromMap(Map<String, dynamic> map) {

    provinciaDescripcion = map['provincia_descripcion'];
    provinciaUbigeo = map['provincia_ubigeo'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provincia_descripcion'] = provinciaDescripcion;
    data['provincia_ubigeo'] = provinciaUbigeo;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "provincia_descripcion": provinciaDescripcion,
      "provincia_ubigeo": provinciaUbigeo,
    };
  }
}
