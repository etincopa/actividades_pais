import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/util/app-config.dart';

import '../Clases/Participantes.dart';

class ProviderConfiguracion {
  Future<List<RspoTambosPiasxUnidadTerritorial>?>
      listaTambosPiasxUnidadTerritorial(tambo, idUnidadTerr) async {
    http.Response response = await http.get(
      Uri.parse('${AppConfig.urlBackndServicioSeguro}/api-pnpais/app/consultarTambosPiasxUnidadTerritorial/$tambo/$idUnidadTerr'),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          ConsultarTambosPiasxUnidadTerritorial.fromJson(jsonResponse);

      return listadostraba.response;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<ConfigPersonal> buscarUsuarioApp(codigo) async {
    print('${AppConfig.urlBackndServicioSeguro}/api-pnpais/app/listarUsuariosApp');
    http.Response response = await http.get(
      Uri.parse('${AppConfig.urlBackndServicioSeguro}/api-pnpais/app/listarUsuariosApp'),
    );
    // print(response.body);

    final jsonResponse = json.decode(response.body);
    final listadoUsuario =
        ListasUsuarios.fromJsonList(jsonResponse["response"]);
    for (var i = 0; i < listadoUsuario.items.length; i++) {
      if (listadoUsuario.items[i].codigo == codigo) {
        print(codigo);
        print(listadoUsuario.items[i].nombres);
        return listadoUsuario.items[i];
      }
    }
    return ConfigPersonal();
  }

  Future<Participantes> buscarUsuarioDni(dni) async {
    http.Response responseReniec = await http.get(
      Uri.parse(
          '${AppConfig.backendsismonitor}/programaciongit/validar-dni/$dni'),
    );
    if (responseReniec.statusCode == 200) {
      final jsonResponse = json.decode(responseReniec.body);
      final listadostraba = Participantes.fromJsonReniec(jsonResponse);

      return listadostraba;
    } else {
      return Participantes();
    }
  }
}
