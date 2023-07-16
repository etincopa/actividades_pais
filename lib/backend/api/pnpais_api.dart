import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/CCPP_model.dart';
import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/actividades_diarias.dart';
import 'package:actividades_pais/backend/model/actividades_diarias_resumen.dart';
import 'package:actividades_pais/backend/model/atencion_intervencion_beneficiario_resumen_model.dart';
import 'package:actividades_pais/backend/model/atencionesRegionResponse.dart';
import 'package:actividades_pais/backend/model/atencionesSectorialResponse.dart';
import 'package:actividades_pais/backend/model/atenciones_usuarios_total_model.dart';
import 'package:actividades_pais/backend/model/avance_metas.dart';
import 'package:actividades_pais/backend/model/cantidad_tambo_region.dart';
import 'package:actividades_pais/backend/model/categorizacion_tambos_model.dart';
import 'package:actividades_pais/backend/model/dato_jefe_ut_model.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/trama_response_api_dto.dart';
import 'package:actividades_pais/backend/model/historial_gestor_model.dart';
import 'package:actividades_pais/backend/model/historial_jefe_ut_model.dart';
import 'package:actividades_pais/backend/model/imagen_jut_model.dart';
import 'package:actividades_pais/backend/model/indicador_categorizacion_model.dart';
import 'package:actividades_pais/backend/model/indicador_internet_model.dart';
import 'package:actividades_pais/backend/model/lista_equipamiento_informatico.dart';
import 'package:actividades_pais/backend/model/lista_tambos_estado_internet.dart';
import 'package:actividades_pais/backend/model/lista_trama_monitoreo_detail.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/mantenimiento_infraestructura_model.dart';
import 'package:actividades_pais/backend/model/monitoreo_registro_partida_ejecutada_model.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/obtener_ultimo_avance_partida_model.dart';
import 'package:actividades_pais/backend/model/personal_puesto_model.dart';
import 'package:actividades_pais/backend/model/personal_tambo.dart';
import 'package:actividades_pais/backend/model/plan_mantenimiento_model.dart';
import 'package:actividades_pais/backend/model/priorizacion_model.dart';
import 'package:actividades_pais/backend/model/programacion_intervenciones_tambos_model.dart';
import 'package:actividades_pais/backend/model/programacion_mantenimiento_model.dart';
import 'package:actividades_pais/backend/model/resumen_parque_informatico.dart';
import 'package:actividades_pais/backend/model/servicios_basicos.dart';
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_combustible_model.dart';
import 'package:actividades_pais/backend/model/tambo_guardiania_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/model/tambo_no_intervencion_model.dart';
import 'package:actividades_pais/backend/model/tambo_pias_model.dart';
import 'package:actividades_pais/backend/model/tambo_ruta_model.dart';
import 'package:actividades_pais/backend/model/tambo_servicio_basico_model.dart';
import 'package:actividades_pais/backend/model/tambos_estado_internet_model.dart';
import 'package:actividades_pais/backend/model/tocken_usuarios_model.dart';
import 'package:actividades_pais/backend/model/unidad_ut_jefe_model.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

class PnPaisApi {
  final Http _http;
  final String basePathApp = "/api-pnpais/app/";
  final String basePathApp2 = "/api-pnpais/monitoreo/app/";
  final String basePathApp3 = "/api-pnpais/tambook/app/";
  final String basePathApp4 = "/api-pnpais/mapa/app/";

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi(this._http);

