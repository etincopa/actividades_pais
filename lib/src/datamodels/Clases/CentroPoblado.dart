class CentroPobladoes {
  List<CentroPoblado> items = [];
  CentroPobladoes();
  CentroPobladoes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new CentroPoblado.fromJson(item);
      items.add(_listarTrabajador);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centro_poblado_ubigeo'] = this.centroPobladoUbigeo;
    data['centro_poblado_descripcion'] = this.centroPobladoDescripcion;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      "centro_poblado_ubigeo": centroPobladoUbigeo,
      "centro_poblado_descripcion": centroPobladoDescripcion,

    };
  }
}
