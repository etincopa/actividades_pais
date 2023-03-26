import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/model/CCPP_model.dart';
import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/atencion_intervencion_beneficiario_resumen_model.dart';
import 'package:actividades_pais/backend/model/avance_metas.dart';
import 'package:actividades_pais/backend/model/dato_jefe_ut_model.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/historial_gestor_model.dart';
import 'package:actividades_pais/backend/model/historial_jefe_ut_model.dart';
import 'package:actividades_pais/backend/model/imagen_jut_model.dart';
import 'package:actividades_pais/backend/model/lista_equipamiento_informatico.dart';
import 'package:actividades_pais/backend/model/lista_trama_monitoreo_detail.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
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
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_combustible_model.dart';
import 'package:actividades_pais/backend/model/tambo_guardiania_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/model/tambo_ruta_model.dart';
import 'package:actividades_pais/backend/model/tambo_servicio_basico_model.dart';
import 'package:actividades_pais/backend/model/unidad_ut_jefe_model.dart';
import 'package:logger/logger.dart';

class MainRepo {
  final Logger _log = Logger();

  final DatabasePnPais _dbPnPais;
  final PnPaisApi _pnPaisApi;

  MainRepo(this._pnPaisApi, this._dbPnPais);

  Future<List<ComboItemModel>> getAllComboItemByType(
    String search,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllComboItemByType(
      search,
      limit,
      offset,
    );
  }

