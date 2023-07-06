class ListaHistorialobservaciones{
  List<Historialobservaciones> items = [];

  ListaHistorialobservaciones();

  ListaHistorialobservaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Historialobservaciones.fromJson(item);
      items.add(listarTrabajador);
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacion'] = observacion;
    data['fecha_reg'] = fechaReg;
    data['id_evaluacion'] = idEvaluacion;
    return data;
  }
}