class ListarProveedores {
  List<Proveedores> items = [];

  ListarProveedores();

  ListarProveedores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual = new Proveedores.fromJson(item);
      items.add(_listarasistenciaActual);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProveedor'] = this.idProveedor;
    data['CID_DOCUMENTO'] = this.cIDDOCUMENTO;
    data['proveedor'] = this.proveedor;
    data['telefono'] = this.telefono;
    return data;
  }
}