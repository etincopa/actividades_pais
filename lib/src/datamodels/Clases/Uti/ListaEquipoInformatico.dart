class ListaEquipoInformaticos {
  List<ListaEquipoInformatico> items = [];

  ListaEquipoInformaticos();

  ListaEquipoInformaticos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual = new ListaEquipoInformatico.fromJson(item);
      items.add(_listarasistenciaActual);
    }
  }
}

class ListaEquipoInformatico {
  String? idEquipoInformatico;
  String? idTipoEquipoInformatico;
  String? descripcionEquipoInformatico;
  String? codigoPatrimonial;
  String? idModelo;
  String? color;
  String? serie;
  String? fecIngreso;
  String? idProveedor;
  String? fecFinGarantiaProveedor;
  String? idArchivo;
  String? flgActivo;
  String? idUsuarioReg;
  String? fechaReg;
  String? ipmaqReg;
  String? idUsuarioAct;
  String? fechaAct;
  String? ipmaqAct;
  String? idUsuarioDel;
  String? fechaDel;
  String? ipmaqDel;
  String? proveedor;
  String? descripcionMarca;
  String? descripcionModelo;
  String? descripcionTipoEquipoInformatico;
  String? empleado;
  String? ubicacion;
  String? idMarca;
  String? estado;
  String? jefe;
  String? totalManto;
  String? total;
  List? archivos;

  ListaEquipoInformatico(
      {this.idEquipoInformatico = '',
      this.idTipoEquipoInformatico = '',
      this.descripcionEquipoInformatico = '',
      this.codigoPatrimonial = '',
      this.idModelo = '',
      this.color = '',
      this.serie = '',
      this.fecIngreso = '',
      this.idProveedor = '',
      this.fecFinGarantiaProveedor = '',
      this.idArchivo = '',
      this.flgActivo = '',
      this.idUsuarioReg = '',
      this.fechaReg = '',
      this.ipmaqReg = '',
      this.idUsuarioAct = '',
      this.fechaAct = '',
      this.ipmaqAct = '',
      this.idUsuarioDel = '',
      this.fechaDel = '',
      this.ipmaqDel = '',
      this.proveedor = '',
      this.descripcionMarca = '',
      this.descripcionModelo = '',
      this.descripcionTipoEquipoInformatico = '',
      this.empleado = '',
      this.ubicacion = '',
      this.idMarca = '',
      this.estado = '',
      this.jefe = '',
      this.totalManto = '',
      this.total = '',
      this.archivos});

  ListaEquipoInformatico.fromJson(Map<String, dynamic> json) {
    idEquipoInformatico = json['id_equipo_informatico'] ?? '';
    idTipoEquipoInformatico = json['id_tipo_equipo_informatico'] ?? '';
    descripcionEquipoInformatico = json['descripcion_equipo_informatico'] ?? '';
    codigoPatrimonial = json['codigo_patrimonial'] ?? '';
    idModelo = json['id_modelo'] ?? '';
    color = json['color'] ?? '';
    serie = json['serie'] ?? '';
    fecIngreso = json['fec_ingreso'] ?? '';
    idProveedor = json['id_proveedor'] ?? '';
    fecFinGarantiaProveedor = json['fec_fin_garantia_proveedor'] ?? '';
    idArchivo = json['id_archivo'] ?? '';
    flgActivo = json['flg_activo'] ?? '';
    idUsuarioReg = json['id_usuario_reg'] ?? '';
    fechaReg = json['fecha_reg'] ?? '';
    ipmaqReg = json['ipmaq_reg'] ?? '';
    idUsuarioAct = json['id_usuario_act'] ?? '';
    fechaAct = json['fecha_act'] ?? '';
    ipmaqAct = json['ipmaq_act'] ?? '';
    idUsuarioDel = json['id_usuario_del'] ?? '';
    fechaDel = json['fecha_del'] ?? '';
    ipmaqDel = json['ipmaq_del'] ?? '';
    proveedor = json['proveedor'] ?? '';
    descripcionMarca = json['descripcion_marca'] ?? '';
    descripcionModelo = json['descripcion_modelo'] ?? '';
    descripcionTipoEquipoInformatico =
        json['descripcion_tipo_equipo_informatico'] ?? '';
    empleado = json['empleado'] ?? '';
    ubicacion = json['ubicacion'] ?? '';
    idMarca = json['id_marca'] ?? '';
    estado = json['estado'] ?? '';
    jefe = json['jefe'] ?? '';
    totalManto = json['totalManto'] ?? '';
    total = json['total'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_equipo_informatico'] = this.idEquipoInformatico;
    data['id_tipo_equipo_informatico'] = this.idTipoEquipoInformatico;
    data['descripcion_equipo_informatico'] = this.descripcionEquipoInformatico;
    data['codigo_patrimonial'] = this.codigoPatrimonial;
    data['id_modelo'] = this.idModelo;
    data['color'] = this.color;
    data['serie'] = this.serie;
    data['fec_ingreso'] = this.fecIngreso;
    data['id_proveedor'] = this.idProveedor;
    data['fec_fin_garantia_proveedor'] = this.fecFinGarantiaProveedor;
    data['id_archivo'] = this.idArchivo;
    data['flg_activo'] = this.flgActivo;
    data['id_usuario_reg'] = this.idUsuarioReg;
    data['fecha_reg'] = this.fechaReg;
    data['ipmaq_reg'] = this.ipmaqReg;
    data['id_usuario_act'] = this.idUsuarioAct;
    data['fecha_act'] = this.fechaAct;
    data['ipmaq_act'] = this.ipmaqAct;
    data['id_usuario_del'] = this.idUsuarioDel;
    data['fecha_del'] = this.fechaDel;
    data['ipmaq_del'] = this.ipmaqDel;
    data['proveedor'] = this.proveedor;
    data['descripcion_marca'] = this.descripcionMarca;
    data['descripcion_modelo'] = this.descripcionModelo;
    data['descripcion_tipo_equipo_informatico'] =
        this.descripcionTipoEquipoInformatico;
    data['empleado'] = this.empleado;
    data['ubicacion'] = this.ubicacion;
    data['id_marca'] = this.idMarca;
    data['estado'] = this.estado;
    data['jefe'] = this.jefe;
    data['totalManto'] = this.totalManto;
    data['total'] = this.total;
    data['archivos'] = this.archivos;
    return data;
  }
}