  Future<HttpResponse<List<UserModel>>> listarUsuariosApp() async {
    return await _http.request<List<UserModel>>(
      '${basePathApp}listarUsuariosApp',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaProyectoModel>>> listarTramaProyecto() async {
    return await _http.request<List<TramaProyectoModel>>(
      '${basePathApp}listarTramaproyecto',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TramaProyectoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ComboItemModel>>> listarMaestra(String sType) async {
    return await _http.request<List<ComboItemModel>>(
      '${basePathApp2}listadoComboMonitoreo/$sType',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => ComboItemModel.fromJson_(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaMonitoreoModel>>> listarTramaMonitoreo() async {
    return await _http.request<List<TramaMonitoreoModel>>(
      '${basePathApp}listarTramaMonitoreo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<UltimoAvancePartidaModel>>>
      obtenerUltimoAvancePartida() async {
    return await _http.request<List<UltimoAvancePartidaModel>>(
      '${basePathApp3}obtenerUltimoAvancePartida',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => UltimoAvancePartidaModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TramaMonitoreoModel>>>
      listarTramaMonitoreoMovilPaginado(
    TramaMonitoreoModel oBody,
  ) async {
    return await _http.request<List<TramaMonitoreoModel>>(
      '${basePathApp2}listarTramaMonitoreoMovilPaginado',
      method: "POST",
      data: TramaMonitoreoModel.toJsonObjectApi3(oBody),
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TramaRespApiDto>> insertProgramaIntervencion({
    required ProgramacionActividadModel oBody,
  }) async {
    List<Map<String, String>> aFile = [];

    if (oBody.adjuntarArchivo != '') {
      final aImgActividad = oBody.adjuntarArchivo!.split(',');
      for (var oValue in aImgActividad) {
        aFile.add({ProgramacionActividadFields.adjuntarArchivo: oValue.trim()});
      }
    }

    var prog = ProgramacionActividadModel.toJsonObjectApi(oBody);

    var aAct = (oBody.registroEntidadActividades as List)
        .map((e) => RegistroEntidadActividadModel.toJsonObjectApi(e))
        .toList();

    var aActFormat = await formDataList(
      aAct,
      ProgramacionActividadFields.registroEntidadActividades,
    );

    var oBodyFormData = {
      ...prog,
      ...aActFormat,
    };

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp}insertarProgramacionActividad',
      data: oBodyFormData,
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../insertarMonitoreo
   */
  Future<HttpResponse<TramaRespApiDto>> insertarMonitoreoP1({
    required TramaMonitoreoModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgProblema != '') {
      final aImgProblema = oBody.imgProblema!.split(',');
      for (var oValue in aImgProblema) {
        aFile.add({MonitorFields.imgProblema: oValue.trim()});
      }
    }

    if (oBody.imgRiesgo != '') {
      final aImgRiesgo = oBody.imgRiesgo!.split(',');
      for (var oValue in aImgRiesgo) {
        aFile.add({MonitorFields.imgRiesgo: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp}insertarMonitoreo',
      data: TramaMonitoreoModel.toJsonObjectApi2(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../registrarAvanceAcumuladoPartidaMonitereoMovil
   */
  Future<HttpResponse<TramaRespApiDto>> insertarMonitoreoP3({
    required TramaMonitoreoModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgActividad != '') {
      final aImgActividad = oBody.imgActividad!.split(',');
      for (var oValue in aImgActividad) {
        aFile.add({MonitorFields.imgActividad: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp2}registrarAvanceAcumuladoPartidaMonitereoMovil',
      data: TramaMonitoreoModel.toJsonObjectApi4(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../registrarAvanceAcumuladoPartidaMonitereoMovil
   */
  Future<HttpResponse<TramaRespApiDto>> insertarMonitoreoP2({
    required PartidaEjecutadaModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgPartidaEjecutada != '') {
      final aImgPartidaEjecutada = oBody.imgPartidaEjecutada!.split(',');
      for (var oValue in aImgPartidaEjecutada) {
        aFile.add({PartidaEjecutadaFld.imgPartidaEjecutada: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp2}registrarAvanceAcumuladoPartidaMonitereoMovil',
      data: PartidaEjecutadaModel.toJsonObjectApi4(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  Future<Map<String, String>> formDataList(
    List<Map<String, String>> a,
    String field,
  ) async {
    var index = 0;
    Map<String, String> mapFormData = {};
    for (var o in a) {
      o.forEach((key, value) {
        mapFormData.putIfAbsent('$field[$index].$key', () => value);
      });
      index++;
    }

    return mapFormData;
  }

  Future<HttpResponse<List<BuscarTamboDto>>> searchTambo(
    String? palabra,
  ) async {
    var sFilter = palabra != null ? '/$palabra' : '/';
    return await _http.request<List<BuscarTamboDto>>(
      '${basePathApp3}buscarTamboOrGestor$sFilter',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => BuscarTamboDto.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<MetasTamboModel>>> getMetasTambo(
    String? numSnip,
    String? anio,
    int? xMes,
  ) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.year}";

    var sNumSnip = numSnip != null ? '/$numSnip' : '/';
    var sAnio = anio != null ? '/$anio' : '/$dateStr';
    var sXMes = xMes != null ? '/$xMes' : '/0';

    return await _http.request<List<MetasTamboModel>>(
      '${basePathApp3}obtenerMetasTambo$sNumSnip$sAnio$sXMes',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => MetasTamboModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<DatosJUTTamboModel>>> getDatosJUTTambo(
    String? numSnip,
  ) async {
    var sNumSnip = numSnip != null ? '/$numSnip' : '';

    return await _http.request<List<DatosJUTTamboModel>>(
      '${basePathApp3}obtenerDatosJUT$sNumSnip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => DatosJUTTamboModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<HistorialJUTModel>>> getHistorialJUT(
    String? ut,
  ) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.year}";

    var sut = ut != null ? '/$ut' : '';

    return await _http.request<List<HistorialJUTModel>>(
      '${basePathApp3}obtenerHistorialJUT$sut',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => HistorialJUTModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<UnidadTerritorialModel>>> getUnidadTerritorial(
    String? ut,
  ) async {
    var sut = ut != null ? '/$ut' : '';

    return await _http.request<List<UnidadTerritorialModel>>(
      '${basePathApp3}obtenerUTJUT$sut',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => UnidadTerritorialModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<SinIntervencionModel>>> getSinIntervencion(
    String? sOpcion,
  ) async {
    return await _http.request<List<SinIntervencionModel>>(
      '${basePathApp3}obtenerTambosNoIntervenciones/$sOpcion',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => SinIntervencionModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<CombustibleTamboModel>>> getCombustibleTambo(
    String? idUnidadTerritorial,
    String? idTambo,
    String? idTipoPlataforma,
    String? iPagina,
    String? iNumPagina,
  ) async {
    return await _http.request<List<CombustibleTamboModel>>(
      '${basePathApp3}CuadroControlSaldoDisponible/$idUnidadTerritorial/$idTambo/$idTipoPlataforma/$iPagina/$iNumPagina',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => CombustibleTamboModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<AtenInterBeneResumenModel>>> getAtenInterBeneResumen(
    String? numSnip,
  ) async {
    return await _http.request<List<AtenInterBeneResumenModel>>(
      '${basePathApp3}atencionIntervencionBeneficiarioResumen/$numSnip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => AtenInterBeneResumenModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<GuardianiaTamboModel>>> getGuardianiaTambo(
      String? numSnip) async {
    var sNumSnip = numSnip != null ? '/$numSnip' : '';

    return await _http.request<List<GuardianiaTamboModel>>(
      '${basePathApp3}obtenerGuardianiaTambo$sNumSnip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => GuardianiaTamboModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<RutaTamboModel>>> getRutaTambo(
      String? numSnip) async {
    var sNumSnip = numSnip != null ? '/$numSnip' : '';
    return await _http.request<List<RutaTamboModel>>(
      '${basePathApp4}consultaRutastambo$sNumSnip',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => RutaTamboModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<ImagenJUTModel>>> obtenerImagenJUT(
      String? numSnip) async {
    var sNumSnip = numSnip != null ? '/$numSnip' : '';
    return await _http.request<List<ImagenJUTModel>>(
      '${basePathApp3}obtenerImagenJUT$sNumSnip',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => ImagenJUTModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<PlanMantenimientoModel>>> getPlanMantenimiento(
      String? idRegion) async {
    return await _http.request<List<PlanMantenimientoModel>>(
      '${basePathApp3}obtenerMantenimientoParqueInformatico/$idRegion',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => PlanMantenimientoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<PlanMantenimientoInfraestructuraModel>>>
      getPlanMantenimientoInfraestructura(String? snip) async {
    return await _http.request<List<PlanMantenimientoInfraestructuraModel>>(
      '${basePathApp3}obtenerPlanMantenimientoInfraestructura/$snip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => PlanMantenimientoInfraestructuraModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<PersonalPuestoModel>>> getPersonalPuesto() async {
    return await _http.request<List<PersonalPuestoModel>>(
      '${basePathApp3}cantidadporPuestoUsuario/ALL',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => PersonalPuestoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<PriorizacionModel>>> getPriorizacion(
      String? idTambo) async {
    return await _http.request<List<PriorizacionModel>>(
      '${basePathApp3}obtenerEstadoPriorizacion/$idTambo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => PriorizacionModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ServicioBasicoTamboModel>>> getServicioBasicoTambo(
      String? idTambo) async {
    var sidTambo = idTambo != null ? '/$idTambo' : '';
    return await _http.request<List<ServicioBasicoTamboModel>>(
      '${basePathApp3}listarServicioBasicoTambo$sidTambo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ServicioBasicoTamboModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<HistorialGestorModel>>> getHistorialGestor(
      String? snip) async {
    return await _http.request<List<HistorialGestorModel>>(
      '${basePathApp3}obtenerHistorialGestores/$snip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => HistorialGestorModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<AvanceMetasModel>>> getAvanceMetasMensualizada(
      String anio) async {
    return await _http.request<List<AvanceMetasModel>>(
      '${basePathApp3}obtenerEjecucionMetasMensualizadoAnio/$anio',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => AvanceMetasModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<AtencionesSectorialesModel>>> getReporteSectorial(
      String tipo, String anio, String mes, String sector) async {
    return await _http.request<List<AtencionesSectorialesModel>>(
      '${basePathApp3}obtenerReporteSectorialAtenciones/$tipo/$anio/$mes/$sector',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => AtencionesSectorialesModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<AtencionesRegionModel>>> getReporteAtencionesRegion(
      String anio, String mes, String region) async {
    return await _http.request<List<AtencionesRegionModel>>(
      '${basePathApp3}obtenerReporteAtencionesRegion/$anio/$mes/$region',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => AtencionesRegionModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<IndicadorInternetModel>>> getIndicadorInternet(
      String itTipo) async {
    return await _http.request<List<IndicadorInternetModel>>(
      '${basePathApp3}obtenerTambosTipoProveedorInternet/$itTipo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => IndicadorInternetModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ListaTambosEstadoInternetModel>>>
      getListaTambosEstadoInternet(String idEstado) async {
    return await _http.request<List<ListaTambosEstadoInternetModel>>(
      '${basePathApp3}obtenerTambosEstadoInternet/$idEstado',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ListaTambosEstadoInternetModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TambosEstadoInternetModel>>>
      getIndicadorEstadoInternet() async {
    return await _http.request<List<TambosEstadoInternetModel>>(
      '${basePathApp3}obtenerCantidadTambosPorEstadoInternet',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TambosEstadoInternetModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<IndicadorCategorizacionModel>>>
      getIndicadorCategorizacion(String itTipo) async {
    return await _http.request<List<IndicadorCategorizacionModel>>(
      '${basePathApp3}obtenerTambosTipoCategorizacion/$itTipo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => IndicadorCategorizacionModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ServiciosBasicosResumenModel>>>
      getIndicadorResumenServiciosBasicos(String opcion, String tipo) async {
    return await _http.request<List<ServiciosBasicosResumenModel>>(
      '${basePathApp3}obtenerTipoServicioBasicoAguaLuz/$opcion/$tipo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ServiciosBasicosResumenModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<CategorizacionTambosModel>>> getCategorizacionTambos(
      String itTipo) async {
    return await _http.request<List<CategorizacionTambosModel>>(
      '${basePathApp3}obtenerTambosTipoCategorizacion/$itTipo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => CategorizacionTambosModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<PersonalTambo>>> getPersonalPuestoTambo(
    String sTipo,
  ) async {
    return await _http.request<List<PersonalTambo>>(
      '${basePathApp3}obtenerPersonalPuesto/$sTipo',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => PersonalTambo.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TamboPias>>> getCantidadTambosPIAS() async {
    return await _http.request<List<TamboPias>>(
      '${basePathApp3}obtenerCantidadTambosPIAS',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => TamboPias.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<AtencionesUsuariosTotalModel>>>
      getCantidadTotalMetas(String anio) async {
    return await _http.request<List<AtencionesUsuariosTotalModel>>(
      '${basePathApp3}obtenerEjecucionAnualTambo/$anio',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => AtencionesUsuariosTotalModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ResumenParqueInformatico>>>
      getResumenParqueInformatico() async {
    return await _http.request<List<ResumenParqueInformatico>>(
      '${basePathApp3}obtenerResumenParqueInformatico',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ResumenParqueInformatico.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<CantidadTamboRegion>>>
      getCantidadTambosRegion() async {
    return await _http.request<List<CantidadTamboRegion>>(
      '${basePathApp3}obtenerCantidadTambosRegion',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => CantidadTamboRegion.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ActividadesDiariasResumenModel>>>
      getActividadesDiariasResumen(String fecha) async {
    return await _http.request<List<ActividadesDiariasResumenModel>>(
      '${basePathApp3}obtenerActividadesDiariasTamboResumen/$fecha',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ActividadesDiariasResumenModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ActividadesDiariasModel>>> getActividadesDiarias(
      String fecha, String tipo, String idUt, String snip) async {
    return await _http.request<List<ActividadesDiariasModel>>(
      '${basePathApp3}obtenerActividadesDiariasTambo/$fecha/$tipo/$idUt/$snip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ActividadesDiariasModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<BuscarTamboDto>>> getDatosTamboGestor(
      String idTambo) async {
    return await _http.request<List<BuscarTamboDto>>(
      '${basePathApp3}buscarTamboOrGestorID/$idTambo',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => BuscarTamboDto.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<ProgramacionMantenimientoModel>>>
      getProgramacionMantenimiento(String? nomUT) async {
    return await _http.request<List<ProgramacionMantenimientoModel>>(
      '${basePathApp3}obtenerProgramacionMantenimiento/$nomUT',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ProgramacionMantenimientoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ProgIntervencionTamboModel>>> getProgIntervencion(
    String? numSnip,
    String? anio,
    String? xMes,
    String? tipo,
    String? estado,
    String? fechaInicio,
    String? fechaFin,
  ) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.year}";

    var sAnio = anio ?? dateStr;
    var sNumSnip = numSnip ?? 'X';
    var sXMes = xMes ?? 'X';
    var sTipo = tipo ?? 'X';
    var sEstado = estado ?? 'X';
    var sFechaInicio = fechaInicio ?? 'X';
    var sFechaFin = fechaFin ?? 'X';

    return await _http.request<List<ProgIntervencionTamboModel>>(
      '${basePathApp3}programacionIntervencionesTambos/$sNumSnip/$sTipo/$sEstado/$sFechaInicio/$sFechaFin/$sXMes/$sAnio',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => ProgIntervencionTamboModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TamboActividadModel>>>
      tamboIntervencionAtencionIncidencia(
    String? idTambo,
    String? idTipo,
    String? anio,
    String? numMaxRegistro,
  ) async {
    return await _http.request<List<TamboActividadModel>>(
      '${basePathApp3}tamboIntervencionAtencionIncidencia/$idTambo/$idTipo/$anio/$numMaxRegistro',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TamboActividadModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TamboModel>> tamboDatoGeneral(
    String? idtambo,
  ) async {
    return await _http.request<TamboModel>(
      '${basePathApp3}tamboDatoGeneral/$idtambo',
      method: "GET",
      parser: (data) {
        return TamboModel.fromJson(data);
      },
    );
  }

  Future<HttpResponse<RespBase64FileDto>> getBuildBase64PdfFichaTecnica(
    String idTambo,
  ) async {
    return await _http.request<RespBase64FileDto>(
      '${basePathApp3}buildBase64PdfFichaTecnica/$idTambo',
      method: "GET",
      parser: (data) {
        return RespBase64FileDto.fromJson(data);
      },
    );
  }

  Future<HttpResponse<List<TambosMapaModel>>> getTambosParaMapa() async {
    return await _http.request<List<TambosMapaModel>>(
      '${basePathApp4}listadarBandejaTambosInternet/2023/0',
      method: "GET",
      parser: (data) {
        var tambosOperativos = (data[0] as List)
            .where((o) => o['estado'] == 'PRESTA SERVICIO')
            .toList();

        return (tambosOperativos)
            .map((e) => TambosMapaModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TambosMapaModel>>> getUbicacionTambo(
      int snip) async {
    return await _http.request<List<TambosMapaModel>>(
      '${basePathApp4}listadarBandejaTambosInternet',
      method: "GET",
      parser: (data) {
        var tambosOperativos =
            (data[0] as List).where((o) => o['num_snip'] == snip).toList();

        return (tambosOperativos)
            .map((e) => TambosMapaModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<EquipamientoInformaticoModel>>>
      getEquipamientoInformatico(String snip) async {
    return await _http.request<List<EquipamientoInformaticoModel>>(
      '${basePathApp3}obtenerParqueInformatico/$snip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => EquipamientoInformaticoModel.fromJson(e))
            .toList();

        //return groupBy(equipamiento, (obj) => obj.categoria);
      },
    );
  }

  Future<HttpResponse<List<IncidentesInternetModel>>> getIncidenciasInternet(
    int snip,
  ) async {
    return await _http.request<List<IncidentesInternetModel>>(
      '${basePathApp3}tamboIncidenciaInternet/$snip/2023',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => IncidentesInternetModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<MonitoreoDetailModel>>> getMonitoreoDetail(
    int numSnip,
  ) async {
    return await _http.request<List<MonitoreoDetailModel>>(
      '${basePathApp3}ListaTramaMonitoreoDetail/$numSnip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => MonitoreoDetailModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<CCPPModel>>> getCCPP(int? numSnip) async {
    return await _http.request<List<CCPPModel>>(
      '${basePathApp}listarCcpp/${numSnip.toString()}',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => CCPPModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<TramaRespApiDto>> insertarTockenUsuario({
    required TockenUsuariosModel oBody,
  }) async {
    return await _http.request<TramaRespApiDto>(
      '${basePathApp3}agregarTockenUsuarios',
      formData: TockenUsuariosModel.toJsonObjectApi(oBody),
      method: "POST",
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  Future<HttpResponse<RespBase64FileDto>> getReporteCategorizacion(
    String categoria,
  ) async {
    return await _http.request<RespBase64FileDto>(
      '${basePathApp3}reporteCategorizaciones/$categoria',
      method: "GET",
      parser: (data) {
        return RespBase64FileDto.fromJson(data);
      },
    );
  }

  Future<HttpResponse<RespBase64FileDto>> getReporteTambosPoblacion(
    String ut,
  ) async {
    return await _http.request<RespBase64FileDto>(
      '${basePathApp3}reporteTambosPorUT/$ut',
      method: "GET",
      parser: (data) {
        return RespBase64FileDto.fromJson(data);
      },
    );
  }
}
