import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/backend/api/pnpais2_api.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/repository/main2_repo.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:actividades_pais/helpers/dependecy_injection.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/widgets/intro/splash_intro_page.dart';
import 'package:actividades_pais/resource/Internationalization.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

//late ObjectBoxDbPnPais OBoxDbPnPais;
void main() async {
  //await initializeDateFormatting('es', 'es_ES');
  DependencyInjection.initialize("DEV");
  //GlobalBindings().dependencies();

  WidgetsFlutterBinding.ensureInitialized();
  //OBoxDbPnPais = await ObjectBoxDbPnPais.init();
  await DatabasePr.db.initDB();
  //await DatabasePr.db.createUserDemo();

  final mainApi = GetIt.instance<PnPaisApi>();
  final mainApi2 = GetIt.instance<PnPaisApi2>();
  final mainDb = DatabasePnPais.instance;
  final mainRepo = MainRepo(mainApi, mainDb);
  final mainRepo2 = Main2Repo(mainApi2, mainDb);
  final mainServ = MainService();
  Get.put(mainRepo);
  Get.put(mainRepo2);
  Get.put(mainServ);
  Get.put(MainController()); // Se ejecuta loadInitialData();

  runApp(MyApp());
}

class AuthService {
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getBool('loggIn');
    if (token != null) {
      // Validate token on the server
      return true;
    }
    return false;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIG PNPAIS',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.red, //Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<bool>(
          future: _authService.isAuthenticated(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data == true) {
                // User is authenticated, navigate to the main screen
                return const HomePagePais();
              } else {
                // User is not authenticated, show login screen
                return const SplashPage();
              }
            }
          },
        ),
        locale: MyTraslation.locale,
        fallbackLocale: MyTraslation.fallbackLocale,
        translations: MyTraslation(),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var cantidad = 0;

  mostrarDatos() async {
    await DatabasePr.db.initDB();

    var abc = await DatabasePr.db.getAllConfigPersonal();
    cantidad = abc.length;

    if (cantidad == 0) {
      // providerServicios.requestSqlData();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
      //PantallaInicio
    } else {
      /*  Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home_Asis()));*/

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );
    }
  }

  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No internet Connection:")));

  @override
  void initState() {
    //   _datdb.initDB();
    super.initState();

    //initPlatform();
  }

  Future<int> getToken() async {
    await Future.delayed(const Duration(seconds: 3));
    //.then((value) =>;
    mostrarDatos();
    // var abc = await _datdb.getAllTasks();

    return cantidad;
  }

  Future<void> initPlatform() async {
    /*
    await OneSignal.shared.setAppId("0564bdcf-196f-4335-90e4-2ea60c71c86b");

    await OneSignal.shared
        .getDeviceState()
        .then((value) => {print(value!.userId)});

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
    await OneSignal.shared
        .getDeviceState()
        .then((value) => {print("IDS ${value!.userId}")});

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
      String onesignalUserId = changes.to.userId ?? '';
      print('Player ID: ' + onesignalUserId);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getToken();
    });
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Iniciando... ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home_Asis extends StatelessWidget {
  const Home_Asis({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePagePais();
  }
}
