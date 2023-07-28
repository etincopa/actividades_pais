class ActividadesTambos {
  List<ActividadesTambo> items = [];
  ActividadesTambos();
  ActividadesTambos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ActividadesTambo.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class ActividadesTambo {
  int idActividad;
  String actividad;

  ActividadesTambo({
    this.idActividad = 0,
    this.actividad = '',
  });

  factory ActividadesTambo.fromMap(Map<String, dynamic> obj) =>
      ActividadesTambo(
        idActividad: obj['id_lugar_actividad'],
        actividad: obj['descripcion_lugar_actividad'],
      );

  factory ActividadesTambo.fromJson(Map<String, dynamic> obj) {
    return ActividadesTambo(
      idActividad: obj['id_lugar_actividad'],
      actividad: obj['descripcion_lugar_actividad'],
    );
  }
}
