class ListarTipoMantenimiento {
  List<TipoMantenimiento> items = [];

  ListarTipoMantenimiento();

  ListarTipoMantenimiento.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {

      final _listarasistenciaActual =
      new TipoMantenimiento.fromJson(item);

      items.add(_listarasistenciaActual);

    }
  }
}

class TipoMantenimiento {
    int idTipoMantenimiento;
    String descripcionTipoMantenimiento;

  TipoMantenimiento({
    required this.idTipoMantenimiento,
    required this.descripcionTipoMantenimiento,
  });
  factory TipoMantenimiento.fromJson(Map<String, dynamic> json) {
    print(json['id_tipo_mantenimiento']);
   // I/flutter ( 5532): [{id_tipo_mantenimiento: 1, descripcion_tipo_mantenimiento: PREVENTIVO}, {id_tipo_mantenimiento: 2, descripcion_tipo_mantenimiento: CORRECTIVO}]

    return TipoMantenimiento(
      idTipoMantenimiento: json['id_tipo_mantenimiento'],
      descripcionTipoMantenimiento: json['descripcion_tipo_mantenimiento'],
    );
  }



}
