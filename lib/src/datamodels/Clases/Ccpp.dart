class ListarCcppes {
  List<ListarCcpp> items = [];
  ListarCcppes();
  ListarCcppes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ListarCcpp.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class ListarCcpp {
  String? ubigeoCcpp;
  String? nombreCcpp;
  double? snip;

  ListarCcpp({this.ubigeoCcpp = "", this.nombreCcpp = "", this.snip =0.0});

  ListarCcpp.fromJson(Map<String, dynamic> json) {
    ubigeoCcpp = json['ubigeo_ccpp'];
    nombreCcpp = json['nombre_ccpp'];
    snip = json['snip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ubigeo_ccpp'] = ubigeoCcpp;
    data['nombre_ccpp'] = nombreCcpp;
    data['snip'] = snip;
    return data;
  }

  factory ListarCcpp.fromMap(Map<String, dynamic> json) =>
      ListarCcpp(
        ubigeoCcpp: json['ubigeoCcpp'],
        nombreCcpp: json['nombreCcpp'],
        snip: json['snip'],

      );

  Map<String, dynamic> toMap() {
    return {
      "ubigeoCcpp": ubigeoCcpp,
      "nombreCcpp": nombreCcpp,
      "snip": snip,
    };
  }
}

