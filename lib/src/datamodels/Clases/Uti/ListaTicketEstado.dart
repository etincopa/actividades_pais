class ListaTicketEstados {
  List<ListaTicketEstado> items = [];

  ListaTicketEstados();

  ListaTicketEstados.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual =
      ListaTicketEstado.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}
class ListaTicketEstado {
  String? nombre;
  int? idTicketEstado;

  ListaTicketEstado({this.nombre, this.idTicketEstado});

  ListaTicketEstado.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre']??'';
    idTicketEstado = json['id_ticket_estado']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['id_ticket_estado'] = idTicketEstado;
    return data;
  }
}