  Future<List<TramaProyectoModel>> getAllProyectoDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllProyecto(
      limit,
      offset,
    );
  }

  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllProyectoByUserSearch(
      o,
      search,
      limit,
      offset,
    );
  }

  Future<List<TramaProyectoModel>> getAllProyectoByNeUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllProyectoByNeUserSearch(
      o,
      search,
      limit,
      offset,
    );
  }

  Future<List<TramaProyectoModel>> getProyectoByCUI(
    String cui,
  ) async {
    return _dbPnPais.readAProyectoByCUI(cui);
  }

  Future<List<TramaMonitoreoModel>> readAllOtherMonitoreo(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllOtherMonitoreo(
      o,
      limit,
      offset,
    );
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByTypePartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    return _dbPnPais.readMonitoreoByTypePartida(o, sTypePartida);
  }

  Future<List<UltimoAvancePartidaModel>> getUltimoAvanceByProyectoAndPartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    return _dbPnPais.readUltimoAvanceByProyectoAndPartida(o, sTypePartida);
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByIdMonitor(
    String idMonitoreo,
  ) async {
    return _dbPnPais.readMonitoreoByIdMonitor(idMonitoreo);
  }

  Future<List<TramaProyectoModel>> getAllProyectoApi() async {
    List<TramaProyectoModel> oUserUp = [];
    final response = await _pnPaisApi.listarTramaProyecto();
    if (response.error == null) {
      oUserUp = response.data!;
    } else {
      _log.e(response.error.message);
    }

    return oUserUp;
  }

  Future<TramaProyectoModel> insertProyectoDb(
    TramaProyectoModel o,
  ) async {
    return await _dbPnPais.insertProyecto(o);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllMonitoreo(
      limit,
      offset,
    );
  }

  Future<List<UltimoAvancePartidaModel>> getAllAvancePartidaDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllAvancePartida(
      limit,
      offset,
    );
  }

  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviarDB(
    int? limit,
    int? offset,
    TramaProyectoModel? o,
  ) async {
    return _dbPnPais.readAllMonitoreoPorEnviar(
      limit,
      offset,
      o,
    );
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByIdProyectoDb(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllMonitoreoByIdProyecto(
      limit,
      offset,
      o,
    );
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoApi() async {
    List<TramaMonitoreoModel> aResp = [];
    final response = await _pnPaisApi.listarTramaMonitoreo();
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }

    return aResp;
  }

  Future<List<UltimoAvancePartidaModel>> obtenerUltimoAvancePartida() async {
    List<UltimoAvancePartidaModel> aResp = [];
    final response = await _pnPaisApi.obtenerUltimoAvancePartida();
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<TramaMonitoreoModel>> getTramaMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    List<TramaMonitoreoModel> aResp = [];
    final response = await _pnPaisApi.listarTramaMonitoreoMovilPaginado(o);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<PersonalPuestoModel>> getPersonalPuesto() async {
    List<PersonalPuestoModel> aResp = [];
    final response = await _pnPaisApi.getPersonalPuesto();
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<EquipamientoInformaticoModel>> getEquipamientoInformatico(
      String snip) async {
    List<EquipamientoInformaticoModel> aResp = [];
    final response = await _pnPaisApi.getEquipamientoInformatico(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<UltimoAvancePartidaModel> insertUltimoAvancePartidaDb(
    UltimoAvancePartidaModel o,
  ) async {
    return await _dbPnPais.insertUltimoAvancePartida(o);
  }

  Future<TramaMonitoreoModel> insertMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    return await _dbPnPais.insertMonitoreo(
      o,
    );
  }

  Future<ComboItemModel> insertMaestraDb(
    ComboItemModel o,
  ) async {
    return await _dbPnPais.insertMaestra(o);
  }

  Future<List<ComboItemModel>> getMaestraByType(String sType) async {
    List<ComboItemModel> aResp = [];
    final response = await _pnPaisApi.listarMaestra(sType);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }

    aResp.forEach((x) => {x.idTypeItem = sType});

    return aResp;
  }

  Future<List<BuscarTamboDto>> searchTambo(
    String? palabra,
  ) async {
    List<BuscarTamboDto> oUserUp = [];
    final response = await _pnPaisApi.searchTambo(palabra);
    if (response.error == null) {
      oUserUp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oUserUp;
  }

  Future<RespBase64FileDto> getBuildBase64PdfFichaTecnica(
    String idTambo,
  ) async {
    RespBase64FileDto aResp = RespBase64FileDto.empty();
    final response = await _pnPaisApi.getBuildBase64PdfFichaTecnica(idTambo);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<TamboModel> tamboDatoGeneral(String idTambo) async {
    TamboModel aResp = TamboModel.empty();
    final response = await _pnPaisApi.tamboDatoGeneral(idTambo);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<TamboActividadModel>> tamboIntervencionAtencionIncidencia(
    String? idTambo,
    String? idTipo,
    String? anio,
    String? numMaxRegistro,
  ) async {
    List<TamboActividadModel> aResp = [];
    final response = await _pnPaisApi.tamboIntervencionAtencionIncidencia(
      idTambo,
      idTipo,
      anio,
      numMaxRegistro,
    );
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<ProgramacionActividadModel>> getProgramaIntervencionDb(
    String? id,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readProgramaIntervencion(
      id,
      limit,
      offset,
    );
  }

  Future<ProgramacionActividadModel> insertProgramaIntervencionDb(
    ProgramacionActividadModel o,
  ) async {
    return await _dbPnPais.insertProgramaIntervencion(o);
  }

  Future<RegistroEntidadActividadModel> insertRegistroEntidadActividadDb(
    RegistroEntidadActividadModel o,
  ) async {
    return await _dbPnPais.insertRegistroEntidadActividad(o);
  }

  Future<List<RegistroEntidadActividadModel>>
      insertRegistroEntidadActividadMasiveDb(
    List<RegistroEntidadActividadModel> a,
  ) async {
    return await _dbPnPais.insertRegistroEntidadActividadMasive(a);
  }

  Future<TramaMonitoreoModel> insertarMonitoreoApi(
    TramaMonitoreoModel o,
  ) async {
    final response = await _pnPaisApi.insertarMonitoreoP1(oBody: o);

    for (var oPartidaEjecutada in o.aPartidaEjecutada!) {
      var responseP2 =
          await _pnPaisApi.insertarMonitoreoP2(oBody: oPartidaEjecutada);
    }

    if (response.error != null) {
      _log.e(response.error.message);
      return Future.error(
        response.error.message,
      );
    }

    return o;
  }

  Future<List<PartidaEjecutadaModel>> readPartidaEjecutadaByIdMonitoreo(
    String idMonitoreo,
  ) async {
    List<PartidaEjecutadaModel> oResp =
        await _dbPnPais.readPartidaEjecutadaByIdMonitoreo(idMonitoreo);
    return oResp;
  }

  Future<ProgramacionActividadModel> insertProgramaIntervencion(
    ProgramacionActividadModel o,
  ) async {
    final response = await _pnPaisApi.insertProgramaIntervencion(oBody: o);
    if (response.error != null) {
      _log.e(response.error.message);
      return Future.error(
        response.error.message,
      );
    }

    return o;
  }

  Future<int> deleteProgramaIntervencionDb(
    ProgramacionActividadModel o,
  ) async {
    final result = await _dbPnPais.deleteProgramaIntervencionDb(o.id!);
    return result;
  }

  Future<int> deleteMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    final result = await _dbPnPais.deleteMonitoreo(o.id!);
    return result;
  }

  Future<List<UserModel>> getAllUserDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllUser(
      limit,
      offset,
    );
  }

  Future<List<UserModel>> getAllUserApi() async {
    List<UserModel> oUserUp = [];
    final response = await _pnPaisApi.listarUsuariosApp();
    if (response.error == null) {
      oUserUp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oUserUp;
  }

  Future<UserModel> readUserByCode(
    String codigo,
  ) async {
    UserModel oUser = await _dbPnPais.readUserByCode(codigo);
    return oUser;
  }

  Future<UserModel> insertUserDb(
    UserModel o,
  ) async {
    if (o.id != null && o.id! > 0) {
      o.isEdit = 1;
      await _dbPnPais.updateUser(o);
      return o;
    } else {
      return await _dbPnPais.insertUser(o);
    }
  }

  Future deleteAllData() async {
    return _dbPnPais.deleteAllData();
  }

  Future deleteAllMonitorByEstadoENV() async {
    return _dbPnPais.deleteMonitorByEstadoENV();
  }

  Future<List<TambosMapaModel>> tambosParaMapa() async {
    List<TambosMapaModel> aResp = [];
    final response = await _pnPaisApi.getTambosParaMapa();
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<IncidentesInternetModel>> indicenciasInternetTambo(
      int snip) async {
    List<IncidentesInternetModel> aResp = [];
    final response = await _pnPaisApi.getIncidenciasInternet(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<CCPPModel>> centrosPoblados(int snip) async {
    List<CCPPModel> aResp = [];
    final response = await _pnPaisApi.getCCPP(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<MetasTamboModel>> getMetasTambo(
    String? numSnip,
    String? anio,
    int? xMes,
  ) async {
    List<MetasTamboModel> aResp = [];
    final response = await _pnPaisApi.getMetasTambo(numSnip, anio, xMes);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<DatosJUTTamboModel>> getDatosJUTTambo(
    String? numSnip,
  ) async {
    List<DatosJUTTamboModel> aResp = [];
    final response = await _pnPaisApi.getDatosJUTTambo(numSnip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<HistorialJUTModel>> getHistorialJUT(
    String? ut,
  ) async {
    List<HistorialJUTModel> aResp = [];
    final response = await _pnPaisApi.getHistorialJUT(
      ut,
    );
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<UnidadTerritorialModel>> getUnidadTerritorial(
    String? ut,
  ) async {
    List<UnidadTerritorialModel> aResp = [];
    final response = await _pnPaisApi.getUnidadTerritorial(
      ut,
    );
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<CombustibleTamboModel>> getCombustibleTambo(
    String? idUnidadTerritorial,
    String? idTambo,
    String? idTipoPlataforma,
    String? iPagina,
    String? iNumPagina,
  ) async {
    List<CombustibleTamboModel> aResp = [];
    final response = await _pnPaisApi.getCombustibleTambo(
      idUnidadTerritorial,
      idTambo,
      idTipoPlataforma,
      iPagina,
      iNumPagina,
    );
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<AtenInterBeneResumenModel>> getAtenInterBeneResumen(
    String? numSnip,
  ) async {
    List<AtenInterBeneResumenModel> aResp = [];
    final response = await _pnPaisApi.getAtenInterBeneResumen(numSnip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<GuardianiaTamboModel>> getGuardianiaTambo(
    String? numSnip,
  ) async {
    List<GuardianiaTamboModel> aResp = [];
    final response = await _pnPaisApi.getGuardianiaTambo(numSnip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<RutaTamboModel>> getRutaTambo(
    String? numSnip,
  ) async {
    List<RutaTamboModel> aResp = [];
    final response = await _pnPaisApi.getRutaTambo(numSnip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<ImagenJUTModel>> obtenerImagenJUT(
    String? numSnip,
  ) async {
    List<ImagenJUTModel> aResp = [];
    final response = await _pnPaisApi.obtenerImagenJUT(numSnip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<PlanMantenimientoModel>> getPlanMantenimiento(
    String? idRegion,
  ) async {
    List<PlanMantenimientoModel> aResp = [];
    final response = await _pnPaisApi.getPlanMantenimiento(idRegion);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<PlanMantenimientoInfraestructuraModel>>
      getPlanMantenimientoInfraestructura(
    String? snip,
  ) async {
    List<PlanMantenimientoInfraestructuraModel> aResp = [];
    final response = await _pnPaisApi.getPlanMantenimientoInfraestructura(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<PriorizacionModel>> getPriorizacion(
    String? idTambo,
  ) async {
    List<PriorizacionModel> aResp = [];
    final response = await _pnPaisApi.getPriorizacion(idTambo);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<ServicioBasicoTamboModel>> getServicioBasicoTambo(
    String? idTambo,
  ) async {
    List<ServicioBasicoTamboModel> aResp = [];
    final response = await _pnPaisApi.getServicioBasicoTambo(idTambo);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<HistorialGestorModel>> getHistorialGestor(
    String? snip,
  ) async {
    List<HistorialGestorModel> aResp = [];
    final response = await _pnPaisApi.getHistorialGestor(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<AvanceMetasModel>> getAvanceMetasMensualizada(String anio) async {
    List<AvanceMetasModel> aResp = [];
    final response = await _pnPaisApi.getAvanceMetasMensualizada(anio);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<PersonalTambo>> getPersonalPuestoTambo(String sTipo) async {
    List<PersonalTambo> aResp = [];
    final response = await _pnPaisApi.getPersonalPuestoTambo(sTipo);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<ProgramacionMantenimientoModel>> getProgramacionMantenimiento(
    String? nomUT,
  ) async {
    List<ProgramacionMantenimientoModel> aResp = [];
    final response = await _pnPaisApi.getProgramacionMantenimiento(nomUT);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<ProgIntervencionTamboModel>> getProgIntervencion(
    String? numSnip,
    String? anio,
    String? xMes,
    String? tipo,
    String? estado,
    String? fechaInicio,
    String? fechaFin,
  ) async {
    List<ProgIntervencionTamboModel> aResp = [];
    final response = await _pnPaisApi.getProgIntervencion(
      numSnip,
      anio,
      xMes,
      tipo,
      estado,
      fechaInicio,
      fechaFin,
    );
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<MonitoreoDetailModel>> getMonitoreoDetail(int snip) async {
    List<MonitoreoDetailModel> aResp = [];
    final response = await _pnPaisApi.getMonitoreoDetail(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }

  Future<List<TambosMapaModel>> UbicacionTambo(int snip) async {
    List<TambosMapaModel> aResp = [];
    final response = await _pnPaisApi.getUbicacionTambo(snip);
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return aResp;
  }
}
