class ListaEquipoInformaticos {
  List<ListaEquipoInformatico> items = [];

  ListaEquipoInformaticos();

  ListaEquipoInformaticos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = ListaEquipoInformatico.fromJson(item);
      items.add(listarasistenciaActual);
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_equipo_informatico'] = idEquipoInformatico;
    data['id_tipo_equipo_informatico'] = idTipoEquipoInformatico;
    data['descripcion_equipo_informatico'] = descripcionEquipoInformatico;
    data['codigo_patrimonial'] = codigoPatrimonial;
    data['id_modelo'] = idModelo;
    data['color'] = color;
    data['serie'] = serie;
    data['fec_ingreso'] = fecIngreso;
    data['id_proveedor'] = idProveedor;
    data['fec_fin_garantia_proveedor'] = fecFinGarantiaProveedor;
    data['id_archivo'] = idArchivo;
    data['flg_activo'] = flgActivo;
    data['id_usuario_reg'] = idUsuarioReg;
    data['fecha_reg'] = fechaReg;
    data['ipmaq_reg'] = ipmaqReg;
    data['id_usuario_act'] = idUsuarioAct;
    data['fecha_act'] = fechaAct;
    data['ipmaq_act'] = ipmaqAct;
    data['id_usuario_del'] = idUsuarioDel;
    data['fecha_del'] = fechaDel;
    data['ipmaq_del'] = ipmaqDel;
    data['proveedor'] = proveedor;
    data['descripcion_marca'] = descripcionMarca;
    data['descripcion_modelo'] = descripcionModelo;
    data['descripcion_tipo_equipo_informatico'] =
        descripcionTipoEquipoInformatico;
    data['empleado'] = empleado;
    data['ubicacion'] = ubicacion;
    data['id_marca'] = idMarca;
    data['estado'] = estado;
    data['jefe'] = jefe;
    data['totalManto'] = totalManto;
    data['total'] = total;
    data['archivos'] = archivos;
    return data;
  }
}
