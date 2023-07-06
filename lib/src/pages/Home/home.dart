import 'dart:async';
import 'package:actividades_pais/src/datamodels/Clases/Home/Perfiles.dart';
import 'package:actividades_pais/src/pages/Intervenciones/IntervencionesHome.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/main_footer_all_option.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/actividadesPnpais.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/cordinacion_articulacion.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/monitoreo_suspervicion.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/SeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/pages/Tambook/Home/main_tambook.dart';
import 'package:actividades_pais/src/pages/seguimientoMonitoreo/dashboard.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Pias/ListaReportesPias.dart';
import 'package:actividades_pais/src/pages/configuracion/Asistencia.dart';
import 'package:actividades_pais/src/pages/configuracion/pantallainicio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'appbar/AppBar.dart';

SharedPreferences? _prefs;

class HomePagePais extends StatefulWidget {
  static String route = '/';

  const HomePagePais({super.key});

  @override
  _HomePagePais createState() => _HomePagePais();
}

class _HomePagePais extends State<HomePagePais> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final Logger _log = Logger();

  int currenIndex = 0;
  var cantidadDB = 0;
  Color changecolor = Colors.grey;
  var _nombrePersona = '';
  var _apellidosPersona = '';
  var unidadTerritorial = '';
  var variable = '';

  var idPlataforma = 0;
  var tipoPlataforma = '';
  var campaniaCod = '';
  var modalidad = '';
  int? dniPrueba;

  String? token;

  String long = '';
  String lat = '';
  List<String> aUnidad = [];

  bool cargo = false;
  List<Perfil> idMenuPadre = [];

  @override
  void initState() {
    super.initState();
    if (_nombrePersona != '') {
      _nombrePersona = "Un momento por favor";
    }

    perfil();
    mostrarTmbo();
    traerdato();
    verificargps();
    datosParaPerfil();
    mostrarNombre();
    initPlatform();
  }

  perfil() async {
    /*  cantidadDB = 1;
    var res = await ProviderServicios().loadPerfiles();
    if (res!.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        idMenuPadre.add(Perfil(idMenuPadre: res[i].idMenuHijo));
      }

      return;
    }*/

    cantidadDB = 1;
    var res = await DatabasePr.db.loginUser();
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        idMenuPadre.add(Perfil(idMenuPadre: res[i].rol));
      }

      return;
    }
  }

  Future verificargps() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
    } else {}
  }

  traerdato() async {
    await ProviderDatos().verificacionpesmiso();
  }

  datosParaPerfil() async {
    cantidadDB = 1;
    var res = await DatabasePr.db.getAllConfigPersonal();
    if (res.isNotEmpty) {
      List<String> aUnidadTemp = [];
      for (var u in res) {
        aUnidadTemp.add(u.unidad);
      }
      setState(() {
        aUnidad = aUnidadTemp;
      });
      return;
    }
  }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.isNotEmpty) {
      setState(() {
        mostrarNombre();
        if (abc.isNotEmpty) {
          tipoPlataforma = abc[0].tipoPlataforma;
          unidadTerritorial = abc[0].unidTerritoriales;
          variable = abc[0].nombreTambo;
          modalidad = abc[0].modalidad;
        }
      });
    }
  }

  Future mostrarNombre() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();

    _prefs = await SharedPreferences.getInstance();
    token = _prefs!.getString("token");

    if (abc.isNotEmpty) {
      dniPrueba = abc[0].numeroDni;
      cargo = true;
      setState(() {
        _nombrePersona = abc[abc.length - 1].nombres.toUpperCase();
        _apellidosPersona =
            '${abc[abc.length - 1].apellidoPaterno.toUpperCase()} ${abc[abc.length - 1].apellidoMaterno.toUpperCase()}';
      });
    } else {
      setState(() {
        _nombrePersona = _prefs!.getString("nombres")!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    double wp = responsive.wp(14);
    double hp65 = responsive.hp(27);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (!isPortrait) {
      wp = responsive.wp(20);
      hp65 = responsive.wp(15);
    }

    String icon0 = 'assets/icons/icon_user_setting.png';
    String icon1 = 'assets/icons/icon_account_balance.png';
    String icon2 = 'assets/icons/icon_boat.png';
    String icon3 = 'assets/icons/icon_fligth.png';
    String icon4 = 'assets/icons/icon_intervencion.png';
    String icon5 = 'assets/icons/monitoreo.png';
    String icon6 = 'assets/icons/parque_informatico.png';
    String icon7 = 'assets/icons/actividades.png';
    String icon8 = 'assets/icons/libro-abierto.png';

    List<HomeOptions> aHomeOptions = [];

    for (int i = 0; i < idMenuPadre.length; i++) {
      switch (idMenuPadre[i].idMenuPadre) {
        //1 :
        case '1':
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1009',
              name: 'TileParqueInfomatico'.tr,
              types: const ['Ver'],
              image: icon6,
              color: const Color(0xFF78b8cd),
            ),
          );
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1007',
              name: 'SEGUIMIENTO Y MONITOREO',
              types: const ['Ver'],
              image: icon5,
              color: const Color(0xFF78b8cd),
            ),
          );
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1003',
              name: 'TileIntervencion'.tr,
              types: const ['Ver'],
              image: icon4,
              color: const Color(0xFF78b8cd),
            ),
          );

          break;
        case '110':
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1003',
              name: 'TileIntervencion'.tr,
              types: const ['Ver'],
              image: icon4,
              color: const Color(0xFF78b8cd),
            ),
          );
          break;
        case '77':
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1009',
              name: 'TileParqueInfomatico'.tr,
              types: const ['Ver'],
              image: icon6,
              color: const Color(0xFF78b8cd),
            ),
          );
          break;
        case '115':
          if (tipoPlataforma != 'PIAS') {
            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1003',
                name: 'TileIntervencion'.tr,
                types: const ['Ver'],
                image: icon4,
                color: const Color(0xFF78b8cd),
              ),
            );
          }

          if (tipoPlataforma == 'PIAS' &&
              (modalidad == '1' || modalidad == '2' || modalidad == '3')) {
            String sImagePias = modalidad == '1'
                ? icon2
                : modalidad == '2'
                    ? icon3
                    : icon1;
            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1004',
                name: 'TilePias'.tr,
                types: const ['Ver'],
                image: sImagePias,
                color: const Color(0xFF78b8cd),
              ),
            );
          }
          break;
        case '136':
          if (tipoPlataforma == 'PIAS' &&
              (modalidad == '1' || modalidad == '2' || modalidad == '3')) {
            String sImagePias = modalidad == '1'
                ? icon2
                : modalidad == '2'
                    ? icon3
                    : icon1;
            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1004',
                name: 'TilePias'.tr,
                types: const ['Ver'],
                image: sImagePias,
                color: const Color(0xFF78b8cd),
              ),
            );
          }
          break;

        case '119':
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1003',
              name: 'TileIntervencion'.tr,
              types: const ['Ver'],
              image: icon4,
              color: const Color(0xFF78b8cd),
            ),
          );
          break;

        case '133':
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1007',
              name: 'SEGUIMIENTO Y MONITOREO',
              types: const ['Ver'],
              image: icon5,
              color: const Color(0xFF78b8cd),
            ),
          );
          break;
      }

      /* switch (idMenuPadre[i].idMenuPadre) {
        case "mnu.articulacion":
          if (tipoPlataforma != 'PIAS') {
            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1003',
                name: 'TileIntervencion'.tr,
                types: const ['Ver'],
                image: icon4,
                color: const Color(0xFF78b8cd),
              ),
            );

            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1006',
                name: 'TileProgramacionActividad'.tr,
                types: const ['Ver'],
                image: icon7,
                color: const Color(0xFF78b8cd),
              ),
            );
          }
          break;

        case "mnu.soporte.equipo":
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1009',
              name: 'TileParqueInfomatico'.tr,
              types: const ['Ver'],
              image: icon6,
              color: const Color(0xFF78b8cd),
            ),
          );
          break;

        case "mnu.soporte":
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1009',
              name: 'TileParqueInfomatico'.tr,
              types: const ['Ver'],
              image: icon6,
              color: const Color(0xFF78b8cd),
            ),
          );
          break;

        case "mnu.administrativos":
          // if (aUnidad.contains("UPS")) {
           if (tipoPlataforma != 'PIAS') {
            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1007',
                name: 'SEGUIMIENTO Y MONITOREO',
                types: const ['Ver'],
                image: icon5,
                color: const Color(0xFF78b8cd),
              ),
            );
          }
   /*        aHomeOptions.add(
            HomeOptions(
              code: 'OPT1007',
              name: 'SEGUIMIENTO Y MONITOREO',
              types: const ['Ver'],
              image: icon5,
              color: const Color(0xFF78b8cd),
            ),
          );*/
           //}

          break;
      }*/
    }

    /* if (tipoPlataforma == 'PIAS' &&
        (modalidad == '1' || modalidad == '2' || modalidad == '3')) {
      String sImagePias = modalidad == '1'
          ? icon2
          : modalidad == '2'
              ? icon3
              : icon1;
      aHomeOptions.add(
        HomeOptions(
          code: 'OPT1004',
          name: 'TilePias'.tr,
          types: const ['Ver'],
          image: sImagePias,
          color: const Color(0xFF78b8cd),
        ),
      );
    }*/

    aHomeOptions.add(
      HomeOptions(
        code: 'OPT1008',
        name: 'TAMBOOK',
        types: const ['Ver'],
        image: icon8,
        color: const Color(0xFF78b8cd),
      ),
    );
    if (dniPrueba == 47532262 || dniPrueba == 48400113) {
      /* aHomeOptions.add(
        HomeOptions(
          code: 'OPT1007',
          name: 'SEGUIMIENTO Y MONITOREO',
          types: const ['Ver'],
          image: icon5,
          color: const Color(0xFF78b8cd),
        ),
      );*/
    }

    if (aUnidad.contains("UPS")) {
      if (token != null) {
        /* aHomeOptions.add(
          HomeOptions(
            code: 'OPT1007',
            name: 'SEGUIMIENTO Y MONITOREO',
            types: const ['Ver'],
            image: icon1,
            color: const Color(0xFF78b8cd),
          ),
        );*/
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1008',
            name: 'TAMBOOK',
            types: const ['Ver'],
            image: icon8,
            color: const Color(0xFF78b8cd),
          ),
        );
      } else {
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1005',
            name: 'TileProyectTambo'.tr,
            types: const ['Ver'],
            image: icon5,
            color: const Color(0xFF78b8cd),
          ),
        );
      }
    }

    void _intervencionOptions(BuildContext context) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('TileProgramacionActividad'.tr),
          message: Text('SelectOption'.tr),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () async {
                /*
                 COORDINACIÓN Y ARTICULACIÓN
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CordinacionArticulacion(),
                  ),
                );
              },
              child: Text('TileCordArticulacion'.tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                /*
                 MONITOREO Y SUPERVISIÓN
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitoreoSupervicion(),
                  ),
                );
              },
              child: Text('TileMinitoreoSuper'.tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                /*
                 ACTIVIDADES PNPAIS
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActividadesPnpais(),
                  ),
                );
              },
              child: Text('TileActividadPnpais'.tr),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
        ),
      );
    }

    List listPages = [
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: hp65,
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 58,
                ),
                itemCount: aHomeOptions.length,
                itemBuilder: (context, index) {
                  HomeOptions homeOption = aHomeOptions[index];
                  return InkWell(
                    splashColor: Colors.white10,
                    highlightColor: Colors.white10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage("assets/icons/botones 1-01.png"),
                          fit: BoxFit.cover,
                        ),
                        color: homeOption.color,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 8,
                              ),
                              child: Hero(
                                tag: homeOption.image!,
                                child: Image.asset(
                                  homeOption.image!,
                                  fit: BoxFit.contain,
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Text(
                                  homeOption.name!,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () async {
                      var oHomeOptionSelect = aHomeOptions[index];

                      if (cantidadDB < 1) {
                        if (oHomeOptionSelect.code == 'OPT1000') {
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const PantallaInicio(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Registrarse en el App',
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      } else {
                        switch (oHomeOptionSelect.code) {
                          case 'OPT1001':
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Asistencia(long: long, lat: lat),
                              ),
                            );
                            break;
                          case 'OPT1003':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const IntervencionesHome(),
                              ),
                            );
                            /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Intervenciones(unidadTerritorial),
                              ),
                            );*/
                            break;
                          case 'OPT1009':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SeguimientoParqueInformatico(),
                              ),
                            );
                            break;
                          /* case 'OPT1010':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HistorialTambos(),
                              ),
                            );
                            break;*/
                          case 'OPT1004':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListaReportesPias(
                                  unidadTeritorial: unidadTerritorial,
                                  plataforma: variable,
                                  idPlataforma: idPlataforma,
                                  long: long,
                                  lat: lat,
                                  campaniaCod: campaniaCod,
                                ),
                              ),
                            );
                            break;
                          default:
                        }
                      }

                      switch (oHomeOptionSelect.code) {
                        case 'OPT1005':
                          var rspt = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MainFooterAllOptionPage(),
                            ),
                          );
                          break;
                        case 'OPT1007':
                          var rspt = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const Dashboard(),
                            ),
                          );
                          break;

                        case 'OPT1008':
                          var rspt = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TambookHome(),
                            ),
                          );
                          break;
                        case 'OPT1006':
                          _intervencionOptions(context);
                          break;
                        default:
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarPais(
            datoUt: token == null ? unidadTerritorial : '',
            plataforma: variable,
            nombre: (_nombrePersona.isNotEmpty)
                ? '$_nombrePersona  $_apellidosPersona'
                : 'USUARIO INVITADO',
          ),
          listPages[currenIndex]
        ],
      ),
    );
  }

  Future<void> initPlatform() async {
    var res = await DatabasePr.db.loginUser();

    print("USUARIO ID ${res[0].id ?? ''}");
    await OneSignal.shared.setAppId("0564bdcf-196f-4335-90e4-2ea60c71c86b");

    await OneSignal.shared
        .getDeviceState()
        .then((value) => {print("IDS ${value!.userId}")});

    /*OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
    await OneSignal.shared
        .getDeviceState()
        .then((value) => {print("IDS ${value!.userId}")});*/

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
      String onesignalUserId = changes.to.userId ?? '';
      print('Player ID CHANGED: $onesignalUserId');
    });
  }
}
