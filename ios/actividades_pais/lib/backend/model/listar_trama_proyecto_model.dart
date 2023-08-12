import 'dart:convert';

String tableNameTramaProyectos = 'listar_trama_proyecto';

class TramaProyectoFields {
  static final List<String> values = [
    //// Add all fields
    id,
    isEdit,
    time,
    numSnip,
    cui,
    latitud,
    longitud,
    departamento,
    provincia,
    distrito,
    tambo,
    centroPoblado,
    estado,
    subEstado,
    estadoSaneamiento,
    modalidad,
    fechaInicio,
    fechaTerminoEstimado,
    inversion,
    costoEjecutado,
    costoEstimadoFinal,
    avanceFisico,
    residente,
    supervisor,
    crp,
    codResidente,
    codSupervisor,
    codCrp,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String numSnip = 'numSnip';
  static String cui = 'cui';
  static String latitud = 'latitud';
  static String longitud = 'longitud';
  static String departamento = 'departamento';
  static String provincia = 'provincia';
  static String distrito = 'distrito';
  static String tambo = 'tambo';
  static String centroPoblado = 'centroPoblado';
  static String estado = 'estado';
  static String subEstado = 'subEstado';
  static String estadoSaneamiento = 'estadoSaneamiento';
  static String modalidad = 'modalidad';
  static String fechaInicio = 'fechaInicio';
  static String fechaTerminoEstimado = 'fechaTerminoEstimado';
  static String inversion = 'inversion';
  static String costoEjecutado = 'costoEjecutado';
  static String costoEstimadoFinal = 'costoEstimadoFinal';
  static String avanceFisico = 'avanceFisico';
  static String residente = 'residente';
  static String supervisor = 'supervisor';
  static String crp = 'crp';
  static String codResidente = 'codResidente';
  static String codSupervisor = 'codSupervisor';
  static String codCrp = 'codCrp';
}

class TramaProyectoModel {
  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime;

  /// Código único del proyecto
  String? cui = "";

  /// Código de SNIP
  String? numSnip = "";

  /// Latitud de la ubicación del proyecto
  String? latitud = "";

  /// Longitud de la ubicación del proyecto
  String? longitud = "";

  /// Nombre del departamento del ubigeo del proyecto
  String? departamento = "";

  /// Nombre de la provincia del ubigeo del proyecto
  String? provincia = "";

  /// Nombre del distrito del ubigeo del proyecto
  String? distrito = "";

  /// nombre del proyecto
  String? tambo = "";

  //nombre del centro poblado del ubigeo del proyecto
  String? centroPoblado = "";

  /// estado del proyecto
  String? estado = "";

  /// sub estado del proyecto
  String? subEstado = "";

  /// estado de saneamiento del proyecto
  String? estadoSaneamiento = "";

  /// modalidad de contratación del proyecto
  String? modalidad = "";

  /// fecha de inicio del proyecto
  String? fechaInicio = "";

  /// fecha de término estimado del proyecto
  String? fechaTerminoEstimado = "";

  /// monto de inversión del proyecto
  String? inversion = "";

  /// costo ejecutado acumulado del proyecto
  String? costoEjecutado = "";

  /// costo estimado final del proyecto
  String? costoEstimadoFinal = "";

  /// % Avance físico acumulado
  String? avanceFisico = "";

  /// nombre del residente
  String? residente = "";

  /// nombre del supervisor
  String? supervisor = "";

  /// nombre del coordinador regional del proyecto
  String? crp = "";

  /// código del residente
  String? codResidente = "";

  /// código del supervisor
  String? codSupervisor = "";

  /// código del coordinador regional del proyecto
  String? codCrp = "";

  TramaProyectoModel.empty();

  TramaProyectoModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.numSnip,
    this.cui,
    this.latitud,
    this.longitud,
    this.departamento,
    this.provincia,
    this.distrito,
    this.tambo,
    this.centroPoblado,
    this.estado,
    this.subEstado,
    this.estadoSaneamiento,
    this.modalidad,
    this.fechaInicio,
    this.fechaTerminoEstimado,
    this.inversion,
    this.costoEjecutado,
    this.costoEstimadoFinal,
    this.avanceFisico,
    this.residente,
    this.supervisor,
    this.crp,
    this.codResidente,
    this.codSupervisor,
    this.codCrp,
  });

  TramaProyectoModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? numSnip,
    String? cui,
    String? latitud,
    String? longitud,
    String? departamento,
    String? provincia,
    String? distrito,
    String? tambo,
    String? centroPoblado,
    String? estado,
    String? subEstado,
    String? estadoSaneamiento,
    String? modalidad,
    String? fechaInicio,
    String? fechaTerminoEstimado,
    String? inversion,
    String? costoEjecutado,
    String? costoEstimadoFinal,
    String? avanceFisico,
    String? residente,
    String? supervisor,
    String? crp,
    String? codResidente,
    String? codSupervisor,
    String? codCrp,
  }) =>
      TramaProyectoModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        numSnip: numSnip ?? this.numSnip,
        cui: cui ?? this.cui,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        departamento: departamento ?? this.departamento,
        provincia: provincia ?? this.provincia,
        distrito: distrito ?? this.distrito,
        tambo: tambo ?? this.tambo,
        centroPoblado: centroPoblado ?? this.centroPoblado,
        estado: estado ?? this.estado,
        subEstado: subEstado ?? this.subEstado,
        estadoSaneamiento: estadoSaneamiento ?? this.estadoSaneamiento,
        modalidad: modalidad ?? this.modalidad,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaTerminoEstimado: fechaTerminoEstimado ?? this.fechaTerminoEstimado,
        inversion: inversion ?? this.inversion,
        costoEjecutado: costoEjecutado ?? this.costoEjecutado,
        costoEstimadoFinal: costoEstimadoFinal ?? this.costoEstimadoFinal,
        avanceFisico: avanceFisico ?? this.avanceFisico,
        residente: residente ?? this.residente,
        supervisor: supervisor ?? this.supervisor,
        crp: crp ?? this.crp,
        codResidente: codResidente ?? this.codResidente,
        codSupervisor: codSupervisor ?? this.codSupervisor,
        codCrp: codCrp ?? this.codCrp,
      );

  static TramaProyectoModel fromJson(Map<String, Object?> json) =>
      TramaProyectoModel(
        id: json[TramaProyectoFields.id] as int?,
        isEdit: json[TramaProyectoFields.isEdit] == null
            ? 0
            : json[TramaProyectoFields.isEdit] as int,
        createdTime: json[TramaProyectoFields.time] != null
            ? DateTime.parse(json[TramaProyectoFields.time] as String)
            : null,
        numSnip: json[TramaProyectoFields.numSnip] as String,
        cui: json[TramaProyectoFields.cui] as String,
        latitud: json[TramaProyectoFields.latitud] as String,
        longitud: json[TramaProyectoFields.longitud] as String,
        departamento: json[TramaProyectoFields.departamento] as String,
        provincia: json[TramaProyectoFields.provincia] as String,
        distrito: json[TramaProyectoFields.distrito] as String,
        tambo: json[TramaProyectoFields.tambo] as String,
        centroPoblado: json[TramaProyectoFields.centroPoblado] as String,
        estado: json[TramaProyectoFields.estado] as String,
        subEstado: json[TramaProyectoFields.subEstado] as String,
        estadoSaneamiento:
            json[TramaProyectoFields.estadoSaneamiento] as String,
        modalidad: json[TramaProyectoFields.modalidad] as String,
        fechaInicio: json[TramaProyectoFields.fechaInicio] as String,
        fechaTerminoEstimado:
            json[TramaProyectoFields.fechaTerminoEstimado] as String,
        inversion: json[TramaProyectoFields.inversion] as String,
        costoEjecutado: json[TramaProyectoFields.costoEjecutado] as String,
        costoEstimadoFinal:
            json[TramaProyectoFields.costoEstimadoFinal] as String,
        avanceFisico: json[TramaProyectoFields.avanceFisico] as String,
        residente: json[TramaProyectoFields.residente] as String,
        supervisor: json[TramaProyectoFields.supervisor] as String,
        crp: json[TramaProyectoFields.crp] as String,
        codResidente: json[TramaProyectoFields.codResidente] as String,
        codSupervisor: json[TramaProyectoFields.codSupervisor] as String,
        codCrp: json[TramaProyectoFields.codCrp] as String,
      );

  Map<String, dynamic> toJson() => {
        //TramaProyectoFields.id: id,
        TramaProyectoFields.isEdit: isEdit,
        //TramaProyectoFields.time: createdTime.toIso8601String(),

        TramaProyectoFields.numSnip: numSnip,
        TramaProyectoFields.cui: cui,
        TramaProyectoFields.latitud: latitud,
        TramaProyectoFields.longitud: longitud,
        TramaProyectoFields.departamento: departamento,
        TramaProyectoFields.provincia: provincia,
        TramaProyectoFields.distrito: distrito,
        TramaProyectoFields.tambo: tambo,
        TramaProyectoFields.centroPoblado: centroPoblado,
        TramaProyectoFields.estado: estado,
        TramaProyectoFields.subEstado: subEstado,
        TramaProyectoFields.estadoSaneamiento: estadoSaneamiento,
        TramaProyectoFields.modalidad: modalidad,
        TramaProyectoFields.fechaInicio: fechaInicio,
        TramaProyectoFields.fechaTerminoEstimado: fechaTerminoEstimado,
        TramaProyectoFields.inversion: inversion,
        TramaProyectoFields.costoEjecutado: costoEjecutado,
        TramaProyectoFields.costoEstimadoFinal: costoEstimadoFinal,
        TramaProyectoFields.avanceFisico: avanceFisico,
        TramaProyectoFields.residente: residente,
        TramaProyectoFields.supervisor: supervisor,
        TramaProyectoFields.crp: crp,
        TramaProyectoFields.codResidente: codResidente,
        TramaProyectoFields.codSupervisor: codSupervisor,
        TramaProyectoFields.codCrp: codCrp,
      };

  static Map<String, dynamic> toJsonObject(TramaProyectoModel o) {
    return {
      TramaProyectoFields.numSnip: o.numSnip,
      TramaProyectoFields.cui: o.cui,
      TramaProyectoFields.latitud: o.latitud,
      TramaProyectoFields.longitud: o.longitud,
      TramaProyectoFields.departamento: o.departamento,
      TramaProyectoFields.provincia: o.provincia,
      TramaProyectoFields.distrito: o.distrito,
      TramaProyectoFields.tambo: o.tambo,
      TramaProyectoFields.centroPoblado: o.centroPoblado,
      TramaProyectoFields.estado: o.estado,
      TramaProyectoFields.subEstado: o.subEstado,
      TramaProyectoFields.estadoSaneamiento: o.estadoSaneamiento,
      TramaProyectoFields.modalidad: o.modalidad,
      TramaProyectoFields.fechaInicio: o.fechaInicio,
      TramaProyectoFields.fechaTerminoEstimado: o.fechaTerminoEstimado,
      TramaProyectoFields.inversion: o.inversion,
      TramaProyectoFields.costoEjecutado: o.costoEjecutado,
      TramaProyectoFields.costoEstimadoFinal: o.costoEstimadoFinal,
      TramaProyectoFields.avanceFisico: o.avanceFisico,
      TramaProyectoFields.residente: o.residente,
      TramaProyectoFields.supervisor: o.supervisor,
      TramaProyectoFields.crp: o.crp,
      TramaProyectoFields.codResidente: o.codResidente,
      TramaProyectoFields.codSupervisor: o.codSupervisor,
      TramaProyectoFields.codCrp: o.codCrp,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TramaProyectoModel> aTramaProyecto) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaProyecto) {
      aList.add(TramaProyectoModel.toJsonObject(item));
    }
    return aList;
  }

  List<TramaProyectoModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<TramaProyectoModel>.from(
        jsonData.map((x) => TramaProyectoModel.fromJson(x)));
  }

  String userToJson(List<TramaProyectoModel> aTramaProyecto) {
    final dyn = List<dynamic>.from(aTramaProyecto.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
