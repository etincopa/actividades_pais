import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/AprobacionPlanes/AprobacionPlanes.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntervencionesHome extends StatefulWidget {
  @override
  State<IntervencionesHome> createState() => _IntervencionesHomeState();
}

class _IntervencionesHomeState extends State<IntervencionesHome> {
  int currenIndex = 0;

  String icon4 = 'assets/icons/icon_intervencion.png';

  String icon7 = 'assets/icons/actividades.png';
  String tipoPlataforma = "";
  String unidadTerritorial = "";

  @override
  void initState() {
    // TODO: implement initState
    mostrarTmbo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<HomeOptions> aHomeOptions = [];

    final Responsive responsive = Responsive.of(context);
    double wp = responsive.wp(14);
    double hp65 = responsive.hp(27);
    wp = responsive.wp(20);
    hp65 = responsive.wp(15);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (!isPortrait) {}

    if (tipoPlataforma == "TAMBO") {
      aHomeOptions.add(
        HomeOptions(
          code: 'OPT1003',
          name: 'TileEjeIntervencion'.tr,
          types: const ['Ver'],
          image: icon4,
          color: const Color(0xFF78b8cd),
        ),
      );
    } else {
      aHomeOptions.add(
        HomeOptions(
          code: 'OPT1011',
          name: 'PLAN DE TRABAJO MENSUAL'.tr,
          types: const ['Ver'],
          image: icon7,
          color: const Color(0xFF78b8cd),
        ),
      );
    }

    List listPages = [
      Column(
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
                              tag: homeOption.image,
                              child: Image.asset(
                                homeOption.image,
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
                                homeOption.name,
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
                    switch (oHomeOptionSelect.code) {
                      case 'OPT1003':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Intervenciones(unidadTerritorial),
                          ),
                        );
                        break;
                      case 'OPT1011':
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AprobacionPlanesTrabajo(),
                          ),
                        );
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
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'INTERVENCIONES',
            style: TextStyle(color: Colors.black),
          ),
          leading: Util().iconbuton(() {
            Navigator.pop(context);
          }),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          centerTitle: true),
      body: Stack(
        children: <Widget>[listPages[currenIndex]],
      ),
    );
  }

  Future traerDatosDeUsuario() async {
    DatabasePr.db.initDB();
    var usuario = await DatabasePr.db.getAllConfigPersonal();

    if (usuario.isNotEmpty) {
      print("usuario[0].rol ${usuario[0].rol}");
    } else {}
  }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.isNotEmpty) {
      setState(() {
        traerDatosDeUsuario();
        if (abc.isNotEmpty) {
          tipoPlataforma = abc[0].tipoPlataforma;
          unidadTerritorial = abc[0].unidTerritoriales;
        }
      });
    }
  }
}
