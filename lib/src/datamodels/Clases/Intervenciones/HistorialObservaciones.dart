class ListaHistorialobservaciones{
  List<Historialobservaciones> items = [];

  ListaHistorialobservaciones();

  ListaHistorialobservaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Historialobservaciones.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}
class Historialobservaciones {
  String? id;
  String? observacion;
  String? fechaReg;
  String? idEvaluacion;

  Historialobservaciones(
      {this.id, this.observacion, this.fechaReg, this.idEvaluacion});

  Historialobservaciones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observacion = json['observacion'];
    fechaReg = json['fecha_reg'];
    idEvaluacion = json['id_evaluacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['observacion'] = this.observacion;
    data['fecha_reg'] = this.fechaReg;
    data['id_evaluacion'] = this.idEvaluacion;
    return data;
  }
}