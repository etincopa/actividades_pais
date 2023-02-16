import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/util/app-config.dart';

import '../Clases/Participantes.dart';

class ProviderTambok {
  Future<List<TamboServicioIntervencionesGeneral>>?
  listaTamboServicioIntervencionesGeneral({pag, sizePag}) async {
    print("pag $pag, sizePag $sizePag");
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/tambook/app/tamboServicioIntervencionesGeneral/1/1/$sizePag'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      List.empty();
      final jsonResponse = json.decode(response.body);

      final lista = new ListarTamboServicioIntervencionesGeneral.fromJsonList(jsonResponse["response"]);

      return lista.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

}
