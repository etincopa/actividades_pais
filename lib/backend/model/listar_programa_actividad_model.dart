import 'dart:convert';

import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';

String tableNameProgramacionActividad = 'listar_programa_actividad';

class ProgramacionActividadFields {
  static final List<String> values = [
    id,
    isEdit,
    time,
    estadoProgramacion,
    idProgramacionIntervenciones,
    adjuntarArchivo,
    anio,
    convenio,
    descripcionDelEvento,
    detalleNecesidades,
    documentoQueAcreditaElEvento,
    dondeSeRealizoElEvento,
    fecha,
    horaFin,
    horaInicio,
    laIntervencionRespondeAUnConvenio,
    laIntervencionesPerteneceA,
    ndePersonasConvocadasAParticiparEnElEvento,
    nplanDeTrabajo,
    perteneceAUnPlanDeTrabajo,
    plataforma,
    progrmacionParaOtroTambio,
    tipoAccion,
    tipoPlanDeTrabajo,
    unidadTerritoria,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String estadoProgramacion = 'estadoProgramacion';
  static String programacionActividades = 'programacionActividades';
  static String accion = 'accion';
  static String tipoUsuario = 'tipoUsuario';
  static String sector = 'sector';
  static String programa = 'programa';
  static String tipoActividad = 'tipoActividad';
  static String descripcionActividad = 'descripcionActividad';
  static String articulacionOrientadaA = 'articulacionOrientadaA';

  static String idProgramacionIntervenciones = "idProgramacionIntervenciones";
  static String adjuntarArchivo = "adjuntarArchivo";
  static String anio = "anio";
  static String convenio = "convenio";
  static String descripcionDelEvento = "descripcionDelEvento";
  static String detalleNecesidades = "detalleNecesidades";
  static String documentoQueAcreditaElEvento = "documentoQueAcreditaElEvento";
  static String dondeSeRealizoElEvento = "dondeSeRealizoElEvento";
  static String fecha = "fecha";
  static String horaFin = "horaFin";
  static String horaInicio = "horaInicio";
  static String laIntervencionRespondeAUnConvenio =
      "laIntervencionRespondeAUnConvenio";
  static String laIntervencionesPerteneceA = "laIntervencionesPerteneceA";
  static String ndePersonasConvocadasAParticiparEnElEvento =
      "ndePersonasConvocadasAParticiparEnElEvento";
  static String nplanDeTrabajo = "nplanDeTrabajo";
  static String perteneceAUnPlanDeTrabajo = "perteneceAUnPlanDeTrabajo";
  static String plataforma = "plataforma";
  static String progrmacionParaOtroTambio = "progrmacionParaOtroTambio";
  static String tipoAccion = "tipoAccion";
  static String tipoPlanDeTrabajo = "tipoPlanDeTrabajo";
  static String unidadTerritoria = "unidadTerritoria";
  static String registroEntidadActividades = "registroEntidadActividades";
}

class ProgramacionActividadModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  static const sEstadoINC = 'INCOMPLETO';
  static const sEstadoPEN = 'POR ENVIAR';
  static const sEstadoENV = 'ENVIADO';
  static final List<String> aEstadoProgramacion = [
    sEstadoINC,
    sEstadoPEN,
    sEstadoENV,
  ];

  static const sprogActividadCordArticulacion = "COORDINACIÓN Y ARTICULACIÓN";
  static const sprogActividadMinitoreoSuper = "MONITOREO Y SUPERVISIÓN";
  static const sprogActividadActividadPnpais = "ACTIVIDADES PNPAIS";
  static final List<String> aProgramacionActividades = [
    sprogActividadCordArticulacion,
    sprogActividadMinitoreoSuper,
    sprogActividadActividadPnpais,
  ];

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime;

  String? idProgramacionIntervenciones = '';
  String? estadoProgramacion = '';
  String? programacionActividades = '';
  String? accion = '';
  String? tipoUsuario = '';
  String? sector = '';
  String? programa = '';
  String? tipoActividad = '';
  String? descripcionActividad = '';
  String? articulacionOrientadaA = '';
  String? fecha = '';
  String? horaInicio = '';
  String? horaFin = '';
  String? descripcionDelEvento = '';
  String? documentoQueAcreditaElEvento = '';
  String? dondeSeRealizoElEvento = '';

  /*
   * OTROS
   */

