import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/dto/dropdown_dto.dart';
import 'package:actividades_pais/backend/model/dto/login_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_token_dto.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/repository/main2_repo.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:actividades_pais/util/file_util.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainService {
  SharedPreferences? _prefs;
  final Logger _log = Logger();

  /// Returns `true` si existe conexion a internet por wifi/Mobile.
  Future<bool> isOnline() async {
    bool isDeviceConnected = await CheckConnection.isOnlineWifiMobile();
    return isDeviceConnected;
  }

  /*
   Obtiene los Items para los Combos
   @String sType 
   */
  Future<List<ComboItemModel>> getComboItemByType(
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<ComboItemModel> aFind =
        await Get.find<MainRepo>().getAllComboItemByType(search, limit, offset);
    return aFind;
  }

/*
  Enviar los registros de Programacion a la Base de datos central mediante el 
  API REST.

  @ProgramacionIntervencionesModel a : Listado de Programaciones para enviar registros a la nube
  @ProgramacionIntervencionesModel e : Listado de Programaciones que fallaron al enviar
                           (Parametro solo valido para el metodo recursivo)

  CONSIDERACIONES:
  - Los estados de la Programacion deben de tener el estado: POR ENVIAR

  SECUENCIAS:
    LOOP ... 
      (1) - Se envia el registros de Programacion al API REST 
      (2) - Si el envio es correcto, se actualiza el registro en la DB Local al estado
        ENVIADO
      (3) - Responder con todos los registros enviados a la API REST
      (4) - Responder con todos los registros que generaron Error en la API REST
    END LOOP.
  */
  Future<List<ProgramacionActividadModel>> sendAllProgramaIntervencion(
    List<ProgramacionActividadModel> a,
    List<ProgramacionActividadModel>? e,
  ) async {
    bool isOnlines = await isOnline();
    if (isOnlines) {
      List<ProgramacionActividadModel> aResp = [];
      List<ProgramacionActividadModel> aError = e ?? [];
      List<ProgramacionActividadModel> aNoConect = [];

      for (var oMonit in a) {
        /// (1)...
        String estadoMonitoreo = oMonit.estadoProgramacion!;
        oMonit.estadoProgramacion = ProgramacionActividadModel.sEstadoPEN;

        if (isOnlines) {
          try {
            final oResp =
                await Get.find<MainRepo>().insertProgramaIntervencion(oMonit);
            if (oResp.idProgramacionIntervenciones != "") {
              /// (2)...
              ProgramacionActividadModel? oSend = oResp;
              oSend.id = oMonit.id;
              await Get.find<MainRepo>().insertProgramaIntervencionDb(oSend);

              /// (3)...
              aResp.add(oSend);
            }
          } catch (oError) {
            oMonit.estadoProgramacion = estadoMonitoreo;

            /// (4)...
            aError.add(oMonit);

            ///Si falla volver a consultar si existe conexión
            isOnlines = await isOnline();
          }
        } else {
          /// (4)...
          oMonit.estadoProgramacion = estadoMonitoreo;
          aNoConect.add(oMonit);
        }
      }

      if (aNoConect.length > 0) {
        /**
         * Metodo recursivo: Solo reintentar los registros que no se enviaron
         * por perdida de conexión despues de 3 segundos
         */
        await Future.delayed(const Duration(seconds: 3));
        sendAllProgramaIntervencion(aNoConect, aError);
      }

      return aError;
    } else {
      return Future.error(
        '¡Ups! Algo salió mal, verifica tu conexión a Internet.',
      );
    }
  }

  /*
  Enviar los registros de monitoreo a la Base de datos central mediante el 
  API REST.

  @TramaMonitoreoModel a : Listado de Monitoreos para enviar registros a la nube
  @TramaMonitoreoModel e : Listado de Monitoreos que fallaron al enviar
                           (Parametro solo valido para el metodo recursivo)

  CONSIDERACIONES:
  - Los estados del Monitoreo deben de tener el estado: POR ENVIAR

  SECUENCIAS:
    LOOP ... 
      (1) - Se envia el registros de monitoreo al API REST 
      (2) - Si el envio es correcto, se actualiza el registro en la DB Local al estado
        ENVIADO
      (3) - Responder con todos los registros enviados a la API REST
      (4) - Responder con todos los registros que generaron Error en la API REST
    END LOOP.
  */
  Future<List<TramaMonitoreoModel>> sendAllMonitoreo(
    List<TramaMonitoreoModel> a,
    List<TramaMonitoreoModel>? e,
  ) async {
    bool isOnlines = await isOnline();
    if (isOnlines) {
      List<TramaMonitoreoModel> aResp = [];
      List<TramaMonitoreoModel> aError = e ?? [];
      List<TramaMonitoreoModel> aNoConect = [];

      for (var oMonit in a) {
        /// (1)...
        String estadoMonitoreo = oMonit.estadoMonitoreo!;
        int idEstadoMonitoreo = oMonit.idEstadoMonitoreo!;

        // Estado inicial PENDIENTE
        oMonit.idEstadoMonitoreo = TramaMonitoreoModel.sIdEstadoPEN;
        oMonit.estadoMonitoreo = TramaMonitoreoModel.sEstadoPEN;

        if (isOnlines) {
          try {
            final oResp = await Get.find<MainRepo>().insertarMonitoreo(oMonit);
            if (oResp.idMonitoreo != "") {
              /// (2)...
              TramaMonitoreoModel? oSend = oResp;
              oSend.id = oMonit.id;

              await Get.find<MainRepo>().insertMonitorDb(oSend);

              /// (3)...
              aResp.add(oSend);
            }
          } catch (oError) {
            oMonit.estadoMonitoreo = estadoMonitoreo;
            oMonit.idEstadoMonitoreo = idEstadoMonitoreo;

            /// (4)...
            aError.add(oMonit);

            ///Si falla volver a consultar si existe conexión
            isOnlines = await isOnline();
          }
        } else {
          /// (4)...
          oMonit.estadoMonitoreo = estadoMonitoreo;
          aNoConect.add(oMonit);
        }
      }

      if (aNoConect.length > 0) {
        /**
         * Metodo recursivo: Solo reintentar los registros que no se enviaron
         * por perdida de conexión despues de 3 segundos
         */
        await Future.delayed(const Duration(seconds: 3));
        sendAllMonitoreo(aNoConect, aError);
      }

      return aError;
    } else {
      return Future.error(
        '¡Ups! Algo salió mal, verifica tu conexión a Internet.',
      );
    }
  }

  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind = await Get.find<MainRepo>()
        .getAllProyectoByUserSearch(o, search, limit, offset);
    return aFind;
  }

  Future<List<TramaProyectoModel>> getAllProyectoDashboard(
    String search,
  ) async {
    List<TramaProyectoModel> aFind =
        await Get.find<MainRepo>().getAllProyectoApi();
    return aFind;
  }

  Future<List<TramaProyectoModel>> getAllProyectoByNeUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind = await Get.find<MainRepo>()
        .getAllProyectoByNeUserSearch(o, search, limit, offset);
    return aFind;
  }

  Future<List<TramaProyectoModel>> getProyectoByCUI(
    String cui,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind =
        await Get.find<MainRepo>().getProyectoByCUI(cui);
    return aFind;
  }

  Future<RespBase64FileDto> getBuildBase64PdfFichaTecnica(
    String idTambo,
  ) async {
    ///Obtiene fich tecnica PDF del tambo en formato Base64
    RespBase64FileDto aFind =
        await Get.find<MainRepo>().getBuildBase64PdfFichaTecnica(idTambo);
    return aFind;
  }

  Future<TamboModel> tamboDatoGeneral(
    String idTambo,
  ) async {
    ///Obtiene fich tecnica PDF del tambo en formato Base64
    TamboModel aFind = await Get.find<MainRepo>().tamboDatoGeneral(idTambo);
    return aFind;
  }

  Future<List<TramaMonitoreoModel>> readAllOtherMonitoreo(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local de los monitoreos cuyo proyecto no pertence al usuario
    List<TramaMonitoreoModel> aFind =
        await Get.find<MainRepo>().readAllOtherMonitoreo(o, limit, offset);
    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByTypePartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind =
        await Get.find<MainRepo>().getMonitoreoByTypePartida(o, sTypePartida);
    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByIdMonitor(
    String idMonitoreo,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind =
        await Get.find<MainRepo>().getMonitoreoByIdMonitor(idMonitoreo);
    return aFind;
  }

  Future<List<TramaProyectoModel>> loadAllProyecto(
    int? limit,
    int? offset,
  ) async {
    List<TramaProyectoModel> aNewProject = [];

    ///Verifica que tenga conexion a internet
    if (await isOnline()) {
      ///Obtiene los registros de la DB Local
      List<TramaProyectoModel> aDb =
          await Get.find<MainRepo>().getAllProyectoDb(limit, offset);

      ///Obtiene los registros de la nube consumiento la API REST
      List<TramaProyectoModel> aApi =
          await Get.find<MainRepo>().getAllProyectoApi();

      /**
       * Se realiza:
       * Matach entre los dos registros (DB y API),
       * Si los registros de la API teniendo como base el ID @CUI (Código único del proyecto)
       * (1) - existe en la DB local se ignora el registro
       * (2) - caso contrario se procede a registrar a la DB local.
       */
      for (TramaProyectoModel oApi in aApi) {
        if (aDb.isNotEmpty) {
          TramaProyectoModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere((o) => o.cui == oApi.cui,
                orElse: () => TramaProyectoModel.empty());
          } catch (oError) {
            _log.e(oError);
          }

          /// (1)
          if (oDataFind != null || oDataFind!.id == 0) {
            continue;
          }
        }

        /// (2)
        TramaProyectoModel? response =
            await Get.find<MainRepo>().insertProyectoDb(oApi);
        if (response != null) {
          aNewProject.add(response);
        } else {
          _log.e('Error al ingresar proyectos a la Base de Datos');
        }
      }

      _log.i('Nuevos proyectos cargados: ${aNewProject.length}');
    }

    return aNewProject;
  }

  /// MAESTRAS
  Future<List<ComboItemModel>> loadAllMaestra(
    int? limit,
    int? offset,
  ) async {
    List<ComboItemModel> aNewMonitoreo = [];
    if (await isOnline()) {
      List<ComboItemModel> aDb =
          await Get.find<MainRepo>().getAllComboItemByType('', limit, offset);

      List<ComboItemModel> aApi1 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbASOLU);

      List<ComboItemModel> aApi2 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbEAVAN);

      List<ComboItemModel> aApi3 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbEMONI);

      List<ComboItemModel> aApi4 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbNRIES);

      List<ComboItemModel> aApi5 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbPEJEC);

      List<ComboItemModel> aApi6 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbPIDEO);

      List<ComboItemModel> aApi7 =
          await Get.find<MainRepo>().getMaestraByType(ComboItemModel.cbRIDEN);

      List<ComboItemModel> aApi = [];

      aApi.addAll(aApi1);
      aApi.addAll(aApi2);

      /**
       * Estados Locales
       * - INCOMPLETO
       * - POR ENVIAR
       */
      ComboItemModel oTempEMONI = ComboItemModel.empty();
      oTempEMONI.idTypeItem = 'ESTADO_MONITOREO';
      oTempEMONI.codigo1 = TramaMonitoreoModel.sIdEstadoINC.toString();
      oTempEMONI.codigo2 = TramaMonitoreoModel.sIdEstadoINC.toString();
      oTempEMONI.descripcion = TramaMonitoreoModel.sEstadoINC;
      aApi3.add(oTempEMONI);

      ComboItemModel oTempEMONI2 = ComboItemModel.empty();
      oTempEMONI2.idTypeItem = 'ESTADO_MONITOREO';
      oTempEMONI2.codigo1 = TramaMonitoreoModel.sIdEstadoXEN.toString();
      oTempEMONI2.codigo2 = TramaMonitoreoModel.sIdEstadoXEN.toString();
      oTempEMONI2.descripcion = TramaMonitoreoModel.sEstadoXEN;
      aApi3.add(oTempEMONI2);

      aApi.addAll(aApi3);
      aApi.addAll(aApi4);
      aApi.addAll(aApi5);
      aApi.addAll(aApi6);
      aApi.addAll(aApi7);

      for (ComboItemModel oApi in aApi) {
        if (aDb.isNotEmpty) {
          ComboItemModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere(
              (o) =>
                  o.idTypeItem == oApi.idTypeItem && o.codigo1 == oApi.codigo1,
              orElse: () => ComboItemModel.empty(),
            );
          } catch (oError) {
            _log.e(oError);
          }
          if (oDataFind != null || oDataFind!.id == 0) {
            oApi.id = oDataFind.id;
            oApi.isEdit = 0;
            await Get.find<MainRepo>().insertMaestraDb(oApi);

            continue;
          }
        }

        ComboItemModel? response =
            await Get.find<MainRepo>().insertMaestraDb(oApi);
        if (response != null) {
          aNewMonitoreo.add(response!);
        } else {
          _log.e('Error al ingresar Maestros a la Base de Datos');
        }
      }
      _log.i('Nuevos Maestros cargados: ${aNewMonitoreo.length}');
    }

    return aNewMonitoreo;
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> loadAllMonitoreo(
    int? limit,
    int? offset,
  ) async {
    List<TramaMonitoreoModel> aNewMonitoreo = [];
    if (await isOnline()) {
      List<TramaMonitoreoModel> aDb =
          await Get.find<MainRepo>().getAllMonitoreoDb(limit, offset);
      List<TramaMonitoreoModel> aApi =
          await Get.find<MainRepo>().getAllMonitoreoApi();

      aApi.retainWhere((o) {
        /**
         * Filtrar solo Monitoreos con el estado APROBADO
         */
        return o.idEstadoMonitoreo == TramaMonitoreoModel.sIdEstadoAPR;
      });

      try {
        bool isOk = await FileUtil().writeToAllDataFile("MonitoreoApi", aApi);
        /*
        List<TramaMonitoreoModel>? aApi2 =
            await FileUtil().readDataFile("MonitoreoApi", (data) {
          return (data as List)
              .map((e) => TramaMonitoreoModel.fromJson(e))
              .toList();
        });
        */
      } catch (oError) {
        print(oError);
      }

      for (TramaMonitoreoModel oApi in aApi) {
        /**
         * TEMP: Limpiar data base64 temporal,
         * buscar alternativa para almacenamiento de imagenes en json
         */
        oApi.imgActividad1 = '';
        oApi.imgActividad2 = '';
        oApi.imgActividad3 = '';
        oApi.imgActividad4 = '';

        oApi.imgProblema1 = '';
        oApi.imgProblema2 = '';
        oApi.imgProblema3 = '';
        oApi.imgProblema4 = '';

        oApi.imgRiesgo1 = '';
        oApi.imgRiesgo2 = '';
        oApi.imgRiesgo3 = '';
        oApi.imgRiesgo4 = '';

        if (aDb.isNotEmpty) {
          TramaMonitoreoModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere((o) => o.idMonitoreo == oApi.idMonitoreo,
                orElse: () => TramaMonitoreoModel.empty());
          } catch (oError) {
            _log.e(oError);
          }
          if (oDataFind != null || oDataFind!.id == 0) {
            if (oDataFind.idEstadoMonitoreo !=
                TramaMonitoreoModel.sIdEstadoAPR) {
              /*
                Si el estado del monitoreo en la nube es diferente a la data local, 
                se actualiza el registro local.
               */
              oApi.id = oDataFind.id;
              oApi.isEdit = 0;
              await Get.find<MainRepo>().insertMonitorDb(oApi);
            }
            continue;
          }
        }

        TramaMonitoreoModel? response =
            await Get.find<MainRepo>().insertMonitorDb(oApi);
        if (response != null) {
          aNewMonitoreo.add(response);
        } else {
          _log.e('Error al ingresar monitoreo a la Base de Datos');
        }
      }
      _log.i('Nuevos monitoreos cargados: ${aNewMonitoreo.length}');
    }

    return aNewMonitoreo;
  }

  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviar(
    int? limit,
    int? offset,
    TramaProyectoModel? o,
  ) async {
    //if (await isOnline()) {}
    return await Get.find<MainRepo>()
        .getAllMonitorPorEnviarDB(limit, offset, o!);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind = await Get.find<MainRepo>()
        .getAllMonitoreoByIdProyectoDb(o, limit, offset);

    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getTramaMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    List<TramaMonitoreoModel> aResp =
        await Get.find<MainRepo>().getTramaMonitoreo(o);
    return aResp;
  }

  Future<TramaMonitoreoModel> insertMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    return await Get.find<MainRepo>().insertMonitorDb(o);
  }

  Future<int> deleteMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    final result = await Get.find<MainRepo>().deleteMonitorDb(o);
    return result;
  }

  Future<List<ProgramacionActividadModel>> getAllProgramaIntervencion(
    String id,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<ProgramacionActividadModel> aFind =
        await Get.find<MainRepo>().getProgramaIntervencionDb(id, limit, offset);

    return aFind;
  }

  Future<List<TamboActividadModel>> tamboIntervencionAtencionIncidencia(
    String? idTambo,
    String? idTipo,
    String? anio,
    String? numMaxRegistro,
  ) async {
    List<TamboActividadModel> aFind =
        await Get.find<MainRepo>().tamboIntervencionAtencionIncidencia(
      idTambo,
      idTipo,
      anio,
      numMaxRegistro,
    );

    return aFind;
  }

  Future<ProgramacionActividadModel> insertProgramaIntervencionDb(
    ProgramacionActividadModel o,
  ) async {
    var oProgResp = await Get.find<MainRepo>().insertProgramaIntervencionDb(o);

    if (o.registroEntidadActividades!.isNotEmpty) {
      o.registroEntidadActividades!.forEach((object) {
        object.idProgramacionIntervenciones =
            oProgResp.idProgramacionIntervenciones;
      });

      var aActResp = await Get.find<MainRepo>()
          .insertRegistroEntidadActividadMasiveDb(
              o.registroEntidadActividades!);
      oProgResp.registroEntidadActividades = aActResp;
    }

    return oProgResp;
  }

  Future<int> deleteProgramaIntervencionDb(
    ProgramacionActividadModel o,
  ) async {
    final result = await Get.find<MainRepo>().deleteProgramaIntervencionDb(o);
    return result;
  }

  /// USUARIO APP

  Future<UserModel> insertUserDb(UserModel o) async {
    UserModel? response = await Get.find<MainRepo>().insertUserDb(o);
    return response;
  }

  Future<List<UserModel>> loadAllUser(
    int? limit,
    int? offset,
  ) async {
    List<UserModel> aNewLoadUser = [];
    if (await isOnline()) {
      List<UserModel> aDb =
          await Get.find<MainRepo>().getAllUserDb(limit, offset);
      List<UserModel> aApi = await Get.find<MainRepo>().getAllUserApi();

      for (UserModel oApi in aApi) {
        if (aDb.length > 0) {
          UserModel oUserFind = aDb.firstWhere((o) => o.codigo == oApi.codigo);
          if (oUserFind != null) {
            continue;
          }
        }

        UserModel? response = await Get.find<MainRepo>().insertUserDb(oApi);
        if (response != null) {
          aNewLoadUser.add(response!);
        } else {
          _log.e('Error al ingresar usuario a la Base de Datos');
        }
      }
      _log.i('Nuevos usuarios cargados: ${aNewLoadUser.length}');
    }
    return aNewLoadUser;
  }

  Future<UserModel> getUserByCode(
    String codigo,
  ) async {
    try {
      UserModel oUser = await Get.find<MainRepo>().readUserByCode(codigo);
      return oUser;
    } catch (oError) {
      _log.e(oError);
    }
    return Future.error(
      'Usuario incorrecto, vuelve a intentarlo mas tarde.',
    );
  }

  Future deleteAllData() async {
    return await Get.find<MainRepo>().deleteAllData();
  }

  Future deleteAllMonitorByEstadoENV() async {
    return await Get.find<MainRepo>().deleteAllMonitorByEstadoENV();
  }

  /*
   Obtiene todas las considencias de Tambos buscados por:
   @String search 
   */
  Future<List<BuscarTamboDto>> searchTambo(
    String? search,
  ) async {
    ///Obtiene los registros de la DB Local
    List<BuscarTamboDto> aFind = await Get.find<MainRepo>().searchTambo(search);
    return aFind;
  }

  Future<RespTokenDto> login(
    LoginDto oBody,
  ) async {
    RespTokenDto oResp = await Get.find<Main2Repo>().login(oBody);

    /*
     * Guardar el Token en la memoria 
     */
    _prefs = await SharedPreferences.getInstance();
    _prefs!.setString("tokenDate", DateTime.now().toString());
    _prefs!.setString("token", oResp.token!);
    _prefs!.setInt("tokenId", oResp.id!);
    _prefs!.setString("tokenName", oResp.name!);
    _prefs!.setString("tokenRol", oResp.rol!);

    return oResp;
  }

  Future<RespTokenDto> getToken() async {
    _prefs = await SharedPreferences.getInstance();
    RespTokenDto oResp = RespTokenDto.empty();
    //String tokenDate = _prefs!.getString("tokenDate") ?? "";
    String token = _prefs!.getString("token") ?? "";
    int tokenId = _prefs!.getInt("tokenId") ?? 0;
    String tokenName = _prefs!.getString("tokenName") ?? "";
    String tokenRol = _prefs!.getString("tokenRol") ?? "";

    oResp.id = tokenId;
    oResp.name = tokenName;
    oResp.rol = tokenRol;
    oResp.token = token;

    return oResp;
  }

  Future<List<CombosDto>> getTipoUsuario() async {
    List<CombosDto> aResp =
        await Get.find<Main2Repo>().getListDropDown(CombosDto.cbCod001);
    return aResp;
  }

  Future<List<CombosDto>> getSector(int key) async {
    List<CombosDto> aResp = await Get.find<Main2Repo>().getListDropDown(
      CombosDto.cbCod002,
      key: key,
    );
    return aResp;
  }

  Future<List<CombosDto>> getPrograma(int key) async {
    List<CombosDto> aResp = await Get.find<Main2Repo>().getListDropDown(
      CombosDto.cbCod003,
      key: key,
    );
    return aResp;
  }

  Future<List<CombosDto>> getDocAcredita() async {
    List<CombosDto> oResp =
        await Get.find<Main2Repo>().getListDropDown(CombosDto.cbCod004);
    return oResp;
  }

  Future<List<CombosDto>> getArticulacionOrientada() async {
    List<CombosDto> aResp =
        await Get.find<Main2Repo>().getListDropDown(CombosDto.cbCod005);
    return aResp;
  }

  Future<List<CombosDto>> getAccion() async {
    List<CombosDto> aResp = [];
    aResp.add(CombosDto(
      id: 1,
      descrip2: 'Coordinación con entidades',
    ));
    aResp.add(CombosDto(
      id: 2,
      descrip2: 'Articulación - Plan de trabajo',
    ));
    return aResp;
  }

  Future<List<CombosDto>> getTipoActividad() async {
    List<CombosDto> oResp =
        await Get.find<Main2Repo>().getListDropDown(CombosDto.cbCod006);
    return oResp;
  }

  Future<ProgramRespDto> sendCoordinacionArticulacion(
      ProgActModel oBody) async {
    ProgramRespDto oResp =
        await Get.find<Main2Repo>().postCoordinacionArticulacion(oBody);
    return oResp;
  }

  Future<ProgramRespDto> sendMonitoreoSupervision(
    ProgActModel oBody,
  ) async {
    ProgramRespDto oResp = await Get.find<Main2Repo>().postMonitoreoSupervision(
      oBody,
    );
    return oResp;
  }

  Future<ProgramRespDto> sendActividadesPNPAIS(
    ProgActModel oBody,
  ) async {
    ProgramRespDto oResp = await Get.find<Main2Repo>().postActividadesPNPAIS(
      oBody,
    );
    return oResp;
  }

  Future<List<TambosMapaModel>> tambosParaMapa() async {
    List<TambosMapaModel> aFind = await Get.find<MainRepo>().tambosParaMapa();
    return aFind;
  }

  Future<List<IncidentesInternetModel>> incidenciasInternetTambo() async {
    List<IncidentesInternetModel> aFind =
        await Get.find<MainRepo>().indicenciasInternetTambo();
    return aFind;
  }
}
