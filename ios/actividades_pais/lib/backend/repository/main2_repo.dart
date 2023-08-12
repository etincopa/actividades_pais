import 'package:actividades_pais/backend/api/pnpais2_api.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/model/dto/dropdown_dto.dart';
import 'package:actividades_pais/backend/model/dto/login_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_token_dto.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:logger/logger.dart';

class Main2Repo {
  final Logger _log = Logger();

  final DatabasePnPais _dbPnPais;
  final PnPaisApi2 _pnPaisApi;

  Main2Repo(this._pnPaisApi, this._dbPnPais);

  Future<RespTokenDto> login(
    LoginDto oBody,
  ) async {
    RespTokenDto oResp = RespTokenDto.empty();
    final response = await _pnPaisApi.postLogin(oBody);
    if (response.error == null) {
      oResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oResp;
  }

  Future<List<CombosDto>> getListDropDown(
    String resource, {
    int? key,
  }) async {
    List<CombosDto> oResp = [];
    final response = await _pnPaisApi.getListDropDown(resource, key: key);
    if (response.error == null) {
      oResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oResp;
  }

  Future<ProgramRespDto> postCoordinacionArticulacion(
      ProgActModel oBody) async {
    ProgramRespDto oResp = ProgramRespDto.empty();

    final response = await _pnPaisApi.postCoordinacionArticulacion(oBody);
    if (response.error == null) {
      oResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oResp;
  }

  Future<ProgramRespDto> postMonitoreoSupervision(
    ProgActModel oBody,
  ) async {
    ProgramRespDto oResp = ProgramRespDto.empty();
    final response = await _pnPaisApi.postMonitoreoSupervision(oBody);
    if (response.error == null) {
      oResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oResp;
  }

  Future<ProgramRespDto> postActividadesPNPAIS(
    ProgActModel oBody,
  ) async {
    ProgramRespDto oResp = ProgramRespDto.empty();
    final response = await _pnPaisApi.postActividadesPNPAIS(oBody);
    if (response.error == null) {
      oResp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oResp;
  }
}
