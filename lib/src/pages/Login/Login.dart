// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:actividades_pais/backend/model/tocken_usuarios_model.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Login/politicas.dart';
import 'package:actividades_pais/src/pages/Tambook/Home/main_tambook.dart';
import 'package:actividades_pais/src/pages/configuracion/ResetContrasenia.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/widgets/botonLog.dart';
import 'package:actividades_pais/src/pages/Login/customImput.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../datamodels/Provider/PorviderLogin.dart';

bool? checkGuardarDatos = false;
bool? check = false;
bool? bRepeat = false;

MainController mainController = MainController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var contador = 0;

  @override
  void initState() {
    vaidarexUsuario();
    super.initState();
  }

  vaidarexUsuario() async {
    var cnt = await DatabasePr.db.getAllConfigPersonal();

    List<String> aTipoUsuario = [];
    for (var u in cnt) {
      if (u.tipoUsuario == 'DEMO') aTipoUsuario.add(u.tipoUsuario);
    }

    /**
     * Valida si el usuario registrado es DEMO, 
     * caso contrario habilita el boton "registrarse en el app".
     */
    setState(() {
      contador = cnt.length == aTipoUsuario.length ? 0 : cnt.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h / 22),
              child: SizedBox(
                height: h / 15,
                //width: w / 90,
                child: Image.asset(
                  'assets/LOGO PAIS_OK2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h / 12),
              decoration: const BoxDecoration(
                gradient: mainButton5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: w / 4,
                    height: h / 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/LOGO_SIG.png',
                          width: w / 5.5,
                          height: h / 19,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -h / 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(
                      left: w / 15,
                      right: w / 15,
                      top: h / 4,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: h / 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Form(),
                          SizedBox(height: h / 35),
                          TextButton(
                            child: const Text(
                              'Políticas de privacidad',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Politicas()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await DatabasePr.db.deletelogin();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TambookHome()),
                    );
                  },
                  icon: const Icon(Icons.person_pin),
                  label: const Text("Entrar como invitado")),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final pnPaisApi = GetIt.instance<PnPaisApi>();
  final emailCtrl = TextEditingController(text: "");
  final passCtrl = TextEditingController();
  final passCtrl2 = TextEditingController();
  int tipoUsuario = 1;
  var esperar = 'Ingresar';
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Future LoginUser(usn, psw, rpsw, tipoUser) async {
      if (tipoUser == 1) {
        BusyIndicator.show(context);
        try {
          setState(() {
            esperar = 'Espere un monento...';
          });

          var resLogin = await ProviderLogin().Login(
            username: usn,
            password: psw,
          );
          esperar = 'Ingresar';
          if (resLogin >= 1) {
            MainController mainCtr = MainController();
            TockenUsuariosModel tocken = TockenUsuariosModel.empty();
            var res = await DatabasePr.db.loginUser();
            String toquen = '';
            tocken.idUsuario = res[0].id.toString();
            tocken.ipmaq = '0.0.0.0';

            await OneSignal.shared
                .setAppId("0564bdcf-196f-4335-90e4-2ea60c71c86b");

            await OneSignal.shared
                .promptUserForPushNotificationPermission()
                .then((aceptado) {
              print("Permiso aceptado: $aceptado");
            });

            await OneSignal.shared
                .getDeviceState()
                .then((value) => {toquen = value!.userId ?? ''});

            if (toquen != '' && toquen.isNotEmpty && toquen != '0') {
              tocken.tocken = toquen;
              await mainCtr.insertarTockenUsuario(tockens: tocken);
            }

            OneSignal.shared.setSubscriptionObserver(
                (OSSubscriptionStateChanges changes) async {
              String onesignalUserId = changes.to.userId ?? '';
              print('Player ID CHANGED: $onesignalUserId');
              tocken.tocken = onesignalUserId;
              await mainCtr.insertarTockenUsuario(tockens: tocken);
            });

            BusyIndicator.hide(context);

            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePagePais()),
            );
          }
        } catch (oError) {
          BusyIndicator.hide(context);

          setState(() {
            esperar = 'Ingresar';
          });
          mostrarAlerta(context, 'Login incorrecto',
              'Revise sus credenciales nuevamente');
        }
      }

      return;
    }

    return Container(
      margin: EdgeInsets.only(top: h / 195),
      padding: EdgeInsets.symmetric(horizontal: w / 16),
      child: Column(
        children: <Widget>[
          const Text(
            "SISTEMA DE INFORMACIÓN Y GESTIÓN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          CustomInput(
            icon: Icons.supervised_user_circle,
            placeholder: 'Ingrese su DNI',
            keyboardType: TextInputType.number,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Ingrese su Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ResetContrasenia()),
              );
            },
            child: const Text(
              'Olvido su contraseña?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: h / 50),
          BotonLog(
            text: esperar,
            onPressed: () async {
              await LoginUser(
                emailCtrl.text,
                passCtrl.text,
                passCtrl.text,
                tipoUsuario,
              );
            },
          ),
        ],
      ),
    );
  }
}
