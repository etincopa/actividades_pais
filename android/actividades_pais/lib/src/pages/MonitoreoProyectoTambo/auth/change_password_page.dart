import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

MainController mainController = MainController();
SharedPreferences? _prefs;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final apsw = TextEditingController();
  final npsw = TextEditingController();
  final rpsw = TextEditingController();

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future resetPassUser(apsw, npsw, rpsw) async {
    UserModel oUser;
    try {
      if (npsw != rpsw) {
        mostrarAlerta(
          context,
          'Incorrecto',
          'Las nuevas credenciales no coinciden.',
        );
        return;
      }

      String dni = _prefs!.getString("dni") ?? "";
      String usn = _prefs!.getString("codigo") ?? "";
      String psw = _prefs!.getString("clave") ?? "";

      List<ConfigPersonal> aUserInfo = await DatabasePr.db.getLoginUser(
        dni: int.parse(dni),
        contrasenia: apsw,
      );

      if (aUserInfo.isEmpty) {
        mostrarAlerta(
          context,
          'Incorrecto',
          'Comprueba tu contraseña actual de nuevo.',
        );
        return;
      }

      ConfigPersonal oUserInfo = aUserInfo[0];

      if (npsw == oUserInfo.contrasenia) {
        mostrarAlerta(
          context,
          'Incorrecto',
          'Introduzca una contraseña diferente a la actual.',
        );
        return;
      }

      oUser = await mainController.getUserLogin(usn, '');

      oUserInfo.contrasenia = npsw;
      oUser.clave = npsw;
      await DatabasePr.db.updateUsuarioContrasenia(oUserInfo);
      await mainController.insertUser(oUser);

      if (psw != "") {
        _prefs!.setString("clave", oUserInfo.contrasenia);
      }

      Fluttertoast.showToast(
          msg: "Cambio de contraseña !HECHO!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(255, 139, 200, 235),
          textColor: Colors.black,
          fontSize: 16.0);

      Navigator.of(context).pop();
    } catch (oError) {
      mostrarAlerta(
        context,
        'Ops! Algo salio mal',
        oError.toString(),
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget changePasswordButton = InkWell(
      onTap: () async {
        await resetPassUser(apsw.text, npsw.text, rpsw.text);
      },
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
          gradient: mainButton4,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(40, 211, 11, 11),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Center(
          child: Text(
            'ConfirmChangePassword'.tr,
            style: const TextStyle(
              color: Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );

    Color colorInput = const Color.fromARGB(255, 239, 237, 237);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: WidgetCustoms.appBar(
        'Credential'.tr,
        context: context,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(
          builder: (b, constraints) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 48.0, top: 16.0),
                          child: Text(
                            'ChangePassword'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            'EnterCurrentPassword'.tr,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: colorInput,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: TextField(
                            controller: apsw,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'EnterCurrentPassword'.tr,
                              hintStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 12.0),
                          child: Text(
                            'EnterNewPassword'.tr,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: colorInput,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: npsw,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'EnterNewPassword'.tr,
                              hintStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 12.0),
                          child: Text(
                            'RepetNewPassword'.tr,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: colorInput,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: rpsw,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'RepetNewPassword'.tr,
                              hintStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: bottomPadding != 20 ? 20 : bottomPadding,
                        ),
                        width: width,
                        child: Center(child: changePasswordButton),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
