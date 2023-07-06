class CentroPobladoes {
  List<CentroPoblado> items = [];
  CentroPobladoes();
  CentroPobladoes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = CentroPoblado.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class CentroPoblado {
  String? centroPobladoUbigeo;
  String? centroPobladoDescripcion;

  CentroPoblado(
      {this.centroPobladoUbigeo = "", this.centroPobladoDescripcion = ""});

  CentroPoblado.fromJson(Map<String, dynamic> json) {
    centroPobladoUbigeo = json['centro_poblado_ubigeo'];
    centroPobladoDescripcion = json['centro_poblado_descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['centro_poblado_ubigeo'] = centroPobladoUbigeo;
    data['centro_poblado_descripcion'] = centroPobladoDescripcion;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      "centro_poblado_ubigeo": centroPobladoUbigeo,
      "centro_poblado_descripcion": centroPobladoDescripcion,

    };
  }
}
