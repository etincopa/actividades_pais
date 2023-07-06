class ListarEquipoMantenimiento {
  List<EquipoMantenimiento> items = [];

  ListarEquipoMantenimiento();

  ListarEquipoMantenimiento.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual =
      new EquipoMantenimiento.fromJson(item);
      items.add(_listarasistenciaActual);
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
  List? archivos=[];

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
      idEquipoInformaticoMantenimiento: json['id_equipo_informatico_mantenimiento'],
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['causa'] = this.causa;
    data['descripcion'] = this.descripcion;
    data['descripcion_tipo_mantenimiento'] = this.descripcionTipoMantenimiento;
    data['disco_duro'] = this.discoDuro;
    data['estado'] = this.estado;
    data['falla'] = this.falla;
    data['fecha_act'] = this.fechaAct;
    data['fecha_del'] = this.fechaDel;
    data['fechaMantenimiento'] = this.fechaMantenimiento;
    data['fecha_reg'] = this.fechaReg;
    data['flg_activo'] = this.flgActivo;
    data['id_archivo'] = this.idArchivo;
    data['idEquipo'] = this.idEquipo;
    data['id_equipo_informatico'] = this.idEquipoInformatico;
    data['id_equipo_informatico_mantenimiento'] = this.idEquipoInformaticoMantenimiento;
    data['id_tipo_mantenimiento'] = this.idTipoMantenimiento;
    data['id_ticket'] = this.idTicket;
    data['id_usuario_act'] = this.idUsuarioAct;
    data['id_usuario_del'] = this.idUsuarioDel;
    data['id_usuario_reg'] = this.idUsuarioReg;
    data['id_usuario_responsable'] = this.idUsuarioResponsable;
    data['informe_tecnico'] = this.informeTecnico;
    data['ipmaq_act'] = this.ipmaqAct;
    data['ipmaq_del'] = this.ipmaqDel;
    data['ipmaq_reg'] = this.ipmaqReg;
    data['nombres_apellidos'] = this.nombresApellidos;
    data['observacion'] = this.observacion;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['procesador'] = this.procesador;
    data['ram'] = this.ram;
    data['ruta_informe_tecnico'] = this.rutaInformeTecnico;
    data['seleccionarTipoMantenimiento'] = this.seleccionarTipoMantenimiento;
    data['sist_operativo'] = this.sistOperativo;
    data['solucion'] = this.solucion;
    data['tecnologia'] = this.tecnologia;
    data['tipoMantenimiento'] = this.tipoMantenimiento;
    data['total'] = this.total;
    data['id_equipo'] = this.id_equipo;
    data['archivos'] = this.archivos;

    return data;
  }
}
