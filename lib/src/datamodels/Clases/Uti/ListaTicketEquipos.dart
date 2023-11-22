class ListaEquiposInformaticosTickets {
  List<ListaEquiposInformaticosTicket> items = [];

  ListaEquiposInformaticosTickets();

  ListaEquiposInformaticosTickets.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = ListaEquiposInformaticosTicket.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class ListaEquiposInformaticosTicket {
  String? idTicket;
  String? codigoPatrimonial;
  String? idTicketEstado;
  String? idUsuarioAsignado;
  String? idEquipoInformatico;
  String? idEquipoInformaticoTicket;
  String? material;
  String? repuesto;
  String? estado;
  String? resuelto;
  String? usuarioAsignado;
  String? total;

  ListaEquiposInformaticosTicket(
      {this.idTicket,
        this.codigoPatrimonial,
        this.idTicketEstado,
        this.idUsuarioAsignado,
        this.idEquipoInformatico,
        this.idEquipoInformaticoTicket,
        this.material,
        this.repuesto,
        this.estado,
        this.resuelto,
        this.usuarioAsignado,
        this.total});

  ListaEquiposInformaticosTicket.fromJson(Map<String, dynamic> json) {
    idTicket = json['id_ticket'] ?? '';
    codigoPatrimonial = json['codigo_patrimonial']?? '';
    idTicketEstado = json['id_ticket_estado']?? '';
    idUsuarioAsignado = json['id_usuario_asignado']?? '';
    idEquipoInformatico = json['id_equipo_informatico']?? '';
    idEquipoInformaticoTicket = json['id_equipo_informatico_ticket']?? '';
    material = json['material']?? '';
    repuesto = json['repuesto']?? '';
    estado = json['estado']?? '';
    resuelto = json['resuelto']?? '';
    usuarioAsignado = json['usuario_asignado']?? '';
    total = json['total']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_ticket'] = idTicket;
    data['codigo_patrimonial'] = codigoPatrimonial;
    data['id_ticket_estado'] = idTicketEstado;
    data['id_usuario_asignado'] = idUsuarioAsignado;
    data['id_equipo_informatico'] = idEquipoInformatico;
    data['id_equipo_informatico_ticket'] = idEquipoInformaticoTicket;
    data['material'] = material;
    data['repuesto'] = repuesto;
    data['estado'] = estado;
    data['resuelto'] = resuelto;
    data['usuario_asignado'] = usuarioAsignado;
    data['total'] = total;
    return data;
  }
}