import 'package:actividades_pais/backend/api/pnpais2_api.dart';
import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class DependencyInjection {
  static void initialize(String sAmbiente) {
    String baseUrl = "";
    String baseUrl2 = "";
    switch (sAmbiente) {
      case "DEV_LOC":
        baseUrl = "http://192.168.1.36:8075";
        baseUrl2 = "https://www.pais.gob.pe";
        break;
      case "DEV":
        baseUrl = "https://backend.pais.gob.pe:8075";
        baseUrl2 = "https://www.pais.gob.pe";
        break;
      case "QAS":
        baseUrl = "";
        break;
      case "PRD":
        baseUrl = "";
        break;
    }

    Logger logger = Logger();

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );

    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );

    final Dio dio2 = Dio(
      BaseOptions(
        baseUrl: baseUrl2,
      ),
    );
    Http http2 = Http(
      dio: dio2,
      logger: logger,
      logsEnabled: true,
    );

    final PnPaisApi pnPaisApi = PnPaisApi(http);
    final PnPaisApi2 pnPaisApi2 = PnPaisApi2(http2);

    GetIt.instance.registerSingleton<PnPaisApi>(pnPaisApi);
    GetIt.instance.registerSingleton<PnPaisApi2>(pnPaisApi2);
  }
}
