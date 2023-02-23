import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/atenciones_model.dart';
import 'package:actividades_pais/backend/model/dto/dropdown_dto.dart';
import 'package:actividades_pais/backend/model/dto/login_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_token_dto.dart';
import 'package:actividades_pais/backend/model/lista_trama_monitoreo_detail.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/obtener_ultimo_avance_partida_model.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:actividades_pais/util/check_geolocator.dart';
import 'package:actividades_pais/util/throw-exception.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MainController extends GetxController {
  final Logger _log = Logger();

  final loading = false.obs;
  final users = <UserModel>[].obs;
  //final moniteos = <TramaMonitoreoModel>[].obs;
  final ultimoAvancePartida = <UltimoAvancePartidaModel>[].obs;

  final proyectos = <TramaProyectoModel>[].obs;
  final maestra = <ComboItemModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await loadInitialData();
  }

  /*
   Carga todos los registros inicial del sistema de la API REST a la DB local
   */
  Future<void> loadInitialData() async {
    loading.value = true;
    users.value = await Get.find<MainService>().loadAllUser(0, 0);
    proyectos.value = await Get.find<MainService>().loadAllProyecto(0, 0);
    ultimoAvancePartida.value =
        await Get.find<MainService>().loadAllAvancePartida(0, 0);
    maestra.value = await Get.find<MainService>().loadAllMaestra(0, 0);
    loading.value = false;
  }

  Future<bool> syncLoadInitialData() async {
    if (await Get.find<MainService>().isOnline()) {
      loading.value = true;
      await loadInitialData();
      loading.value = false;
      return true;
    } else {
      throw ThrowCustom(
        type: 'E',
        msg: 'No se puede sincronizar, verifique su conexión.',
      );
    }
  }

  Future<bool> deleteAllData() async {
    await Get.find<MainService>().deleteAllData();
    return true;
  }

  Future<bool> deleteAllMonitorByEstadoENV() async {
    await Get.find<MainService>().deleteAllMonitorByEstadoENV();
    return true;
  }

  /*
   Obtiene los Items para los Combos
   @String sType 
   */
  Future<List<ComboItemModel>> getComboItemByType(
    String sType,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .getComboItemByType(sType, limit, offset);
  }

  Future<List<ComboItemModel>> getListComboItemByType(
    String sType,
    int? limit,
    int? offset,
  ) async {
    List<ComboItemModel> aComboItem =
        await getComboItemByType(sType, limit, offset);

    // List<ComboItemModel> aList = aComboItem.map((o) => o.descripcion).toList();
    // return aList.whereType<ComboItemModel>().toList();
    return aComboItem;
  }

  /*
   Obtiene los datos del usuario
   @String codigo
   @String clave (Opcional) Si clave es vacio solo obtiene la info del usuario por el codigo
   */
  Future<UserModel> getUserLogin(
    String codigo,
    String clave,
  ) async {
    UserModel oUserLogin = await Get.find<MainService>().getUserByCode(codigo);

    if (clave != "") {
      if (oUserLogin.clave == clave) {
        return oUserLogin;
      }
    } else {
      return oUserLogin;
    }

    return Future.error(
      "Usuario y/o Clave incorrecto, vuelve a intentarlo mas tarde.",
    );
  }

  /*
   Inserta / Actualiza datos del Usuario
   @UserModel o
   */
  Future<UserModel> insertUser(UserModel o) async {
    try {
      UserModel oUserLogin = await Get.find<MainService>().insertUserDb(o);
      return oUserLogin;
    } catch (oError) {
      return Future.error(
        oError.toString(),
      );
    }
  }

  /*
   Obtiene la lista de proyectos segun el ROL del Usuario y busqueda según la coincidencia
   @UserModel o
   @String search
   */
  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .getAllProyectoByUserSearch(o, search, limit, offset);
  }

  /*
   Obtiene la lista de proyectos segun el ROL del Usuario y busqueda según la coincidencia
   @UserModel o
   @String search
   */
  Future<List<TramaProyectoModel>> getAllProyectoDashboard(
    String search,
  ) async {
    return await Get.find<MainService>().getAllProyectoDashboard(search);
  }

  /*
   Obtiene la lista de proyectos diferentes al ROL del Usuario logeado y busqueda según la coincidencia
   @UserModel o
   @String search
   */
  Future<List<TramaProyectoModel>> getAllProyectoByNeUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .getAllProyectoByNeUserSearch(o, search, limit, offset);
  }

  /*
   Obtiene la lista de Monitoreos de los proyecto que no pertencen al usuario logeado
   @UserModel o
   */
  Future<List<TramaMonitoreoModel>> getAllOtherMonitoreo(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .readAllOtherMonitoreo(o, limit, offset);
  }

  /*
   Obtiene la lista de Monitoreos cuyo estado sea POR ENVIAR
   */
  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviar(
    int? limit,
    int? offset,
    TramaProyectoModel? o,
  ) async {
    return await Get.find<MainService>()
        .getAllMonitorPorEnviar(limit, offset, o!);
  }

  /*
   Obtiene la lista de Monitoreos segun el Proyecto seleccionado
   @TramaProyectoModel o
   */
  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .getAllMonitoreoByProyecto(o, limit, offset);
  }

  /*
    Obtiene la lista de los ultimos avance de partida de los proyectos
   */
  Future<List<UltimoAvancePartidaModel>> getUltimoAvancePartida() async {
    List<UltimoAvancePartidaModel> aResp =
        await Get.find<MainService>().getUltimoAvancePartida();
    return aResp;
  }

  /*
    Obtiene la lista de Monitoreos segun el Proyecto seleccionado (online)
   @TramaProyectoModel o
   */
  Future<List<TramaMonitoreoModel>> getTramaMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    List<TramaMonitoreoModel> aResp =
        await Get.find<MainService>().getTramaMonitoreo(o);
    return aResp;
  }

  /*
   Obtiene los datos de generales del Monitoreo por el idMonitoreo
   @String idMonitoreo
   */
  Future<List<TramaMonitoreoModel>> getMonitoreoById(
    String sIdMonitoreo,
  ) async {
    return await Get.find<MainService>().getMonitoreoByIdMonitor(sIdMonitoreo);
  }

  /*
   Obtiene los datos de generales del Monitoreo por el tipo de PARTIDA EJECUTADA
   @String sTypePartida
   */
  Future<List<TramaMonitoreoModel>> getAllMonitoreoByTypePartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    return await Get.find<MainService>()
        .getMonitoreoByTypePartida(o, sTypePartida);
  }

  Future<UltimoAvancePartidaModel> getUltimoAvanceByProyectoAndPartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    List<UltimoAvancePartidaModel> aMonitoreo = await Get.find<MainService>()
        .getUltimoAvanceByProyectoAndPartida(o, sTypePartida);

    return aMonitoreo.last;
  }

  /*
   Guardar/Actualizar nuevo Monitoreo y valida campos requeridos
   @TramaProyectoModel o
   */
  Future<TramaMonitoreoModel> saveMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    DateFormat oDFormat = DateFormat('yyyy-MM-dd');
    DateFormat oDFormat2 = DateFormat('HHmmss');
    DateTime _now = DateTime.now();

    if (loading.isTrue) {
      return Future.error(
        'Ya hay un proceso en ejecución, espere a que finalice.',
      );
    }

    loading.value = true;

    double avanceFisicoAcumulado =
        parseDouble(o.avanceFisicoAcumulado.toString()) * 100;

    double avanceFisicoPartida =
        parseDouble(o.avanceFisicoPartida.toString()) * 100;

    if (!(avanceFisicoAcumulado >= 0 && avanceFisicoAcumulado <= 100)) {
      loading.value = false;
      return Future.error(
        'Imposible guardar monitoreo valores aceptados en avance físico acumulado es de 0 a 100 (%)',
      );
    }
    if (!(avanceFisicoPartida >= 0 && avanceFisicoPartida <= 100)) {
      loading.value = false;
      return Future.error(
        'Imposible guardar monitoreo valores aceptados en avance físico de partida es de 0 a 100 (%)',
      );
    }

    if (o.idEstadoMonitoreo == TramaMonitoreoModel.sIdEstadoAPR) {
      loading.value = false;
      return Future.error(
        'Imposible modificar un Monitoreo con el estado: ${TramaMonitoreoModel.sEstadoAPR}',
      );
    }

    if (o.cui!.trim() == '') {
      loading.value = false;
      return Future.error(
        'Error al procesar el Monitoreo, verifique los siguientes campos: CUI.',
      );
    }

    if (o.fechaMonitoreo!.trim() == '') {
      o.fechaMonitoreo = oDFormat.format(_now);
    }

    if (o.idMonitoreo!.contains("<")) {
      String idBuild = '<CUI>_<IDE>_<FECHA_MONITOREO>';
      idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(_now));
      idBuild = idBuild.replaceAll('<CUI>', o.cui!);
      idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo!);
      o.idMonitoreo = idBuild;
    }

    /*
      Autocompletar campos con datos del Proyecto
      - cui -> cui
      - snip -> numSnip
      - tambo -> tambo
      - fechaTerminoEstimado -> fechaTerminoEstimado
      - avanceFisicoAcumulado -> avanceFisico
    */
    try {
      List<TramaProyectoModel> aSearh =
          await Get.find<MainService>().getProyectoByCUI(o.cui!);
      if (aSearh != null && aSearh.isNotEmpty) {
        TramaProyectoModel oProyecto = aSearh[0];
        if (o.snip!.trim() == '') {
          o.snip = oProyecto.numSnip;
        }
        if (o.tambo!.trim() == '') {
          o.tambo = oProyecto.tambo;
        }
        if (o.fechaTerminoEstimado!.trim() == '') {
          o.fechaTerminoEstimado = oProyecto.fechaTerminoEstimado;
        }
        if (o.avanceFisicoAcumulado! == 0) {
          o.avanceFisicoAcumulado = isNumeric(oProyecto.avanceFisico)
              ? double.parse(oProyecto.avanceFisico.toString())
              : 0;
        }
      }
    } catch (oError) {
      _log.e(
        oError.toString(),
      );
    }

    bool isComplete = await validateMonitor(o);

    if (isComplete) {
      o.idEstadoMonitoreo = TramaMonitoreoModel.sIdEstadoXEN;
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoXEN;
    } else {
      o.idEstadoMonitoreo = TramaMonitoreoModel.sIdEstadoINC;
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;
    }

    if (o.latitud == "" || o.longitud == "") {
      try {
        List<Position> aPosition = await CheckGeolocator().getPosition();
        o.latitud = aPosition[0].latitude.toString();
        o.longitud = aPosition[0].longitude.toString();
      } catch (oError) {
        loading.value = false;
        throw ThrowCustom(
          type: 'E',
          msg:
              'Los permisos de ubicación están deshabilitados, vaya a Configuración de su dispositivo > Privacidad para otorgar permisos a la aplicación.',
        );
      }
    }

    final oResp = await Get.find<MainService>().insertMonitorDb(o);
    loading.value = false;

    return oResp;
  }

  /*
   Obtiene la lista de Programacion por ID o general
   @String idProgramacionIntervenciones
   */
  Future<List<ProgramacionActividadModel>> getAllProgramacion(
    String idProgramacionIntervenciones,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>().getAllProgramaIntervencion(
      idProgramacionIntervenciones,
      limit,
      offset,
    );
  }

  Future<List<TamboActividadModel>> getTamboIntervencionAtencionIncidencia(
    int? idTambo,
    int? idTipo,
    int? anio,
    int? numMaxRegistro,
  ) async {
    return await Get.find<MainService>().tamboIntervencionAtencionIncidencia(
      idTambo.toString(),
      idTipo.toString(),
      anio.toString(),
      numMaxRegistro.toString(),
    );
  }

  /*
   Guardar/Actualizar nuevo Programacion y valida campos
   @ProgramacionIntervencionesModel o
   */
  Future<ProgramacionActividadModel> saveProgramaIntervencion(
    ProgramacionActividadModel o,
  ) async {
    if (loading.isTrue) {
      return Future.error(
        'Ya hay un proceso en ejecución, espere a que finalice.',
      );
    }

    DateFormat oDFormat = DateFormat('yyyy-MM-dd');
    DateFormat oDFormat2 = DateFormat('HHmmss');
    DateTime _now = DateTime.now();

    if (o.id == null || o.id! <= 0) {
      o.estadoProgramacion = ProgramacionActividadModel.sEstadoPEN;
      String idBuild = '<FECHA>_<IDE>';
      idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(_now));
      idBuild = idBuild.replaceAll('<FECHA>', oDFormat.format(_now));
      o.idProgramacionIntervenciones = idBuild;
    }

    final oResp = await Get.find<MainService>().insertProgramaIntervencionDb(o);
    loading.value = false;

    return oResp;
  }

  /*
    Elimina el registro mediante el ID de la DB local
  */
  Future<bool> deleteProgramaIntervencion(
    ProgramacionActividadModel o,
  ) async {
    final result =
        await Get.find<MainService>().deleteProgramaIntervencionDb(o);
    return result == 1;
  }

  /*
    Enviar registros a la nube
    - Validar que todos los campos requeridos esten completos
    - Validar que el estado esta en: POR ENVIAR
    - Validar que se encuentre con conexion a internet
  */
  Future<List<ProgramacionActividadModel>> sendProgramaIntervencion(
    List<ProgramacionActividadModel> a,
  ) async {
    try {
      if (loading.isTrue) {
        return Future.error(
          'Ya hay un proceso en ejecución, espere a que finalice.',
        );
      }

      loading.value = true;

      /// Evaluar que todos los monitoreos de la lista tengan el estado
      /// POR ENVIAR
      bool isOk = true;
      a.forEach((o) {
        if (o.estadoProgramacion != ProgramacionActividadModel.sEstadoPEN) {
          isOk = false;
        }
      });

      if (isOk == true) {
        final aResp =
            await Get.find<MainService>().sendAllProgramaIntervencion(a, []);

        /// Retornar registros que generar error al enviarse al servidor
        loading.value = false;
        return aResp;
      }

      throw Exception(
        'Imposible enviar documentos al servidor debido a que tienen estados diferentes a : ${ProgramacionActividadModel.sEstadoPEN}',
      );
    } catch (oError) {
      loading.value = false;
      return Future.error(
        oError.toString(),
      );
    }
  }

  /*
    Enviar registros a la nube
    - Validar que todos los campos requeridos esten completos
    - Validar que el estado esta en: POR ENVIAR
    - Validar que se encuentre con conexion a internet
  */
  Future<List<TramaMonitoreoModel>> sendMonitoreo(
    List<TramaMonitoreoModel> a,
  ) async {
    try {
      if (loading.isTrue) {
        return Future.error(
          'Ya hay un proceso en ejecución, espere a que finalice.',
        );
      }

      loading.value = true;

      /// Evaluar que todos los monitoreos de la lista tengan el estado
      /// POR ENVIAR
      bool isOk = true;
      a.forEach((o) {
        if (o.idEstadoMonitoreo != TramaMonitoreoModel.sIdEstadoXEN) {
          isOk = false;
        }
      });

      if (isOk == true) {
        final aResp = await Get.find<MainService>().sendAllMonitoreo(a, []);

        /// Retornar registros que generar error al enviarse al servidor
        loading.value = false;
        return aResp;
      }

      throw Exception(
        'Imposible enviar documentos al servidor debido a que tienen estados diferentes a : ${TramaMonitoreoModel.sEstadoXEN}',
      );
    } catch (oError) {
      loading.value = false;
      return Future.error(
        oError.toString(),
      );
    }
  }

  /*
    Enviar registros a la nube de todos los monitoreos de un Proyecto
    - Validar que todos los campos requeridos esten completos
    - Validar que el estado esta en: POR ENVIAR
    - Validar que se encuentre con conexion a internet
  */
  Future<List<TramaMonitoreoModel>> sendMonitoreoByProyecto(
    TramaProyectoModel? o,
  ) async {
    if (loading.isTrue) {
      return Future.error(
        'Ya hay un proceso en ejecución, espere a que finalice.',
      );
    }
    loading.value = true;

    List<TramaMonitoreoModel> a =
        await Get.find<MainService>().getAllMonitorPorEnviar(0, 0, o);

    /// Evaluar que todos los monitoreos de la lista tengan el estado
    /// POR ENVIAR

    if (a.isEmpty) {
      loading.value = false;
      throw ThrowCustom(
        type: 'W',
        msg:
            'No se encontraron registros con estados: ${TramaMonitoreoModel.sEstadoXEN}',
      );
    }

    bool isOk = true;
    a.forEach((o) {
      if (o.estadoMonitoreo != TramaMonitoreoModel.sEstadoXEN) {
        isOk = false;
      }
    });

    if (isOk == true) {
      List<TramaMonitoreoModel> aError;
      try {
        aError = await Get.find<MainService>().sendAllMonitoreo(a, []);
      } catch (oError) {
        loading.value = false;
        throw ThrowCustom(
          type: 'E',
          msg: oError.toString(),
        );
      }

      /// Retornar registros que generar error al enviarse al servidor
      loading.value = false;

      if (aError.isEmpty) {
        throw ThrowCustom(
          type: 'E',
          msg:
              '¡Algo salió mal!. hay registros que no se pudieron enviar al servidor.',
          obj: aError,
        );
      } else {
        throw ThrowCustom(
          type: 'S',
          msg: 'Todos los registros se enviaron al servidor con éxito.',
          obj: aError,
        );
      }
    }

    loading.value = false;
    throw ThrowCustom(
      type: 'E',
      msg:
          'Imposible enviar documentos al servidor debido a que tienen estados diferentes a : ${TramaMonitoreoModel.sEstadoXEN}',
    );
  }

  /*
    Elimina un Monitor de la base de datos Local
    - @TramaMonitoreoModel o
  */
  Future<bool> deleteMonitor(
    TramaMonitoreoModel o,
  ) async {
    final result = await Get.find<MainService>().deleteMonitorDb(o);
    return result == 1;
  }

  /*
    Validaciones de Monitoreo (Nuevo/Actualizar)
    - @TramaMonitoreoModel o
  */
  Future<bool> validateMonitor(
    TramaMonitoreoModel o,
  ) async {
    /*
      Validar campos OBLIGATORIOS
      - ID: <cui>_IDE_<fechaMonitoreo>
      - latitud
      - longitud
      - fechaTerminoEstimado
      - actividadPartidaEjecutada
      - alternativaSolucion
      - avanceFisicoAcumulado
      - estadoAvance
      - fechaMonitoreo
      - imgActividad
      - problemaIdentificado
    */

    bool isComplete = true;
    if (o.latitud!.trim() == '') {
      isComplete = false;
    } else if (o.longitud!.trim() == '') {
      isComplete = false;
    } else if (o.fechaTerminoEstimado!.trim() == '') {
      isComplete = false;
    } /*else if (o.actividadPartidaEjecutada!.trim() == '') {
      isComplete = false;
    }*/
    else if (o.idAlternativaSolucion == 0) {
      isComplete = false;
    } else if (o.avanceFisicoAcumulado! == 0) {
      isComplete = false;
    } else if (o.idEstadoAvance == 0) {
      isComplete = false;
    } else if (o.imgActividad!.trim() == '') {
      isComplete = false;
    } else if (o.idProblemaIdentificado == 0) {
      isComplete = false;
    }

    return isComplete;
  }

  /*
    Construye un nuevo Monitoreo mediante el codigo unico de proyecto
    - @String cui
  */
  Future<TramaMonitoreoModel> buildNewMonitor(
    String cui,
  ) async {
    DateFormat oDFormat = DateFormat('yyyy-MM-dd');
    DateFormat oDFormat2 = DateFormat('HHmmss');
    DateTime now = DateTime.now();
    TramaMonitoreoModel o = TramaMonitoreoModel.empty();

    /*
      Autocompletar campos con datos del Proyecto
      - cui -> cui
      - snip -> numSnip
      - tambo -> tambo
      - fechaTerminoEstimado -> fechaTerminoEstimado
      - avanceFisicoAcumulado -> avanceFisico
    */
    try {
      if (o.fechaMonitoreo!.trim() == '') {
        o.fechaMonitoreo = oDFormat.format(DateTime.now());
      }

      o.idEstadoMonitoreo = TramaMonitoreoModel.sIdEstadoINC;
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;

      List<TramaProyectoModel> aSearh =
          await Get.find<MainService>().getProyectoByCUI(cui);
      if (aSearh != null && aSearh.isNotEmpty) {
        TramaProyectoModel oProyecto = aSearh[0];

        String idBuild = '<CUI>_<IDE>_<FECHA_MONITOREO>';
        idBuild = idBuild.replaceAll('<CUI>', oProyecto.cui!);
        idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(now));
        idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo!);
        o.idMonitoreo = idBuild;

        if (o.cui!.trim() == '') {
          o.cui = oProyecto.cui;
        }
        if (o.snip!.trim() == '') {
          o.snip = oProyecto.numSnip;
        }
        if (o.tambo!.trim() == '') {
          o.tambo = oProyecto.tambo;
        }
        if (o.fechaTerminoEstimado!.trim() == '') {
          o.fechaTerminoEstimado = oProyecto.fechaTerminoEstimado;
        }
        if (o.avanceFisicoAcumulado! == 0) {
          o.avanceFisicoAcumulado = isNumeric(oProyecto.avanceFisico)
              ? double.parse(oProyecto.avanceFisico.toString())
              : 0;
        }
      } else {
        String idBuild = '<CUI>_<IDE>_<FECHA_MONITOREO>';
        idBuild = idBuild.replaceAll('<CUI>', cui);
        idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(now));
        idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo!);
        o.idMonitoreo = idBuild;
        o.cui = cui;
      }

      try {
        List<Position> aPosition = await CheckGeolocator().getPosition();
        o.latitud = aPosition[0].latitude.toString();
        o.longitud = aPosition[0].longitude.toString();
      } catch (oError) {
        //_log.e(oError.toString());
      }
    } catch (oError) {
      _log.e(
        oError.toString(),
      );
      return Future.error(oError.toString());
    }

    bool isComplete = await validateMonitor(o);

    if (isComplete) {
      o.idEstadoMonitoreo = TramaMonitoreoModel.sIdEstadoXEN;
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoXEN;
    } else {
      o.idEstadoMonitoreo = TramaMonitoreoModel.sIdEstadoINC;
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;
    }

    return o;
  }

  Future<List<BuscarTamboDto>> searchTambo(
    String? search,
  ) async {
    ///Obtiene los registros de la DB Local
    List<BuscarTamboDto> aFind =
        await Get.find<MainService>().searchTambo(search);
    return aFind;
  }

  Future<List<MetasTamboModel>> metasTambo(
    String? numSnip,
    String? anio,
    int? xMes,
  ) async {
    List<MetasTamboModel> aResp =
        await Get.find<MainService>().getMetasTambo(numSnip, anio, xMes);
    return aResp;
  }

  Future<RespTokenDto> login(
    LoginDto oBody,
  ) async {
    RespTokenDto oResp = await Get.find<MainService>().login(oBody);
    return oResp;
  }

  Future<List<CombosDto>> getTipoUsuario() async {
    List<CombosDto> aResp = await Get.find<MainService>().getTipoUsuario();
    return aResp;
  }

  Future<List<CombosDto>> getSector(int key) async {
    List<CombosDto> aResp = await Get.find<MainService>().getSector(key);
    return aResp;
  }

  Future<List<CombosDto>> getPrograma(int key) async {
    List<CombosDto> aResp = await Get.find<MainService>().getPrograma(key);
    return aResp;
  }

  Future<List<CombosDto>> getDocAcredita() async {
    List<CombosDto> oResp = await Get.find<MainService>().getDocAcredita();
    return oResp;
  }

  Future<List<CombosDto>> getArticulacionOrientada() async {
    List<CombosDto> aResp =
        await Get.find<MainService>().getArticulacionOrientada();
    return aResp;
  }

  Future<List<CombosDto>> getAccion() async {
    List<CombosDto> aResp = await Get.find<MainService>().getAccion();
    return aResp;
  }

  Future<List<CombosDto>> getTipoActividad() async {
    List<CombosDto> oResp = await Get.find<MainService>().getTipoActividad();
    return oResp;
  }

  Future<ProgramRespDto> sendCoordinacionArticulacion(
      ProgActModel oBody) async {
    ProgramRespDto oResp =
        await Get.find<MainService>().sendCoordinacionArticulacion(oBody);
    return oResp;
  }

  Future<ProgramRespDto> sendMonitoreoSupervision(
    ProgActModel oBody,
  ) async {
    ProgramRespDto oResp =
        await Get.find<MainService>().sendMonitoreoSupervision(
      oBody,
    );
    return oResp;
  }

  Future<ProgramRespDto> sendActividadesPNPAIS(
    ProgActModel oBody,
  ) async {
    ProgramRespDto oResp = await Get.find<MainService>().sendActividadesPNPAIS(
      oBody,
    );
    return oResp;
  }

  Future<List<AtencionesModel>> getResumeAtenciones() async {
    ///Obtiene los registros de la DB Local
    await Future.delayed(const Duration(seconds: 1));
    List<AtencionesModel> aFind = await AtencionesModel.categoryList;
    return aFind;
  }

  Future<RespBase64FileDto> getBuildBase64PdfFichaTecnica(String tambo) async {
    RespBase64FileDto oResp =
        await Get.find<MainService>().getBuildBase64PdfFichaTecnica(tambo);
    return oResp;
  }

  Future<TamboModel> getTamboDatoGeneral(String tambo) async {
    TamboModel oResp = await Get.find<MainService>().tamboDatoGeneral(tambo);
    return oResp;
  }

  Future<List<TambosMapaModel>> getTamboParaMapa() async {
    List<TambosMapaModel> oResp =
        await Get.find<MainService>().tambosParaMapa();
    return oResp;
  }

  Future<List<IncidentesInternetModel>> getIncidenciasInternet(int snip) async {
    List<IncidentesInternetModel> oResp =
        await Get.find<MainService>().incidenciasInternetTambo(snip);
    return oResp;
  }

  Future<List<MonitoreoDetailModel>> getMonitoreoDetail(int snip) async {
    List<MonitoreoDetailModel> oResp =
        await Get.find<MainService>().monitoreoDetail(snip);
    return oResp;
  }

  bool isNumeric(dynamic s) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(s);
  }

  double parseDouble(String number) {
    try {
      return double.parse(number);
    } catch (oError) {
      return 0;
    }
  }
}
