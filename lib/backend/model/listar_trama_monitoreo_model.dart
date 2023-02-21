import 'dart:convert';

String tableNameTramaMonitoreos = 'listar_trama_monitoreo';

class MonitorFields {
  static final List<String> values = [
    ////Add all fields
    id,
    isEdit,
    time,

    item,
    idMonitoreo,
    idEstadoMonitoreo,
    estadoMonitoreo,
    idUsuario,
    usuario,
    idRol,
    rol,
    tambo,
    snip,
    cui,
    fechaMonitoreo,
    avanceFisicoAcumulado,
    idEstadoAvance,
    estadoAvance,
    actividadPartidaEjecutada,
    idAvanceFisicoPartida,
    avanceFisicoPartida,
    observaciones,
    imgActividad,
    imgActividad1,
    imgActividad2,
    imgActividad3,
    imgActividad4,
    problemaIdentificado,
    idProblemaIdentificado,
    imgProblema,
    imgProblema1,
    imgProblema2,
    imgProblema3,
    imgProblema4,
    alternativaSolucion,
    idAlternativaSolucion,
    riesgoIdentificado,
    idRiesgoIdentificado,
    imgRiesgo,
    imgRiesgo1,
    imgRiesgo2,
    imgRiesgo3,
    imgRiesgo4,
    fechaTerminoEstimado,
    latitud,
    longitud,
    txtIpReg,
    fechaInicio,
    fechaFin,
    nomEstado,
    nivelRiesgo,
  ];

  /*
   * Propiedades DB
   */
  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String item = 'item';
  static String idMonitoreo = 'idMonitoreo';
  static String idEstadoMonitoreo = 'idEstadoMonitoreo';
  static String estadoMonitoreo = 'estadoMonitoreo';
  static String idUsuario = 'idUsuario';
  static String usuario = 'usuario';
  static String idRol = 'idRol';
  static String rol = 'rol';
  static String tambo = 'tambo';
  static String snip = 'snip';
  static String cui = 'cui';
  static String fechaMonitoreo = 'fechaMonitoreo';
  static String avanceFisicoAcumulado = 'avanceFisicoAcumulado';
  static String idEstadoAvance = 'idEstadoAvance';
  static String estadoAvance = 'EstadoAvance';
  static String actividadPartidaEjecutada = 'actividadPartidaEjecutada';
  static String idAvanceFisicoPartida = 'idAvanceFisicoPartida';
  static String avanceFisicoPartida = 'avanceFisicoPartida';
  static String observaciones = 'observaciones';
  static String imgActividad = 'imgActividad';
  static String imgActividad1 = 'imgActividad1';
  static String imgActividad2 = 'imgActividad2';
  static String imgActividad3 = 'imgActividad3';
  static String imgActividad4 = 'imgActividad4';
  static String problemaIdentificado = 'problemaIdentificado';
  static String idProblemaIdentificado = 'idProblemaIdentificado';
  static String imgProblema = 'imgProblema';
  static String imgProblema1 = 'imgProblema1';
  static String imgProblema2 = 'imgProblema2';
  static String imgProblema3 = 'imgProblema3';
  static String imgProblema4 = 'imgProblema4';
  static String alternativaSolucion = 'alternativaSolucion';
  static String idAlternativaSolucion = 'idAlternativaSolucion';
  static String riesgoIdentificado = 'riesgoIdentificado';
  static String idRiesgoIdentificado = 'idRiesgoIdentificado';
  static String imgRiesgo = 'imgRiesgo';
  static String imgRiesgo1 = 'imgRiesgo1';
  static String imgRiesgo2 = 'imgRiesgo2';
  static String imgRiesgo3 = 'imgRiesgo3';
  static String imgRiesgo4 = 'imgRiesgo4';
  static String fechaTerminoEstimado = 'fechaTerminoEstimado';
  static String latitud = 'latitud';
  static String longitud = 'longitud';
  static String txtIpReg = 'txtIpReg';
  static String fechaInicio = 'fechaInicio';
  static String fechaFin = 'fechaFin';
  static String nomEstado = 'nomEstado';
  static String nivelRiesgo = 'nivelRiesgo';
  static String pageIndex = 'pageIndex';
  static String pageSize = 'pageSize';

