import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/util/app-config.dart';


class ProviderTambok {


  static Future<List<TamboServicioIntervencionesGeneral>> getPosts({int page = 1, int limit = 10}) async {
    print('${AppConfig.urlBackndServicioSeguro}/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/1/$page/$limit');
    final response = await http.get(Uri.parse('${AppConfig.urlBackndServicioSeguro}/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/1/$page/$limit'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["response"]);
      final lista = ListarTamboServicioIntervencionesGeneral.fromJsonList(jsonResponse["response"]);

      return lista.items;
    } else {
      throw Exception('Error al obtener los posts');
    }
  }
  Future<List<TamboServicioIntervencionesGeneral>>?
  listaTamboServicioIntervencionesGeneral({tipo,pag, sizePag}) async {
    print("pag $pag, sizePag $sizePag");
    print(Uri.parse('${AppConfig.urlBackndServicioSeguro}/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/$tipo/1/$sizePag'));
    http.Response response = await http.get(
      Uri.parse('${AppConfig.urlBackndServicioSeguro}/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/$tipo/$pag/$sizePag'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      List.empty();
      final jsonResponse = json.decode(response.body);

      var lista = ListarTamboServicioIntervencionesGeneral();
          lista =ListarTamboServicioIntervencionesGeneral.fromJsonList(jsonResponse["response"]);

      return lista.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

}
