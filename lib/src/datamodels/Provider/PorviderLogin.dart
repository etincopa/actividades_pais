import 'dart:io';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigInicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/LoginClass.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderLogin {
  final Logger _log = Logger();

  bool _isOnline = false;

  Future checkInternetConnection() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
        return _isOnline;
      } else {
        _isOnline = false;
        return _isOnline;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    return _isOnline;
  }

  Future<bool> _checkInternetConnection() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
        return _isOnline;
      } else {
        _isOnline = false;
        return _isOnline;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    return _isOnline;
  }

  Login({username, password}) async {
    var chekInternet = await _checkInternetConnection();
    if (chekInternet == true) {
      var headers = {'Content-Type': 'application/json'};
      http.Response response = await http.post(
          Uri.parse(AppConfig.backendsismonitor + '/seguridad/login'),
          headers: headers,
          body: json.encode({
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        final parsedJson = jsonDecode(response.body);
        final log = new LoginClass.fromJson(parsedJson);
        var loginClass = LoginClass();
        _log.i(log.token);
        loginClass.username = username;
        loginClass.password = password;
        loginClass.name = log.name;
        loginClass.rol = log.rol;
        loginClass.token = log.token;
        loginClass.id = log.id;

        SharedPreferences? _prefs = await SharedPreferences.getInstance();
        _prefs.setString("idUser", log.id.toString());

        var a = await DatabasePr.db.Login(loginClass);
        print(response.body);
        print("log.rol ${log.rol}");

        await ProviderDatos().getInsertPerfiles(log.rol);
        http.Response responseUsuario = await http.get(
            Uri.parse(AppConfig.urlBackndServicioSeguro +
                '/api-pnpais/app/datosLoginUsuario/${loginClass.id}'),
            headers: headers);
        final parsedJson2 = jsonDecode(responseUsuario.body);
        final data = parsedJson2["response"];

        if (responseUsuario.statusCode == 200) {
          if (parsedJson2["total"] > 0) {
            var r2 = ConfigPersonal(
                unidad: '', //data[0]["area_abreviatura"] ?? ''
                nombres: data[0]["empleado_nombre"] ?? '',
                apellidoMaterno: data[0]["empleado_apellido_materno"] ?? '',
                apellidoPaterno: data[0]["empleado_apellido_paterno"] ?? '',
                contrasenia: password ?? '',
                fechaNacimento: data[0]["empleado_fecha_nacimiento"] ?? '',
                numeroDni: int.parse(username ?? 0));

            await DatabasePr.db.insertConfigPersonal(r2);

            for (var i = 0; i < data.length; i++) {
              _log.i("numero1");

              var configIni = ConfigInicio(
                  idLugarPrestacion: 0,
                  idPuesto: data[i]["id_puesto"] ?? 0,
                  idTambo: data[i]["id_plataforma"] ?? 0,
                  idUnidTerritoriales: data[i]["id_unidad_territorial"] ?? 0,
                  idUnidadesOrganicas: 0,
                  lugarPrestacion: "",
                  nombreTambo: data[i]["plataforma_descripcion"] ?? '',
                  puesto: data[i]["puesto_descripcion"] ?? '',
                  unidTerritoriales:
                      data[i]["unidad_territorial_descripcion"] ?? '',
                  unidadesOrganicas: "",
                  snip: data[i]["plataforma_codigo_snip"] ?? 0,
                  tipoPlataforma: data[i]["tipoPlataforma"] ?? '',
                  campania: '',
                  codCampania: '',
                  modalidad: data[i]["modalidad"].toString() ?? '');

              if (configIni.tipoPlataforma == 'PIAS') {
                await ProviderServiciosRest().listarPuntoAtencionPias(
                    '0', data[i]["id_plataforma"] ?? 0, 0);
              }
              await DatabasePr.db.insertConfigInicio(configIni);
            }
            // return a;
          }
        }
        return a;
      } else {
        print(response.reasonPhrase);

        if (response.statusCode != 200) {
          await ProviderDatos().getInsertPerfiles("x");

          MainController mainController = MainController();
          UserModel oUser;
          oUser = await mainController.getUserLogin(username, '');
          if (oUser.password == password) {
            var loginClass = LoginClass();

            loginClass.username = username;
            loginClass.password = password;
            loginClass.name = oUser.nombres;
            loginClass.rol = oUser.rol;
            loginClass.token = '';
            loginClass.id = 0;
            var a = await DatabasePr.db.Login(loginClass);

            SharedPreferences? _prefs = await SharedPreferences.getInstance();
            _prefs.setString("nombres", oUser.nombres!);
            _prefs.setString("codigo", oUser.codigo!);
            _prefs.setString("rol", oUser.rol!);
            _prefs.setString("dni", username);

            var r2 = ConfigPersonal(
                unidad: 'UPS',
                nombres: oUser.nombres ?? '',
                apellidoMaterno: '',
                apellidoPaterno: '',
                contrasenia: password ?? '',
                fechaNacimento: '',
                numeroDni: int.parse(username ?? 0));
            await DatabasePr.db.insertConfigPersonal(r2);
            return a;
          }
        }
      }
    } else if (chekInternet == false) {
      var rsp = await DatabasePr.db
          .getLoginUser(dni: username, contrasenia: password);

      return rsp.length;
    }
  }
}
