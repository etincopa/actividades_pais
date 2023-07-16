class ListarProveedores {
  List<Proveedores> items = [];

  ListarProveedores();

  ListarProveedores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = Proveedores.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class Proveedores {
  String? idProveedor;
  String? cIDDOCUMENTO;
  String? proveedor;
  String? telefono;

  Proveedores(
      {this.idProveedor, this.cIDDOCUMENTO, this.proveedor, this.telefono});

  Proveedores.fromJson(Map<String, dynamic> json) {
    idProveedor = json['idProveedor']?? '';
    cIDDOCUMENTO = json['CID_DOCUMENTO']?? '';
    proveedor = json['proveedor']?? '';
    telefono = json['telefono']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idProveedor'] = idProveedor;
    data['CID_DOCUMENTO'] = cIDDOCUMENTO;
    data['proveedor'] = proveedor;
    data['telefono'] = telefono;
    return data;
  }
}