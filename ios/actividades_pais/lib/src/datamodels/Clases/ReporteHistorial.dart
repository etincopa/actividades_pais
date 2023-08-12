class ReporteHistorials {
  List<ReporteHistorial> items = [];
  ReporteHistorials();
  ReporteHistorials.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ReporteHistorial.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class ReporteHistorial {
  String idAsistencia;
  String idSeguimiento;
  String idTipoCheck;
  String nombreTipoCheck;
  String fechaSeguimiento;
  String horaSeguimiento;
  String longitudSeguimiento;
  String latitudSeguimiento;
  String idTipoTrabajo;
  dynamic tipoTrabajo;

  ReporteHistorial({
    this.idAsistencia = '',
    this.idSeguimiento = '',
    this.idTipoCheck = '',
    this.nombreTipoCheck = '',
    this.fechaSeguimiento = '',
    this.horaSeguimiento = '',
    this.longitudSeguimiento = '',
    this.latitudSeguimiento = '',
    this.idTipoTrabajo = '',
    this.tipoTrabajo = '',
  });

  factory ReporteHistorial.fromMap(Map<String, dynamic> obj) =>
      ReporteHistorial(
        idAsistencia: obj["id_asistencia"],
        idSeguimiento: obj["id_seguimiento"],
        idTipoCheck: obj["id_tipo_check"],
        nombreTipoCheck: obj["nombre_tipo_check"],
        fechaSeguimiento: obj["fecha_seguimiento"],
        horaSeguimiento: obj["hora_seguimiento"],
        longitudSeguimiento: obj["longitud_seguimiento"],
        latitudSeguimiento: obj["latitud_seguimiento"],
        idTipoTrabajo: obj["id_tipo_trabajo"],
        tipoTrabajo: obj["tipo_trabajo"],
      );

  factory ReporteHistorial.fromJson(Map<String, dynamic> json) {
    return ReporteHistorial(
      idAsistencia: json["id_asistencia"],
      idSeguimiento: json["id_seguimiento"],
      idTipoCheck: json["id_tipo_check"],
      nombreTipoCheck: json["nombre_tipo_check"],
      fechaSeguimiento: json["fecha_seguimiento"],
      horaSeguimiento: json["hora_seguimiento"],
      longitudSeguimiento: json["longitud_seguimiento"],
      latitudSeguimiento: json["latitud_seguimiento"],
      idTipoTrabajo: json["id_tipo_trabajo"],
      tipoTrabajo: json["tipo_trabajo"],
    );
  }
}
