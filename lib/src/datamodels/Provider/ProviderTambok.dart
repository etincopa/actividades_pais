import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/TipoGobiernoResponse.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/util/app-config.dart';

import '../Clases/Participantes.dart';

class ProviderTambok {
  static Future<List<TamboServicioIntervencionesGeneral>> getPosts(
      {int page = 1, int limit = 10}) async {
    print(AppConfig.urlBackndServicioSeguro +
        '/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/1/$page/$limit');
    final response = await http.get(Uri.parse(AppConfig
            .urlBackndServicioSeguro +
        '/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/1/$page/$limit'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["response"]);
      final lista = new ListarTamboServicioIntervencionesGeneral.fromJsonList(
          jsonResponse["response"]);

      return lista.items;
    } else {
      throw Exception('Error al obtener los posts');
    }
  }

  Future<List<TamboServicioIntervencionesGeneral>>?
      listaTamboServicioIntervencionesGeneral(
          {tipo, gobierno, sector, pag, sizePag}) async {
    print("pag $pag, sizePag $sizePag");
    print(Uri.parse(AppConfig.urlBackndServicioSeguro +
        '/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/$tipo/$sector/$gobierno/$pag/$sizePag'));
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/$tipo/$sector/$gobierno/$pag/$sizePag'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      List.empty();
      final jsonResponse = json.decode(response.body);

      var lista = ListarTamboServicioIntervencionesGeneral();
      lista = new ListarTamboServicioIntervencionesGeneral.fromJsonList(
          jsonResponse["response"]);

      return lista.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<TipoGobiernoResponse>>? obtenerTipoGobierno(tipo) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/tambook/app/obtenerTipoGobiernoSector/$tipo'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      List.empty();
      final jsonResponse = json.decode(response.body);

      var lista = ListaTipoGobiernoResponse();
      lista = ListaTipoGobiernoResponse.fromJsonList(jsonResponse["response"]);

      return lista.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }
}
