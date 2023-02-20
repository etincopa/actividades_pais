class ListaEquiposInformaticosTickets {
  List<ListaEquiposInformaticosTicket> items = [];

  ListaEquiposInformaticosTickets();

  ListaEquiposInformaticosTickets.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual = new ListaEquiposInformaticosTicket.fromJson(item);
      items.add(_listarasistenciaActual);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_ticket'] = this.idTicket;
    data['codigo_patrimonial'] = this.codigoPatrimonial;
    data['id_ticket_estado'] = this.idTicketEstado;
    data['id_usuario_asignado'] = this.idUsuarioAsignado;
    data['id_equipo_informatico'] = this.idEquipoInformatico;
    data['id_equipo_informatico_ticket'] = this.idEquipoInformaticoTicket;
    data['material'] = this.material;
    data['repuesto'] = this.repuesto;
    data['estado'] = this.estado;
    data['resuelto'] = this.resuelto;
    data['usuario_asignado'] = this.usuarioAsignado;
    data['total'] = this.total;
    return data;
  }
}