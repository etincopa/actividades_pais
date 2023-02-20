class FiltroTicketEquipo {
    String? numeroTkt;
    String? asignado;
    String? estado;
    int? pageIndex;
    int? pageSize;
    String? idEquipo;

    FiltroTicketEquipo(
    {this.numeroTkt='',
        this.asignado='',
        this.estado='',
        this.pageIndex=0,
        this.pageSize=10,
        this.idEquipo=''});

    FiltroTicketEquipo.fromJson(Map<String, dynamic> json) {
        numeroTkt = json['numeroTkt']??'';
        asignado = json['asignado']??'';
        estado = json['estado']??'';
        pageIndex = json['pageIndex']??'';
        pageSize = json['pageSize']??'';
        idEquipo = json['id_equipo']??'';
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['numeroTkt'] = this.numeroTkt;
        data['asignado'] = this.asignado;
        data['estado'] = this.estado;
        data['pageIndex'] = this.pageIndex;
        data['pageSize'] = this.pageSize;
        data['id_equipo'] = this.idEquipo;
        return data;
    }
}