  String? adjuntarArchivo = '';
  String? anio = '';
  String? convenio = '';
  String? detalleNecesidades = '';
  String? laIntervencionRespondeAUnConvenio = '';
  String? laIntervencionesPerteneceA = '';
  String? ndePersonasConvocadasAParticiparEnElEvento = '';
  String? nplanDeTrabajo = '';
  String? perteneceAUnPlanDeTrabajo = '';
  String? plataforma = '';
  String? progrmacionParaOtroTambio = '';
  String? tipoAccion = '';
  String? tipoPlanDeTrabajo = '';
  String? unidadTerritoria = '';
  List<RegistroEntidadActividadModel>? registroEntidadActividades = [];

  ProgramacionActividadModel.empty();

  ProgramacionActividadModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.idProgramacionIntervenciones,
    this.estadoProgramacion,
    this.programacionActividades,
    this.accion,
    this.tipoUsuario,
    this.sector,
    this.programa,
    this.tipoActividad,
    this.descripcionActividad,
    this.articulacionOrientadaA,
    this.fecha,
    this.horaInicio,
    this.horaFin,
    this.descripcionDelEvento,
    this.documentoQueAcreditaElEvento,
    this.dondeSeRealizoElEvento,
    this.adjuntarArchivo,
    this.anio,
    this.convenio,
    this.detalleNecesidades,
    this.laIntervencionRespondeAUnConvenio,
    this.laIntervencionesPerteneceA,
    this.ndePersonasConvocadasAParticiparEnElEvento,
    this.nplanDeTrabajo,
    this.perteneceAUnPlanDeTrabajo,
    this.plataforma,
    this.progrmacionParaOtroTambio,
    this.tipoAccion,
    this.tipoPlanDeTrabajo,
    this.unidadTerritoria,
    this.registroEntidadActividades,
  });

  ProgramacionActividadModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? idProgramacionIntervenciones,
    String? estadoProgramacion,
    String? programacionActividades,
    String? accion,
    String? tipoUsuario,
    String? sector,
    String? programa,
    String? tipoActividad,
    String? descripcionActividad,
    String? articulacionOrientadaA,
    String? fecha,
    String? horaInicio,
    String? horaFin,
    String? descripcionDelEvento,
    String? documentoQueAcreditaElEvento,
    String? dondeSeRealizoElEvento,
    String? adjuntarArchivo,
    String? anio,
    String? convenio,
    String? detalleNecesidades,
    String? laIntervencionRespondeAUnConvenio,
    String? laIntervencionesPerteneceA,
    String? ndePersonasConvocadasAParticiparEnElEvento,
    String? nplanDeTrabajo,
    String? perteneceAUnPlanDeTrabajo,
    String? plataforma,
    String? progrmacionParaOtroTambio,
    String? tipoAccion,
    String? tipoPlanDeTrabajo,
    String? unidadTerritoria,
  }) =>
      ProgramacionActividadModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        idProgramacionIntervenciones:
            idProgramacionIntervenciones ?? this.idProgramacionIntervenciones,
        estadoProgramacion: estadoProgramacion ?? this.estadoProgramacion,
        programacionActividades:
            programacionActividades ?? this.programacionActividades,
        accion: accion ?? this.accion,
        tipoUsuario: tipoUsuario ?? this.tipoUsuario,
        sector: sector ?? this.sector,
        programa: programa ?? this.programa,
        tipoActividad: tipoActividad ?? this.tipoActividad,
        descripcionActividad: descripcionActividad ?? this.descripcionActividad,
        articulacionOrientadaA:
            articulacionOrientadaA ?? this.articulacionOrientadaA,
        fecha: fecha ?? this.fecha,
        horaInicio: horaInicio ?? this.horaInicio,
        horaFin: horaFin ?? this.horaFin,
        descripcionDelEvento: descripcionDelEvento ?? this.descripcionDelEvento,
        documentoQueAcreditaElEvento:
            documentoQueAcreditaElEvento ?? this.documentoQueAcreditaElEvento,
        dondeSeRealizoElEvento:
            dondeSeRealizoElEvento ?? this.dondeSeRealizoElEvento,
        adjuntarArchivo: adjuntarArchivo ?? this.adjuntarArchivo,
        anio: anio ?? this.anio,
        convenio: convenio ?? this.convenio,
        detalleNecesidades: detalleNecesidades ?? this.detalleNecesidades,
        laIntervencionRespondeAUnConvenio: laIntervencionRespondeAUnConvenio ??
            this.laIntervencionRespondeAUnConvenio,
        laIntervencionesPerteneceA:
            laIntervencionesPerteneceA ?? this.laIntervencionesPerteneceA,
        ndePersonasConvocadasAParticiparEnElEvento:
            ndePersonasConvocadasAParticiparEnElEvento ??
                this.ndePersonasConvocadasAParticiparEnElEvento,
        nplanDeTrabajo: nplanDeTrabajo ?? this.nplanDeTrabajo,
        perteneceAUnPlanDeTrabajo:
            perteneceAUnPlanDeTrabajo ?? this.perteneceAUnPlanDeTrabajo,
        plataforma: plataforma ?? this.plataforma,
        progrmacionParaOtroTambio:
            progrmacionParaOtroTambio ?? this.progrmacionParaOtroTambio,
        tipoAccion: tipoAccion ?? this.tipoAccion,
        tipoPlanDeTrabajo: tipoPlanDeTrabajo ?? this.tipoPlanDeTrabajo,
        unidadTerritoria: unidadTerritoria ?? this.unidadTerritoria,
      );

  static ProgramacionActividadModel fromJson(Map<String, Object?> json) =>
      ProgramacionActividadModel(
        id: json[ProgramacionActividadFields.id] as int?,
        isEdit: json[ProgramacionActividadFields.isEdit] == null
            ? 0
            : json[ProgramacionActividadFields.isEdit] as int,
        createdTime: json[ProgramacionActividadFields.time] != null
            ? DateTime.parse(json[ProgramacionActividadFields.time] as String)
            : null,
        idProgramacionIntervenciones: _getString(
            json[ProgramacionActividadFields.idProgramacionIntervenciones]),
        estadoProgramacion:
            _getString(json[ProgramacionActividadFields.estadoProgramacion]),
        programacionActividades: _getString(
            json[ProgramacionActividadFields.programacionActividades]),
        accion: _getString(json[ProgramacionActividadFields.accion]),
        tipoUsuario: _getString(json[ProgramacionActividadFields.tipoUsuario]),
        sector: _getString(json[ProgramacionActividadFields.sector]),
        programa: _getString(json[ProgramacionActividadFields.programa]),
        tipoActividad:
            _getString(json[ProgramacionActividadFields.tipoActividad]),
        descripcionActividad:
            _getString(json[ProgramacionActividadFields.descripcionActividad]),
        articulacionOrientadaA: _getString(
            json[ProgramacionActividadFields.articulacionOrientadaA]),
        fecha: _getString(json[ProgramacionActividadFields.fecha]),
        horaInicio: _getString(json[ProgramacionActividadFields.horaInicio]),
        horaFin: _getString(json[ProgramacionActividadFields.horaFin]),
        descripcionDelEvento:
            _getString(json[ProgramacionActividadFields.descripcionDelEvento]),
        documentoQueAcreditaElEvento: _getString(
            json[ProgramacionActividadFields.documentoQueAcreditaElEvento]),
        dondeSeRealizoElEvento: _getString(
            json[ProgramacionActividadFields.dondeSeRealizoElEvento]),
        adjuntarArchivo:
            _getString(json[ProgramacionActividadFields.adjuntarArchivo]),
        anio: _getString(json[ProgramacionActividadFields.anio]),
        convenio: _getString(json[ProgramacionActividadFields.convenio]),
        detalleNecesidades:
            _getString(json[ProgramacionActividadFields.detalleNecesidades]),
        laIntervencionRespondeAUnConvenio: _getString(json[
            ProgramacionActividadFields.laIntervencionRespondeAUnConvenio]),
        laIntervencionesPerteneceA: _getString(
            json[ProgramacionActividadFields.laIntervencionesPerteneceA]),
        ndePersonasConvocadasAParticiparEnElEvento: _getString(json[
            ProgramacionActividadFields
                .ndePersonasConvocadasAParticiparEnElEvento]),
        nplanDeTrabajo:
            _getString(json[ProgramacionActividadFields.nplanDeTrabajo]),
        perteneceAUnPlanDeTrabajo: _getString(
            json[ProgramacionActividadFields.perteneceAUnPlanDeTrabajo]),
        plataforma: _getString(json[ProgramacionActividadFields.plataforma]),
        progrmacionParaOtroTambio: _getString(
            json[ProgramacionActividadFields.progrmacionParaOtroTambio]),
        tipoAccion: _getString(json[ProgramacionActividadFields.tipoAccion]),
        tipoPlanDeTrabajo:
            _getString(json[ProgramacionActividadFields.tipoPlanDeTrabajo]),
        unidadTerritoria:
            _getString(json[ProgramacionActividadFields.unidadTerritoria]),
        registroEntidadActividades:
            json[ProgramacionActividadFields.registroEntidadActividades] != null
                ? parseList(
                    json[ProgramacionActividadFields.registroEntidadActividades]
                        as List<RegistroEntidadActividadModel>)
                : [],
      );

  Map<String, dynamic> toJson() => {
        //ProgramacionIntervencionesFields.id: id,
        ProgramacionActividadFields.isEdit: isEdit,
        //ProgramacionIntervencionesFields.time: createdTime.toIso8601String(),

        ProgramacionActividadFields.idProgramacionIntervenciones:
            idProgramacionIntervenciones,
        ProgramacionActividadFields.estadoProgramacion: estadoProgramacion,
        ProgramacionActividadFields.programacionActividades:
            programacionActividades,
        ProgramacionActividadFields.accion: accion,
        ProgramacionActividadFields.tipoUsuario: tipoUsuario,
        ProgramacionActividadFields.sector: sector,
        ProgramacionActividadFields.programa: programa,
        ProgramacionActividadFields.tipoActividad: tipoActividad,
        ProgramacionActividadFields.descripcionActividad: descripcionActividad,
        ProgramacionActividadFields.articulacionOrientadaA:
            articulacionOrientadaA,
        ProgramacionActividadFields.fecha: fecha,
        ProgramacionActividadFields.horaInicio: horaInicio,
        ProgramacionActividadFields.horaFin: horaFin,
        ProgramacionActividadFields.descripcionDelEvento: descripcionDelEvento,
        ProgramacionActividadFields.documentoQueAcreditaElEvento:
            documentoQueAcreditaElEvento,
        ProgramacionActividadFields.dondeSeRealizoElEvento:
            dondeSeRealizoElEvento,
        ProgramacionActividadFields.adjuntarArchivo: adjuntarArchivo,
        ProgramacionActividadFields.anio: anio,
        ProgramacionActividadFields.convenio: convenio,
        ProgramacionActividadFields.detalleNecesidades: detalleNecesidades,
        ProgramacionActividadFields.laIntervencionRespondeAUnConvenio:
            laIntervencionRespondeAUnConvenio,
        ProgramacionActividadFields.laIntervencionesPerteneceA:
            laIntervencionesPerteneceA,
        ProgramacionActividadFields.ndePersonasConvocadasAParticiparEnElEvento:
            ndePersonasConvocadasAParticiparEnElEvento,
        ProgramacionActividadFields.nplanDeTrabajo: nplanDeTrabajo,
        ProgramacionActividadFields.perteneceAUnPlanDeTrabajo:
            perteneceAUnPlanDeTrabajo,
        ProgramacionActividadFields.plataforma: plataforma,
        ProgramacionActividadFields.progrmacionParaOtroTambio:
            progrmacionParaOtroTambio,
        ProgramacionActividadFields.tipoAccion: tipoAccion,
        ProgramacionActividadFields.tipoPlanDeTrabajo: tipoPlanDeTrabajo,
        ProgramacionActividadFields.unidadTerritoria: unidadTerritoria,
      };

  static Map<String, dynamic> toJsonObject(ProgramacionActividadModel o) {
    return {
      ProgramacionActividadFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones,
      ProgramacionActividadFields.estadoProgramacion: o.estadoProgramacion,
      ProgramacionActividadFields.programacionActividades:
          o.programacionActividades,
      ProgramacionActividadFields.accion: o.accion,
      ProgramacionActividadFields.tipoUsuario: o.tipoUsuario,
      ProgramacionActividadFields.sector: o.sector,
      ProgramacionActividadFields.programa: o.programa,
      ProgramacionActividadFields.tipoActividad: o.tipoActividad,
      ProgramacionActividadFields.descripcionActividad: o.descripcionActividad,
      ProgramacionActividadFields.articulacionOrientadaA:
          o.articulacionOrientadaA,
      ProgramacionActividadFields.fecha: o.fecha,
      ProgramacionActividadFields.horaInicio: o.horaInicio,
      ProgramacionActividadFields.horaFin: o.horaFin,
      ProgramacionActividadFields.descripcionDelEvento: o.descripcionDelEvento,
      ProgramacionActividadFields.documentoQueAcreditaElEvento:
          o.documentoQueAcreditaElEvento,
      ProgramacionActividadFields.dondeSeRealizoElEvento:
          o.dondeSeRealizoElEvento,
      ProgramacionActividadFields.adjuntarArchivo: o.adjuntarArchivo,
      ProgramacionActividadFields.anio: o.anio,
      ProgramacionActividadFields.convenio: o.convenio,
      ProgramacionActividadFields.detalleNecesidades: o.detalleNecesidades,
      ProgramacionActividadFields.laIntervencionRespondeAUnConvenio:
          o.laIntervencionRespondeAUnConvenio,
      ProgramacionActividadFields.laIntervencionesPerteneceA:
          o.laIntervencionesPerteneceA,
      ProgramacionActividadFields.ndePersonasConvocadasAParticiparEnElEvento:
          o.ndePersonasConvocadasAParticiparEnElEvento,
      ProgramacionActividadFields.nplanDeTrabajo: o.nplanDeTrabajo,
      ProgramacionActividadFields.perteneceAUnPlanDeTrabajo:
          o.perteneceAUnPlanDeTrabajo,
      ProgramacionActividadFields.plataforma: o.plataforma,
      ProgramacionActividadFields.progrmacionParaOtroTambio:
          o.progrmacionParaOtroTambio,
      ProgramacionActividadFields.tipoAccion: o.tipoAccion,
      ProgramacionActividadFields.tipoPlanDeTrabajo: o.tipoPlanDeTrabajo,
      ProgramacionActividadFields.unidadTerritoria: o.unidadTerritoria,
    };
  }

  static Map<String, String> toJsonObjectApi(ProgramacionActividadModel o) {
    return {
      ProgramacionActividadFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones as String,
      ProgramacionActividadFields.estadoProgramacion:
          o.estadoProgramacion as String,
      ProgramacionActividadFields.programacionActividades:
          o.programacionActividades as String,
      ProgramacionActividadFields.accion: o.accion as String,
      ProgramacionActividadFields.tipoUsuario: o.tipoUsuario as String,
      ProgramacionActividadFields.sector: o.sector as String,
      ProgramacionActividadFields.programa: o.programa as String,
      ProgramacionActividadFields.tipoActividad: o.tipoActividad as String,
      ProgramacionActividadFields.descripcionActividad:
          o.descripcionActividad as String,
      ProgramacionActividadFields.articulacionOrientadaA:
          o.articulacionOrientadaA as String,
      ProgramacionActividadFields.fecha: o.fecha as String,
      ProgramacionActividadFields.horaInicio: o.horaInicio as String,
      ProgramacionActividadFields.horaFin: o.horaFin as String,
      ProgramacionActividadFields.descripcionDelEvento:
          o.descripcionDelEvento as String,
      ProgramacionActividadFields.documentoQueAcreditaElEvento:
          o.documentoQueAcreditaElEvento as String,
      ProgramacionActividadFields.dondeSeRealizoElEvento:
          o.dondeSeRealizoElEvento as String,
      ProgramacionActividadFields.adjuntarArchivo: o.adjuntarArchivo as String,
      ProgramacionActividadFields.anio: o.anio as String,
      ProgramacionActividadFields.convenio: o.convenio as String,
      ProgramacionActividadFields.detalleNecesidades:
          o.detalleNecesidades as String,
      ProgramacionActividadFields.laIntervencionRespondeAUnConvenio:
          o.laIntervencionRespondeAUnConvenio as String,
      ProgramacionActividadFields.laIntervencionesPerteneceA:
          o.laIntervencionesPerteneceA as String,
      ProgramacionActividadFields.ndePersonasConvocadasAParticiparEnElEvento:
          o.ndePersonasConvocadasAParticiparEnElEvento as String,
      ProgramacionActividadFields.nplanDeTrabajo: o.nplanDeTrabajo as String,
      ProgramacionActividadFields.perteneceAUnPlanDeTrabajo:
          o.perteneceAUnPlanDeTrabajo as String,
      ProgramacionActividadFields.plataforma: o.plataforma as String,
      ProgramacionActividadFields.progrmacionParaOtroTambio:
          o.progrmacionParaOtroTambio as String,
      ProgramacionActividadFields.tipoAccion: o.tipoAccion as String,
      ProgramacionActividadFields.tipoPlanDeTrabajo:
          o.tipoPlanDeTrabajo as String,
      ProgramacionActividadFields.unidadTerritoria:
          o.unidadTerritoria as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<ProgramacionActividadModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(ProgramacionActividadModel.toJsonObject(item));
    }
    return aList;
  }

  List<ProgramacionActividadModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<ProgramacionActividadModel>.from(
        jsonData.map((x) => ProgramacionActividadModel.fromJson(x)));
  }

  String userToJson(List<ProgramacionActividadModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static List<RegistroEntidadActividadModel> parseList(List<dynamic> a) {
    if (a == null) return [];

    List<RegistroEntidadActividadModel> aListFormat = a
        .map((tagJson) => RegistroEntidadActividadModel.fromJson(tagJson))
        .toList();
    return aListFormat;
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
