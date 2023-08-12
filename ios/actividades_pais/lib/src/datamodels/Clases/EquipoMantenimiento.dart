class ListarEquipoMantenimiento {
  List<EquipoMantenimiento> items = [];

  ListarEquipoMantenimiento();

  ListarEquipoMantenimiento.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = EquipoMantenimiento.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class EquipoMantenimiento {
  String? causa;
  String? descripcion;
  String? descripcionTipoMantenimiento;
  String? discoDuro;
  String? estado;
  String? falla;
  String? fechaAct;
  String? fechaDel;
  String? fechaMantenimiento;
  String? fechaReg;
  String? flgActivo;
  String? idArchivo;
  String? idEquipo;
  String? idEquipoInformatico;
  String? idEquipoInformaticoMantenimiento;
  String? idTipoMantenimiento;
  String? idTicket;
  String? idUsuarioAct;
  String? idUsuarioDel;
  String? idUsuarioReg;
  String? idUsuarioResponsable;
  String? informeTecnico;
  String? ipmaqAct;
  String? ipmaqDel;
  String? ipmaqReg;
  String? nombresApellidos;
  String? observacion;
  String? pageIndex;
  String? pageSize;
  String? procesador;
  String? ram;
  String? rutaInformeTecnico;
  String? seleccionarTipoMantenimiento;
  String? sistOperativo;
  String? solucion;
  String? tecnologia;
  String? tipoMantenimiento;
  String? total;

  String? id_equipo;
  List? archivos = [];

  EquipoMantenimiento({
    this.idEquipoInformaticoMantenimiento,
    this.idEquipoInformatico,
    this.idEquipo,
    this.idTipoMantenimiento,
    this.tipoMantenimiento,
    this.idUsuarioResponsable,
    this.observacion,
    this.fechaMantenimiento,
    this.idArchivo,
    this.falla,
    this.causa,
    this.solucion,
    this.idTicket,
    this.tecnologia,
    this.procesador,
    this.ram,
    this.discoDuro,
    this.sistOperativo,
    this.flgActivo,
    this.idUsuarioReg,
    this.fechaReg,
    this.ipmaqReg,
    this.idUsuarioAct,
    this.fechaAct,
    this.ipmaqAct,
    this.idUsuarioDel,
    this.fechaDel,
    this.ipmaqDel,
    this.descripcionTipoMantenimiento,
    this.descripcion,
    this.informeTecnico,
    this.rutaInformeTecnico,
    this.total,
    this.estado,
    this.nombresApellidos,
    this.pageIndex,
    this.pageSize,
    this.id_equipo,
    this.archivos,
  });

  factory EquipoMantenimiento.fromJson(Map<String, dynamic> json) {
    return EquipoMantenimiento(
      causa: json['causa'],
      descripcion: json['descripcion'],
      descripcionTipoMantenimiento: json['descripcion_tipo_mantenimiento'],
      discoDuro: json['disco_duro'],
      estado: json['estado'],
      falla: json['falla'],
      fechaAct: json['fecha_act'],
      fechaDel: json['fecha_del'],
      fechaMantenimiento: json['fecha_mantenimiento'],
      fechaReg: json['fecha_reg'],
      flgActivo: json['flg_activo'],
      idArchivo: json['id_archivo'],
      idEquipo: json['idEquipo'],
      idEquipoInformatico: json['id_equipo_informatico'],
      idEquipoInformaticoMantenimiento:
          json['id_equipo_informatico_mantenimiento'],
      idTipoMantenimiento: json['id_tipo_mantenimiento'],
      idTicket: json['id_ticket'],
      idUsuarioAct: json['id_usuario_act'],
      idUsuarioDel: json['id_usuario_del'],
      idUsuarioReg: json['id_usuario_reg'],
      idUsuarioResponsable: json['id_usuario_responsable'],
      informeTecnico: json['informe_tecnico'],
      ipmaqAct: json['ipmaq_act'],
      ipmaqDel: json['ipmaq_del'],
      ipmaqReg: json['ipmaq_reg'],
      nombresApellidos: json['nombres_apellidos'],
      observacion: json['observacion'],
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      procesador: json['procesador'],
      ram: json['ram'],
      rutaInformeTecnico: json['ruta_informe_tecnico'],
      sistOperativo: json['sist_operativo'],
      solucion: json['solucion'],
      tecnologia: json['tecnologia'],
      tipoMantenimiento: json['tipoMantenimiento'],
      total: json['total'],
      id_equipo: json['id_equipo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['causa'] = causa;
    data['descripcion'] = descripcion;
    data['descripcion_tipo_mantenimiento'] = descripcionTipoMantenimiento;
    data['disco_duro'] = discoDuro;
    data['estado'] = estado;
    data['falla'] = falla;
    data['fecha_act'] = fechaAct;
    data['fecha_del'] = fechaDel;
    data['fechaMantenimiento'] = fechaMantenimiento;
    data['fecha_reg'] = fechaReg;
    data['flg_activo'] = flgActivo;
    data['id_archivo'] = idArchivo;
    data['idEquipo'] = idEquipo;
    data['id_equipo_informatico'] = idEquipoInformatico;
    data['id_equipo_informatico_mantenimiento'] =
        idEquipoInformaticoMantenimiento;
    data['id_tipo_mantenimiento'] = idTipoMantenimiento;
    data['id_ticket'] = idTicket;
    data['id_usuario_act'] = idUsuarioAct;
    data['id_usuario_del'] = idUsuarioDel;
    data['id_usuario_reg'] = idUsuarioReg;
    data['id_usuario_responsable'] = idUsuarioResponsable;
    data['informe_tecnico'] = informeTecnico;
    data['ipmaq_act'] = ipmaqAct;
    data['ipmaq_del'] = ipmaqDel;
    data['ipmaq_reg'] = ipmaqReg;
    data['nombres_apellidos'] = nombresApellidos;
    data['observacion'] = observacion;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['procesador'] = procesador;
    data['ram'] = ram;
    data['ruta_informe_tecnico'] = rutaInformeTecnico;
    data['seleccionarTipoMantenimiento'] = seleccionarTipoMantenimiento;
    data['sist_operativo'] = sistOperativo;
    data['solucion'] = solucion;
    data['tecnologia'] = tecnologia;
    data['tipoMantenimiento'] = tipoMantenimiento;
    data['total'] = total;
    data['id_equipo'] = id_equipo;
    data['archivos'] = archivos;

    return data;
  }
}
