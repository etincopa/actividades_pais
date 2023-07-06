import 'dart:convert';

String tableNameRegistroActividadEntidad = 'listar_registro_actividad_entidad';

class RegistroEntidadActividadFields {
  static final List<String> values = [
    id,
    isEdit,
    time,
    categoria,
    idRegistroEntidadesYActividades,
    idProgramacionIntervenciones,
    tambo,
    distrito,
    provincia,
    departamento,
    fecha,
    horaInicio,
    horaFin,
    descripcion,
    descripcionDeLaActividadProgramada,
    programa,
    sector,
    servicio,
    subCategoria,
    tipoActividad,
    tipoDeUsuario,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';
  static String categoria = 'categoria';
  static String idRegistroEntidadesYActividades =
      'idRegistroEntidadesYActividades';
  static String idProgramacionIntervenciones = 'idProgramacionIntervenciones';
  static String tambo = 'tambo';
  static String distrito = 'distrito';
  static String provincia = 'provincia';
  static String departamento = 'departamento';
  static String fecha = 'fecha';
  static String horaInicio = 'horaInicio';
  static String horaFin = 'horaFin';
  static String descripcion = 'descripcion';
  static String descripcionDeLaActividadProgramada =
      'descripcionDeLaActividadProgramada';
  static String programa = 'programa';
  static String sector = 'sector';
  static String servicio = 'servicio';
  static String subCategoria = 'subCategoria';
  static String tipoActividad = 'tipoActividad';
  static String tipoDeUsuario = 'tipoDeUsuario';
}

class RegistroEntidadActividadModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime;

  String? idRegistroEntidadesYActividades = '';
  String? idProgramacionIntervenciones = '';
  String? tambo = '';
  String? distrito = '';
  String? provincia = '';
  String? departamento = '';
  String? fecha = '';
  String? horaInicio = '';
  String? horaFin = '';
  String? descripcion = '';
  String? categoria = '';
  String? descripcionDeLaActividadProgramada = '';
  String? programa = '';
  String? sector = '';
  String? servicio = '';
  String? subCategoria = '';
  String? tipoActividad = '';
  String? tipoDeUsuario = '';

  RegistroEntidadActividadModel.empty();

  RegistroEntidadActividadModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.categoria,
    this.descripcionDeLaActividadProgramada,
    this.idRegistroEntidadesYActividades,
    this.idProgramacionIntervenciones,
    this.tambo,
    this.distrito,
    this.provincia,
    this.departamento,
    this.fecha,
    this.horaInicio,
    this.horaFin,
    this.descripcion,
    this.programa,
    this.sector,
    this.servicio,
    this.subCategoria,
    this.tipoActividad,
    this.tipoDeUsuario,
  });

  RegistroEntidadActividadModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? categoria,
    String? descripcionDeLaActividadProgramada,
    String? idRegistroEntidadesYActividades,
    String? idProgramacionIntervenciones,
    String? tambo,
    String? distrito,
    String? provincia,
    String? departamento,
    String? fecha,
    String? horaInicio,
    String? horaFin,
    String? descripcion,
    String? programa,
    String? sector,
    String? servicio,
    String? subCategoria,
    String? tipoActividad,
    String? tipoDeUsuario,
  }) =>
      RegistroEntidadActividadModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        categoria: categoria ?? this.categoria,
        descripcionDeLaActividadProgramada:
            descripcionDeLaActividadProgramada ??
                this.descripcionDeLaActividadProgramada,
        idRegistroEntidadesYActividades: idRegistroEntidadesYActividades ??
            this.idRegistroEntidadesYActividades,
        idProgramacionIntervenciones:
            idProgramacionIntervenciones ?? this.idProgramacionIntervenciones,
        tambo: tambo ?? this.tambo,
        distrito: distrito ?? this.distrito,
        provincia: provincia ?? this.provincia,
        departamento: departamento ?? this.departamento,
        fecha: fecha ?? this.fecha,
        horaInicio: horaInicio ?? this.horaInicio,
        horaFin: horaFin ?? this.horaFin,
        descripcion: descripcion ?? this.descripcion,
        programa: programa ?? this.programa,
        sector: sector ?? this.sector,
        servicio: servicio ?? this.servicio,
        subCategoria: subCategoria ?? this.subCategoria,
        tipoActividad: tipoActividad ?? this.tipoActividad,
        tipoDeUsuario: tipoDeUsuario ?? this.tipoDeUsuario,
      );

  static RegistroEntidadActividadModel fromJson(Map<String, Object?> json) =>
      RegistroEntidadActividadModel(
        id: json[RegistroEntidadActividadFields.id] as int?,
        isEdit: json[RegistroEntidadActividadFields.isEdit] == null
            ? 0
            : json[RegistroEntidadActividadFields.isEdit] as int,
        createdTime: json[RegistroEntidadActividadFields.time] != null
            ? DateTime.parse(
                json[RegistroEntidadActividadFields.time] as String)
            : null,
        categoria: _getString(json[RegistroEntidadActividadFields.categoria]),
        descripcionDeLaActividadProgramada: _getString(json[
            RegistroEntidadActividadFields.descripcionDeLaActividadProgramada]),
        idRegistroEntidadesYActividades: _getString(json[
            RegistroEntidadActividadFields.idRegistroEntidadesYActividades]),
        idProgramacionIntervenciones: _getString(
            json[RegistroEntidadActividadFields.idProgramacionIntervenciones]),
        tambo: _getString(json[RegistroEntidadActividadFields.tambo]),
        distrito: _getString(json[RegistroEntidadActividadFields.distrito]),
        provincia: _getString(json[RegistroEntidadActividadFields.provincia]),
        departamento:
            _getString(json[RegistroEntidadActividadFields.departamento]),
        fecha: _getString(json[RegistroEntidadActividadFields.fecha]),
        horaInicio: _getString(json[RegistroEntidadActividadFields.horaInicio]),
        horaFin: _getString(json[RegistroEntidadActividadFields.horaFin]),
        descripcion:
            _getString(json[RegistroEntidadActividadFields.descripcion]),
        programa: _getString(json[RegistroEntidadActividadFields.programa]),
        sector: _getString(json[RegistroEntidadActividadFields.sector]),
        servicio: _getString(json[RegistroEntidadActividadFields.servicio]),
        subCategoria:
            _getString(json[RegistroEntidadActividadFields.subCategoria]),
        tipoActividad:
            _getString(json[RegistroEntidadActividadFields.tipoActividad]),
        tipoDeUsuario:
            _getString(json[RegistroEntidadActividadFields.tipoDeUsuario]),
      );

  Map<String, dynamic> toJson() => {
        //ProgramacionIntervencionesFields.id: id,
        RegistroEntidadActividadFields.isEdit: isEdit,
        //ProgramacionIntervencionesFields.time: createdTime.toIso8601String(),

        RegistroEntidadActividadFields.tambo: tambo,
        RegistroEntidadActividadFields.distrito: distrito,
        RegistroEntidadActividadFields.provincia: provincia,
        RegistroEntidadActividadFields.departamento: departamento,
        RegistroEntidadActividadFields.fecha: fecha,
        RegistroEntidadActividadFields.horaInicio: horaInicio,
        RegistroEntidadActividadFields.horaFin: horaFin,
        RegistroEntidadActividadFields.descripcion: descripcion,

        RegistroEntidadActividadFields.categoria: categoria,
        RegistroEntidadActividadFields.descripcionDeLaActividadProgramada:
            descripcionDeLaActividadProgramada,
        RegistroEntidadActividadFields.idRegistroEntidadesYActividades:
            idRegistroEntidadesYActividades,
        RegistroEntidadActividadFields.idProgramacionIntervenciones:
            idProgramacionIntervenciones,
        RegistroEntidadActividadFields.programa: programa,
        RegistroEntidadActividadFields.sector: sector,
        RegistroEntidadActividadFields.servicio: servicio,
        RegistroEntidadActividadFields.subCategoria: subCategoria,
        RegistroEntidadActividadFields.tipoActividad: tipoActividad,
        RegistroEntidadActividadFields.tipoDeUsuario: tipoDeUsuario,
      };

  static Map<String, dynamic> toJsonObject(RegistroEntidadActividadModel o) {
    return {
      RegistroEntidadActividadFields.tambo: o.tambo,
      RegistroEntidadActividadFields.distrito: o.distrito,
      RegistroEntidadActividadFields.provincia: o.provincia,
      RegistroEntidadActividadFields.departamento: o.departamento,
      RegistroEntidadActividadFields.fecha: o.fecha,
      RegistroEntidadActividadFields.horaInicio: o.horaInicio,
      RegistroEntidadActividadFields.horaFin: o.horaFin,
      RegistroEntidadActividadFields.descripcion: o.descripcion,
      RegistroEntidadActividadFields.categoria: o.categoria,
      RegistroEntidadActividadFields.descripcionDeLaActividadProgramada:
          o.descripcionDeLaActividadProgramada,
      RegistroEntidadActividadFields.idRegistroEntidadesYActividades:
          o.idRegistroEntidadesYActividades,
      RegistroEntidadActividadFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones,
      RegistroEntidadActividadFields.programa: o.programa,
      RegistroEntidadActividadFields.sector: o.sector,
      RegistroEntidadActividadFields.servicio: o.servicio,
      RegistroEntidadActividadFields.subCategoria: o.subCategoria,
      RegistroEntidadActividadFields.tipoActividad: o.tipoActividad,
      RegistroEntidadActividadFields.tipoDeUsuario: o.tipoDeUsuario,
    };
  }

  static Map<String, String> toJsonObjectApi(RegistroEntidadActividadModel o) {
    return {
      RegistroEntidadActividadFields.tambo: o.tambo as String,
      RegistroEntidadActividadFields.distrito: o.distrito as String,
      RegistroEntidadActividadFields.provincia: o.provincia as String,
      RegistroEntidadActividadFields.departamento: o.departamento as String,
      RegistroEntidadActividadFields.fecha: o.fecha as String,
      RegistroEntidadActividadFields.horaInicio: o.horaInicio as String,
      RegistroEntidadActividadFields.horaFin: o.horaFin as String,
      RegistroEntidadActividadFields.descripcion: o.descripcion as String,
      RegistroEntidadActividadFields.categoria: o.categoria as String,
      RegistroEntidadActividadFields.descripcionDeLaActividadProgramada:
          o.descripcionDeLaActividadProgramada as String,
      RegistroEntidadActividadFields.idRegistroEntidadesYActividades:
          o.idRegistroEntidadesYActividades as String,
      RegistroEntidadActividadFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones as String,
      RegistroEntidadActividadFields.programa: o.programa as String,
      RegistroEntidadActividadFields.sector: o.sector as String,
      RegistroEntidadActividadFields.servicio: o.servicio as String,
      RegistroEntidadActividadFields.subCategoria: o.subCategoria as String,
      RegistroEntidadActividadFields.tipoActividad: o.tipoActividad as String,
      RegistroEntidadActividadFields.tipoDeUsuario: o.tipoDeUsuario as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<RegistroEntidadActividadModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(RegistroEntidadActividadModel.toJsonObject(item));
    }
    return aList;
  }

  List<RegistroEntidadActividadModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<RegistroEntidadActividadModel>.from(
        jsonData.map((x) => RegistroEntidadActividadModel.fromJson(x)));
  }

  String userToJson(List<RegistroEntidadActividadModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