  /*
   * Propiedades API
   */
  static String item_ = 'item';
  static String idMonitoreo_ = 'idMonitoreo';
  static String idEstadoMonitoreo_ = 'idEstadoMonitoreo';
  static String estadoMonitoreo_ = 'estadoMonitoreo';
  static String idUsuario_ = 'idUsuario';
  static String usuario_ = 'usuario';
  static String idRol_ = 'idRol';
  static String rol_ = 'rol';
  static String tambo_ = 'tambo';
  static String snip_ = 'snip';
  static String cui_ = 'cui';
  static String fechaMonitoreo_ = 'fechaMonitoreo';
  static String avanceFisicoAcumulado_ = 'avanceFisicoAcumulado';
  static String idEstadoAvance_ = 'idEstadoAvance';
  static String estadoAvance_ = 'EstadoAvance';
  static String actividadPartidaEjecutada_ = 'actividadPartidaEjecutada';
  static String idAvanceFisicoPartida_ = 'idAvanceFisicoPartida';
  static String avanceFisicoPartida_ = 'avanceFisicoPartida';
  static String observaciones_ = 'observaciones';
  static String imgActividad1_ = 'imgActividad1';
  static String imgActividad2_ = 'imgActividad2';
  static String imgActividad3_ = 'imgActividad3';
  static String problemaIdentificado_ = 'problemaIdentificado';
  static String idProblemaIdentificado_ = 'idProblemaIdentificado';
  static String imgProblema1_ = 'imgProblema1';
  static String imgProblema2_ = 'imgProblema2';
  static String imgProblema3_ = 'imgProblema3';
  static String alternativaSolucion_ = 'alternativaSolucion';
  static String idAlternativaSolucion_ = 'idAlternativaSolucion';
  static String riesgoIdentificado_ = 'riesgoIdentificado';
  static String idRiesgoIdentificado_ = 'idRiesgoIdentificado';
  static String imgRiesgo1_ = 'imgRiesgo1';
  static String imgRiesgo2_ = 'imgRiesgo2';
  static String imgRiesgo3_ = 'imgRiesgo3';
  static String fechaTerminoEstimado_ = 'fechaTerminoEstimado';
  static String latitud_ = 'latitud';
  static String longitud_ = 'longitud';
  static String txtIpReg_ = 'txtIpReg';
  static String fechaInicio_ = 'fechaInicio';
  static String fechaFin_ = 'fechaFin';
  static String nomEstado_ = 'nomEstado';
  static String pageIndex_ = 'pageIndex';
  static String pageSize_ = 'pageSize';

  /*
item                       -> null
idMonitoreo                -> "2153311_152549_2022-12-10"
idEstadoMonitoreo          -> 0
estadoMonitoreo            -> null
idUsuario                  -> 3026
usuario                    -> "302"
idRol                      -> 0
rol                        -> ""
tambo                      -> "COPALLIN DE ARAMANGO"
snip                       -> "259323"
cui                        -> "2178298"
fechaMonitoreo             -> "2022-11-22 00:00:00.0"
avanceFisicoAcumulado      -> 1.0
idEstadoAvance             -> 1
actividadPartidaEjecutada  -> null
avanceFisicoPartida        -> 0.0
observaciones              -> "obs"
imgActividad1              -> null
imgActividad2              -> null
imgActividad3              -> null
problemaIdentificado       -> "CALCULO INEXACTO EN DURACIÓN DE LAS TAREAS"
idProblemaIdentificado     -> 1
imgProblema1               -> "/9j/4AAQSkZJRgABAQAAAQABAAD/7QBqUGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAE0cAVoAAxslRxwCAAACAAAcAnQAOcKpIHZlcnloYWJvbGEgLSBodHRwOi8vd3d3…"
imgProblema2               -> "iVBORw0KGgoAAAANSUhEUgAABIQAAAIpCAYAAADTgOM8AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAHRaSURBVHhe7d1N…"
imgProblema3               -> "iVBORw0KGgoAAAANSUhEUgAAADkAAAA6CAIAAACF7mZ8AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAhdEVYdENyZWF0…"
alternativaSolucion        -> ""
idAlternativaSolucion      -> 0
riesgoIdentificado         -> "INCUMPLIMIENTO DE LAS CARACTERÍSTICAS DE LOS COMPONENTES"
idRiesgoIdentificado       -> 1
imgRiesgo1                 -> "JVBERi0xLjcNCiW1tbW1DQoxIDAgb2JqDQo8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFIvTGFuZyhlcy1QRSkgL1N0cnVjdFRyZWVSb290IDI3IDAgUi9NYXJrSW5m…"
imgRiesgo2                 -> "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIBAQEBAgIC…"
imgRiesgo3                 -> "/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAPAAA/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggLDAoKCwoKDBAMDAwMDAwQ…"
fechaTerminoEstimado       -> "2022-06-01 00:00:00.0"
latitud                    -> "-1"
longitud                   -> "-1654213"
txtIpReg                   -> null
fechaInicio                -> null
fechaFin                   -> null
nomEstado                  -> ""
pageIndex                  -> 0
pageSize                   -> 0
idAvanceFisicoPartida      -> 0
estadoAvance               -> "PENDIENTE ASIGNACION"
  */
}

class TramaMonitoreoModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  static const sIdEstadoPEN = 45;
  static const sEstadoPEN = 'PENDIENTE';

  static const sIdEstadoAPR = 43;
  static const sEstadoAPR = 'ENVIADO';

  static const sIdEstadoINC = 10001;
  static const sEstadoINC = 'INCOMPLETO';

  static const sIdEstadoXEN = 10002;
  static const sEstadoXEN = 'POR ENVIAR';

  static const sIdEstadoENV = 10003;
  static const sEstadoENV = 'ENVIADO';

  static final List<String> aEstadoMonitoreo = [
    '43 - APROBADO - ENVIADO',
    '44 - RECHAZADO',
    '45 - PENDIENTE',
  ];

  static const sAltSol01 = 'Solicitar modificación de Exp. Técnico';
  static const sAltSol02 = 'Gestionar reunión de coordinación con UPS';
  static const sAltSol03 = 'Modificar programación de tareas (Fast track)';
  static const sAltSol04 = 'Modificar programación de tareas (Crashing)';
  static const sAltSol05 = 'Coordinación con el núcleo ejecutor';
  static const sAltSol06 = 'Gestionar recursos adicionales';
  static const sAltSol07 = 'Coordinar reunión con asesoría legal';
  static const sAltSol08 = 'Incrementar presupuesto para saneamiento legal';
  static final List<String> aAlternativaSolucion = [
    sOptDropdownDefault,
    sAltSol01,
    sAltSol02,
    sAltSol03,
    sAltSol04,
    sAltSol05,
    sAltSol06,
    sAltSol07,
    sAltSol08,
  ];

  static const sActPartEjec01 = 'Cimentación';
  static const sActPartEjec02 = 'Muros y Columnas';
  static const sActPartEjec03 = 'Techo y Acabados';
  static const sActPartEjec04 = 'obras Exteriores';
  static const sActPartEjec05 = 'Equipamiento';
  static final List<String> aActividadPartidaEjecutada = [
    sOptDropdownDefault,
    sActPartEjec01,
    sActPartEjec02,
    sActPartEjec03,
    sActPartEjec04,
    sActPartEjec05,
  ];

  static const sEstAvan01 = 'Ejecución';
  static const sEstAvan02 = 'Reinicio';
  static const sEstAvan03 = 'Paralizado';
  static const sEstAvan04 = 'Por iniciar';
  static final List<String> aEstadoAvance = [
    sOptDropdownDefault,
    sEstAvan01,
    sEstAvan02,
    sEstAvan03,
    sEstAvan04,
  ];

  static const sProbIden01 = 'Calculo inexacto en duración de las tareas';
  static const sProbIden02 = 'Retraso en plazos establecidos en el proyecto';
  static const sProbIden03 = 'Estimación inexacta de los costos';
  static const sProbIden04 = 'Núcleo ejector no rinde gastos';
  static const sProbIden05 = 'Limitados recursos y sobre utilizados';
  static const sProbIden06 = 'Terreno con problemas de saneamiento legal';
  static const sProbIden07 = 'Sin Problema';
  static final List<String> aProblemaIdentificado = [
    sOptDropdownDefault,
    sProbIden01,
    sProbIden02,
    sProbIden03,
    sProbIden04,
    sProbIden05,
    sProbIden06,
    sProbIden07
  ];

  static const sRiesIden01 =
      'Incumplimiento de las características de los componentes';
  static const sRiesIden02 = 'Lluvias 1 deslizamientos / Clima';
  static const sRiesIden03 = 'Asignación de recursos y fondos fuera plazo';
  static const sRiesIden04 = 'Inadecuada estimación de costos';
  static const sRiesIden05 = 'Inadecuada programación';
  static const sRiesIden06 = 'Inadecuada comunicación con UPS';
  static final List<String> aRiesgoIdentificado = [
    sOptDropdownDefault,
    sRiesIden01,
    sRiesIden02,
    sRiesIden03,
    sRiesIden04,
    sRiesIden05,
    sRiesIden06,
  ];

  // static const sNivelRies01 = 'Muy Bajo';
  static const sNivelRies02 = 'Bajo';
  static const sNivelRies03 = 'Medio';
  // static const sNivelRies04 = 'Medio Alto';
  static const sNivelRies05 = 'Alto';
  // static const sNivelRies06 = 'Muy Alto';
  static final List<String> aNivelRiesgo = [
    sOptDropdownDefault,
    // sNivelRies01,
    sNivelRies02,
    sNivelRies03,
    // sNivelRies04,
    sNivelRies05,
    // sNivelRies06,
  ];

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime = null;

  String? item = '';

  ///identificador autogenerado (CUI_IDE_FechaMonitoreo)
  String? idMonitoreo = '';
  int? idEstadoMonitoreo;

  /// Estado del Registro del Monitoreo
  String? estadoMonitoreo = '';

  int? idUsuario;
  String? usuario = '';
  int? idRol;
  String? rol = '';

  /// nombre del proyecto
  String? tambo = '';

  /// Código de SNIP del proyecto
  String? snip = '';

  /// Código único del proyecto
  String? cui = '';

  /// (Obligatorio) se muestra la fecha del sistema APP por defecto (sólo lectura).
  String? fechaMonitoreo = '';

  /// (Obligatorio) % Avance Físico Estimado Acumulado: se obtiene de los datos generales del proyecto como referencia, y luego el usuario puede modificar su valor.
  double? avanceFisicoAcumulado = 0;
  int? idEstadoAvance;

  /// (Obligatorio) Estado de Avance: selección del estado.
  String? estadoAvance = '';

  /// (Obligatorio) Partida ejecutada: selección de partida
  String? actividadPartidaEjecutada = '';
  int? idAvanceFisicoPartida;

  /// % Av. Físico Acum. Partida: % Avance Físico acumulado de la partida
  double? avanceFisicoPartida = 0;

  /// Observaciones: descripción de la observación sobre la ejecución de la partida
  String? observaciones = '';

  /// (Obligatorio) Fotos de la partida ejecutada
  String? imgActividad = '';
  String? imgActividad1;
  String? imgActividad2;
  String? imgActividad3;
  String? imgActividad4 = '';

  /// (Obligatorio) Problema identificado: selección del problema identificado en la obra.
  String? problemaIdentificado = '';
  int? idProblemaIdentificado;

  /// (Opcional) Fotos del problema identificado
  String? imgProblema = '';
  String? imgProblema1;
  String? imgProblema2;
  String? imgProblema3;
  String? imgProblema4 = '';

  /// (Obligatorio) Alternativa de Solución: selección de la solución.
  String? alternativaSolucion = '';
  int? idAlternativaSolucion;

  /// (Opcional) Riesgo Identificado: selección del riesgo identificado.
  String? riesgoIdentificado = '';
  int? idRiesgoIdentificado;

  /// (Opcional) Fotos del riesgo identificado
  String? imgRiesgo = '';
  String? imgRiesgo1 = '';
  String? imgRiesgo2 = '';
  String? imgRiesgo3 = '';
  String? imgRiesgo4 = '';

  /// (Obligatorio) Fecha Termino Estimada Obra: se obtiene de los datos generales del proyecto como referencia, y luego el usuario puede modificar su valor.
  String? fechaTerminoEstimado = '';

  /// (Obligatorio) Latitud del monitoreo: si el APP está en OnLine: se debe obtener automáticamente. Si el APP está en Offline: no se muestra valor.
  String? latitud = '';

  /// (Obligatorio) Longitud del monitoreo: si el APP está en OnLine: se debe obtener automáticamente. Si el APP está en Offline: no se muestra valor.
  String? longitud = '';
  String? txtIpReg;
  String? fechaInicio;
  String? fechaFin;
  String? nomEstado;

  /// (Opcional) Nivel de Riesgo: selección del nivel de riesgo.
  String? nivelRiesgo = '';
  int? pageIndex;
  int? pageSize;

  TramaMonitoreoModel.empty() {}

  TramaMonitoreoModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.item,
    this.idMonitoreo,
    this.idEstadoMonitoreo,
    this.estadoMonitoreo,
    this.idUsuario,
    this.usuario,
    this.idRol,
    this.rol,
    this.tambo,
    this.snip,
    this.cui,
    this.fechaMonitoreo,
    this.avanceFisicoAcumulado,
    this.idEstadoAvance,
    this.estadoAvance,
    this.actividadPartidaEjecutada,
    this.idAvanceFisicoPartida,
    this.avanceFisicoPartida,
    this.observaciones,
    this.imgActividad,
    this.imgActividad1,
    this.imgActividad2,
    this.imgActividad3,
    this.imgActividad4,
    this.problemaIdentificado,
    this.idProblemaIdentificado,
    this.imgProblema,
    this.imgProblema1,
    this.imgProblema2,
    this.imgProblema3,
    this.imgProblema4,
    this.alternativaSolucion,
    this.idAlternativaSolucion,
    this.riesgoIdentificado,
    this.idRiesgoIdentificado,
    this.imgRiesgo,
    this.imgRiesgo1,
    this.imgRiesgo2,
    this.imgRiesgo3,
    this.imgRiesgo4,
    this.fechaTerminoEstimado,
    this.latitud,
    this.longitud,
    this.txtIpReg,
    this.fechaInicio,
    this.fechaFin,
    this.nomEstado,
    this.nivelRiesgo,
    this.pageIndex,
    this.pageSize,
  });

  TramaMonitoreoModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? item,
    String? idMonitoreo,
    int? idEstadoMonitoreo,
    String? estadoMonitoreo,
    int? idUsuario,
    String? usuario,
    int? idRol,
    String? rol,
    String? tambo,
    String? snip,
    String? cui,
    String? fechaMonitoreo,
    double? avanceFisicoAcumulado,
    int? idEstadoAvance,
    String? estadoAvance,
    String? actividadPartidaEjecutada,
    int? idAvanceFisicoPartida,
    double? avanceFisicoPartida,
    String? observaciones,
    String? imgActividad,
    String? imgActividad1,
    String? imgActividad2,
    String? imgActividad3,
    String? imgActividad4,
    String? problemaIdentificado,
    int? idProblemaIdentificado,
    String? imgProblema,
    String? imgProblema1,
    String? imgProblema2,
    String? imgProblema3,
    String? imgProblema4,
    String? alternativaSolucion,
    int? idAlternativaSolucion,
    String? riesgoIdentificado,
    int? idRiesgoIdentificado,
    String? imgRiesgo,
    String? imgRiesgo1,
    String? imgRiesgo2,
    String? imgRiesgo3,
    String? imgRiesgo4,
    String? fechaTerminoEstimado,
    String? latitud,
    String? longitud,
    String? txtIpReg,
    String? fechaInicio,
    String? fechaFin,
    String? nomEstado,
    String? nivelRiesgo,
    int? pageIndex,
    int? pageSize,
  }) =>
      TramaMonitoreoModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        item: item ?? this.item,
        idMonitoreo: idMonitoreo ?? this.idMonitoreo,
        idEstadoMonitoreo: idEstadoMonitoreo ?? this.idEstadoMonitoreo,
        estadoMonitoreo: estadoMonitoreo ?? this.estadoMonitoreo,
        idUsuario: idUsuario ?? this.idUsuario,
        usuario: usuario ?? this.usuario,
        idRol: idRol ?? this.idRol,
        rol: rol ?? this.rol,
        tambo: tambo ?? this.tambo,
        snip: snip ?? this.snip,
        cui: cui ?? this.cui,
        fechaMonitoreo: fechaMonitoreo ?? this.fechaMonitoreo,
        avanceFisicoAcumulado:
            avanceFisicoAcumulado ?? this.avanceFisicoAcumulado,
        idEstadoAvance: idEstadoAvance ?? this.idEstadoAvance,
        estadoAvance: estadoAvance ?? this.estadoAvance,
        actividadPartidaEjecutada:
            actividadPartidaEjecutada ?? this.actividadPartidaEjecutada,
        idAvanceFisicoPartida:
            idAvanceFisicoPartida ?? this.idAvanceFisicoPartida,
        avanceFisicoPartida: avanceFisicoPartida ?? this.avanceFisicoPartida,
        observaciones: observaciones ?? this.observaciones,
        imgActividad: imgActividad ?? this.imgActividad,
        imgActividad1: imgActividad1 ?? this.imgActividad1,
        imgActividad2: imgActividad2 ?? this.imgActividad2,
        imgActividad3: imgActividad3 ?? this.imgActividad3,
        imgActividad4: imgActividad4 ?? this.imgActividad4,
        problemaIdentificado: problemaIdentificado ?? this.problemaIdentificado,
        idProblemaIdentificado:
            idProblemaIdentificado ?? this.idProblemaIdentificado,
        imgProblema: imgProblema ?? this.imgProblema,
        imgProblema1: imgProblema1 ?? this.imgProblema1,
        imgProblema2: imgProblema2 ?? this.imgProblema2,
        imgProblema3: imgProblema3 ?? this.imgProblema3,
        imgProblema4: imgProblema4 ?? this.imgProblema4,
        alternativaSolucion: alternativaSolucion ?? this.alternativaSolucion,
        idAlternativaSolucion:
            idAlternativaSolucion ?? this.idAlternativaSolucion,
        riesgoIdentificado: riesgoIdentificado ?? this.riesgoIdentificado,
        idRiesgoIdentificado: idRiesgoIdentificado ?? this.idRiesgoIdentificado,
        imgRiesgo: imgRiesgo ?? this.imgRiesgo,
        imgRiesgo1: imgRiesgo1 ?? this.imgRiesgo1,
        imgRiesgo2: imgRiesgo2 ?? this.imgRiesgo2,
        imgRiesgo3: imgRiesgo3 ?? this.imgRiesgo3,
        imgRiesgo4: imgRiesgo4 ?? this.imgRiesgo4,
        fechaTerminoEstimado: fechaTerminoEstimado ?? this.fechaTerminoEstimado,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        txtIpReg: txtIpReg ?? this.txtIpReg,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin ?? this.fechaFin,
        nomEstado: nomEstado ?? this.nomEstado,
        nivelRiesgo: nivelRiesgo ?? this.nivelRiesgo,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
      );

  static TramaMonitoreoModel fromJson(Map<String, Object?> json) =>
      TramaMonitoreoModel(
        id: json[MonitorFields.id] as int?,
        isEdit: json[MonitorFields.isEdit] == null
            ? 0
            : json[MonitorFields.isEdit] as int,
        createdTime: json[MonitorFields.time] != null
            ? DateTime.parse(json[MonitorFields.time] as String)
            : null,
        item: _getString(json[MonitorFields.item]),
        idMonitoreo: _getString(json[MonitorFields.idMonitoreo]),
        idEstadoMonitoreo: _getInt(json[MonitorFields.idEstadoMonitoreo]),
        estadoMonitoreo: _getString(json[MonitorFields.estadoMonitoreo]),
        idUsuario: _getInt(json[MonitorFields.idUsuario]),
        usuario: _getString(json[MonitorFields.usuario]),
        idRol: _getInt(json[MonitorFields.idRol]),
        rol: _getString(json[MonitorFields.rol]),
        tambo: _getString(json[MonitorFields.tambo]),
        snip: _getString(json[MonitorFields.snip]),
        cui: _getString(json[MonitorFields.cui]),
        fechaMonitoreo: _getString(json[MonitorFields.fechaMonitoreo]),
        avanceFisicoAcumulado:
            _getDouble(json[MonitorFields.avanceFisicoAcumulado]),
        idEstadoAvance: _getInt(json[MonitorFields.idEstadoAvance]),
        estadoAvance: _getString(json[MonitorFields.estadoAvance]),
        actividadPartidaEjecutada:
            _getString(json[MonitorFields.actividadPartidaEjecutada]),
        idAvanceFisicoPartida:
            _getInt(json[MonitorFields.idAvanceFisicoPartida]),
        avanceFisicoPartida:
            _getDouble(json[MonitorFields.avanceFisicoPartida]),
        observaciones: _getString(json[MonitorFields.observaciones]),
        imgActividad: _getString(json[MonitorFields.imgActividad]),
        imgActividad1: _getString(json[MonitorFields.imgActividad1]),
        imgActividad2: _getString(json[MonitorFields.imgActividad2]),
        imgActividad3: _getString(json[MonitorFields.imgActividad3]),
        imgActividad4: _getString(json[MonitorFields.imgActividad4]),
        problemaIdentificado:
            _getString(json[MonitorFields.problemaIdentificado]),
        idProblemaIdentificado:
            _getInt(json[MonitorFields.idProblemaIdentificado]),
        imgProblema: _getString(json[MonitorFields.imgProblema]),
        imgProblema1: _getString(json[MonitorFields.imgProblema1]),
        imgProblema2: _getString(json[MonitorFields.imgProblema2]),
        imgProblema3: _getString(json[MonitorFields.imgProblema3]),
        imgProblema4: _getString(json[MonitorFields.imgProblema4]),
        alternativaSolucion:
            _getString(json[MonitorFields.alternativaSolucion]),
        idAlternativaSolucion:
            _getInt(json[MonitorFields.idAlternativaSolucion]),
        riesgoIdentificado: _getString(json[MonitorFields.riesgoIdentificado]),
        idRiesgoIdentificado: _getInt(json[MonitorFields.idRiesgoIdentificado]),
        imgRiesgo: _getString(json[MonitorFields.imgRiesgo]),
        imgRiesgo1: _getString(json[MonitorFields.imgRiesgo1]),
        imgRiesgo2: _getString(json[MonitorFields.imgRiesgo2]),
        imgRiesgo3: _getString(json[MonitorFields.imgRiesgo3]),
        imgRiesgo4: _getString(json[MonitorFields.imgRiesgo4]),
        fechaTerminoEstimado:
            _getString(json[MonitorFields.fechaTerminoEstimado]),
        latitud: _getString(json[MonitorFields.latitud]),
        longitud: _getString(json[MonitorFields.longitud]),
        txtIpReg: _getString(json[MonitorFields.txtIpReg]),
        fechaInicio: _getString(json[MonitorFields.fechaInicio]),
        fechaFin: _getString(json[MonitorFields.fechaFin]),
        nomEstado: _getString(json[MonitorFields.nomEstado]),
        nivelRiesgo: _getString(json[MonitorFields.nivelRiesgo]),
        pageIndex: _getInt(json[MonitorFields.pageIndex]),
        pageSize: _getInt(json[MonitorFields.pageSize]),
      );

  Map<String, dynamic> toJson() => {
        //TramaMonitoreoFields.id: id,
        MonitorFields.isEdit: isEdit,
        //TramaMonitoreoFields.time: createdTime.toIso8601String(),

        MonitorFields.item: item,
        MonitorFields.idMonitoreo: idMonitoreo,
        MonitorFields.idEstadoMonitoreo: idEstadoMonitoreo,
        MonitorFields.estadoMonitoreo: estadoMonitoreo,
        MonitorFields.idUsuario: idUsuario,
        MonitorFields.usuario: usuario,
        MonitorFields.idRol: idRol,
        MonitorFields.rol: rol,
        MonitorFields.tambo: tambo,
        MonitorFields.snip: snip,
        MonitorFields.cui: cui,
        MonitorFields.fechaMonitoreo: fechaMonitoreo,
        MonitorFields.avanceFisicoAcumulado: avanceFisicoAcumulado,
        MonitorFields.idEstadoAvance: idEstadoAvance,
        MonitorFields.estadoAvance: estadoAvance,
        MonitorFields.actividadPartidaEjecutada: actividadPartidaEjecutada,
        MonitorFields.idAvanceFisicoPartida: idAvanceFisicoPartida,
        MonitorFields.avanceFisicoPartida: avanceFisicoPartida,
        MonitorFields.observaciones: observaciones,
        MonitorFields.imgActividad: imgActividad,
        MonitorFields.imgActividad1: imgActividad1,
        MonitorFields.imgActividad2: imgActividad2,
        MonitorFields.imgActividad3: imgActividad3,
        MonitorFields.imgActividad4: imgActividad4,
        MonitorFields.problemaIdentificado: problemaIdentificado,
        MonitorFields.idProblemaIdentificado: idProblemaIdentificado,
        MonitorFields.imgProblema: imgProblema,
        MonitorFields.imgProblema1: imgProblema1,
        MonitorFields.imgProblema2: imgProblema2,
        MonitorFields.imgProblema3: imgProblema3,
        MonitorFields.imgProblema4: imgProblema4,
        MonitorFields.alternativaSolucion: alternativaSolucion,
        MonitorFields.idAlternativaSolucion: idAlternativaSolucion,
        MonitorFields.riesgoIdentificado: riesgoIdentificado,
        MonitorFields.idRiesgoIdentificado: idRiesgoIdentificado,
        MonitorFields.imgRiesgo: imgRiesgo,
        MonitorFields.imgRiesgo1: imgRiesgo1,
        MonitorFields.imgRiesgo2: imgRiesgo2,
        MonitorFields.imgRiesgo3: imgRiesgo3,
        MonitorFields.imgRiesgo4: imgRiesgo4,
        MonitorFields.fechaTerminoEstimado: fechaTerminoEstimado,
        MonitorFields.latitud: latitud,
        MonitorFields.longitud: longitud,
        MonitorFields.txtIpReg: txtIpReg,
        MonitorFields.fechaInicio: fechaInicio,
        MonitorFields.fechaFin: fechaFin,
        MonitorFields.nomEstado: nomEstado,
        MonitorFields.nivelRiesgo: nivelRiesgo,
        //MonitorFields.pageIndex: pageIndex,
        //MonitorFields.pageSize: pageSize,
      };

  static Map<String, dynamic> toJsonObject(TramaMonitoreoModel o) {
    return {
      MonitorFields.item: o.item,
      MonitorFields.idMonitoreo: o.idMonitoreo,
      MonitorFields.idEstadoMonitoreo: o.idEstadoMonitoreo,
      MonitorFields.estadoMonitoreo: o.estadoMonitoreo,
      MonitorFields.idUsuario: o.idUsuario,
      MonitorFields.usuario: o.usuario,
      MonitorFields.idRol: o.idRol,
      MonitorFields.rol: o.rol,
      MonitorFields.tambo: o.tambo,
      MonitorFields.snip: o.snip,
      MonitorFields.cui: o.cui,
      MonitorFields.fechaMonitoreo: o.fechaMonitoreo,
      MonitorFields.avanceFisicoAcumulado: o.avanceFisicoAcumulado,
      MonitorFields.idEstadoAvance: o.idEstadoAvance,
      MonitorFields.estadoAvance: o.estadoAvance,
      MonitorFields.actividadPartidaEjecutada: o.actividadPartidaEjecutada,
      MonitorFields.idAvanceFisicoPartida: o.idAvanceFisicoPartida,
      MonitorFields.avanceFisicoPartida: o.avanceFisicoPartida,
      MonitorFields.observaciones: o.observaciones,
      MonitorFields.imgActividad: o.imgActividad,
      MonitorFields.imgActividad1: o.imgActividad1,
      MonitorFields.imgActividad2: o.imgActividad2,
      MonitorFields.imgActividad3: o.imgActividad3,
      MonitorFields.imgActividad4: o.imgActividad4,
      MonitorFields.problemaIdentificado: o.problemaIdentificado,
      MonitorFields.idProblemaIdentificado: o.idProblemaIdentificado,
      MonitorFields.imgProblema: o.imgProblema,
      MonitorFields.imgProblema1: o.imgProblema1,
      MonitorFields.imgProblema2: o.imgProblema2,
      MonitorFields.imgProblema3: o.imgProblema3,
      MonitorFields.imgProblema4: o.imgProblema4,
      MonitorFields.alternativaSolucion: o.alternativaSolucion,
      MonitorFields.idAlternativaSolucion: o.idAlternativaSolucion,
      MonitorFields.riesgoIdentificado: o.riesgoIdentificado,
      MonitorFields.idRiesgoIdentificado: o.idRiesgoIdentificado,
      MonitorFields.imgRiesgo: o.imgRiesgo,
      MonitorFields.imgRiesgo1: o.imgRiesgo1,
      MonitorFields.imgRiesgo2: o.imgRiesgo2,
      MonitorFields.imgRiesgo3: o.imgRiesgo3,
      MonitorFields.imgRiesgo4: o.imgRiesgo4,
      MonitorFields.fechaTerminoEstimado: o.fechaTerminoEstimado,
      MonitorFields.latitud: o.latitud,
      MonitorFields.longitud: o.longitud,
      MonitorFields.txtIpReg: o.txtIpReg,
      MonitorFields.fechaInicio: o.fechaInicio,
      MonitorFields.fechaFin: o.fechaFin,
      MonitorFields.nomEstado: o.nomEstado,
      MonitorFields.nivelRiesgo: o.nivelRiesgo,
      //MonitorFields.pageIndex: o.pageIndex,
      //MonitorFields.pageSize: o.pageSize,
    };
  }

  static Map<String, String> toJsonObjectApi(TramaMonitoreoModel o) {
    return {
// MonitorFields.item_: _getString(o.item),
      MonitorFields.idMonitoreo_: _getString(o.idMonitoreo),
// MonitorFields.idEstadoMonitoreo_: _getString(o.idEstadoMonitoreo),
      MonitorFields.estadoMonitoreo_: _getString(o.estadoMonitoreo),
      MonitorFields.idUsuario_: _getString(o.idUsuario, type: 'I'),
      MonitorFields.usuario_: _getString(o.usuario),
// MonitorFields.idRol_: _getString(o.idRol),
      MonitorFields.rol_: _getString(o.rol),
      MonitorFields.tambo_: _getString(o.tambo),
      MonitorFields.snip_: _getString(o.snip),
      MonitorFields.cui_: _getString(o.cui),
      MonitorFields.fechaMonitoreo_: _getString(o.fechaMonitoreo),
      MonitorFields.avanceFisicoAcumulado_: _getString(o.avanceFisicoAcumulado),
// MonitorFields.idEstadoAvance_: _getString(o.idEstadoAvance),
      MonitorFields.estadoAvance_: _getString(o.estadoAvance),
      MonitorFields.actividadPartidaEjecutada_:
          _getString(o.actividadPartidaEjecutada),
// MonitorFields.idAvanceFisicoPartida_: _getString(o.idAvanceFisicoPartida, type: 'I'),
      MonitorFields.avanceFisicoPartida_: _getString(o.avanceFisicoPartida),
      MonitorFields.observaciones_: _getString(o.observaciones),
// MonitorFields.imgActividad1_: _getString(o.imgActividad1),
// MonitorFields.imgActividad2_: _getString(o.imgActividad2),
// MonitorFields.imgActividad3_: _getString(o.imgActividad3),
      MonitorFields.problemaIdentificado_: _getString(o.problemaIdentificado),
// MonitorFields.idProblemaIdentificado_: _getString(o.idProblemaIdentificado),
// MonitorFields.imgProblema1_: _getString(o.imgProblema1),
// MonitorFields.imgProblema2_: _getString(o.imgProblema2),
// MonitorFields.imgProblema3_: _getString(o.imgProblema3),
      MonitorFields.alternativaSolucion_: _getString(o.alternativaSolucion),
// MonitorFields.idAlternativaSolucion_: _getString(o.idAlternativaSolucion),
      MonitorFields.riesgoIdentificado_: _getString(o.riesgoIdentificado),
// MonitorFields.idRiesgoIdentificado_: _getString(o.idRiesgoIdentificado),
// MonitorFields.imgRiesgo1_: _getString(o.imgRiesgo1),
// MonitorFields.imgRiesgo2_: _getString(o.imgRiesgo2),
// MonitorFields.imgRiesgo3_: _getString(o.imgRiesgo3),
      MonitorFields.fechaTerminoEstimado_: _getString(o.fechaTerminoEstimado),
      MonitorFields.latitud_: _getString(o.latitud),
      MonitorFields.longitud_: _getString(o.longitud),
// MonitorFields.txtIpReg_: _getString(o.txtIpReg),
// MonitorFields.fechaInicio_: _getString(o.fechaInicio),
// MonitorFields.fechaFin_: _getString(o.fechaFin),
// MonitorFields.nomEstado_: _getString(o.nomEstado),
// MonitorFields.pageIndex_: _getString(o.pageIndex),
// MonitorFields.pageSize_: _getString(o.pageSize),
    };
  }

  /*
   * POST: .../insertarMonitoreo
   */
  static Map<String, String> toJsonObjectApi2(TramaMonitoreoModel o) {
    return {
      MonitorFields.idMonitoreo_: _getString(o.idMonitoreo),
      MonitorFields.idEstadoMonitoreo_:
          _getString(o.idEstadoMonitoreo, type: 'I'),
      MonitorFields.idUsuario_: _getString(o.idUsuario, type: 'I'),
      MonitorFields.usuario_: _getString(o.usuario),
      MonitorFields.idRol_: _getString(o.idRol, type: 'I'),
      MonitorFields.tambo_: _getString(o.tambo),
      MonitorFields.snip_: _getString(o.snip),
      MonitorFields.cui_: _getString(o.cui),
      MonitorFields.fechaMonitoreo_: _getString(o.fechaMonitoreo),
      MonitorFields.avanceFisicoAcumulado_: _getString(o.avanceFisicoAcumulado),
      MonitorFields.idEstadoAvance_: _getString(o.idEstadoAvance, type: 'I'),
      MonitorFields.observaciones_: _getString(o.observaciones),
      MonitorFields.idProblemaIdentificado_:
          _getString(o.idProblemaIdentificado, type: 'I'),
      MonitorFields.idAlternativaSolucion_:
          _getString(o.idAlternativaSolucion, type: 'I'),
      MonitorFields.idRiesgoIdentificado_:
          _getString(o.idRiesgoIdentificado, type: 'I'),
      MonitorFields.fechaTerminoEstimado_: _getString(o.fechaTerminoEstimado),
      MonitorFields.latitud_: _getString(o.latitud),
      MonitorFields.longitud_: _getString(o.longitud),
      MonitorFields.txtIpReg_: _getString(o.txtIpReg),
    };
  }

  /*
   * POST: .../registrarAvanceAcumuladoPartidaMonitereoMovil
   */
  static Map<String, String> toJsonObjectApi4(TramaMonitoreoModel o) {
    return {
      MonitorFields.idMonitoreo_: _getString(o.idMonitoreo),
      MonitorFields.idAvanceFisicoPartida: _getString(o.idAvanceFisicoPartida),
      MonitorFields.avanceFisicoAcumulado_:
          _getString(o.avanceFisicoAcumulado, type: 'D'),
      MonitorFields.snip: _getString(o.snip),
      MonitorFields.idUsuario_: _getString(o.idUsuario, type: 'I'),
      MonitorFields.txtIpReg_: _getString(o.txtIpReg),
    };
  }

  static Map<String, dynamic> toJsonObjectApi3(TramaMonitoreoModel o) {
    return {
      MonitorFields.snip_: _getString(o.snip),
      MonitorFields.pageIndex_: 1,
      MonitorFields.pageSize_: 100,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TramaMonitoreoModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(TramaMonitoreoModel.toJsonObject(item));
    }
    return aList;
  }

  List<TramaMonitoreoModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<TramaMonitoreoModel>.from(
        jsonData.map((x) => TramaMonitoreoModel.fromJson(x)));
  }

  String userToJson(List<TramaMonitoreoModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }

  static String _getString(dynamic data, {String? type}) {
    String resp = data != null ? data.toString() : '';
    if (type != null && type == "I") {
      if (resp == '') resp = '0';
    } else if (type != null && type == "D") {
      if (resp == '') resp = '0.00';
    }

    return resp;
  }

  static DateTime _getDateTime(dynamic data) {
    return data != null ? DateTime.parse(data as String) : DateTime.now();
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
