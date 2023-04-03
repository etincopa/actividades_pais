import 'package:actividades_pais/src/datamodels/Clases/Home/Perfiles.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/AprobacionPlanes/AprobacionPlanes.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ListaIntervecionesProgramadas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntervencionesHome extends StatefulWidget {
  @override
  State<IntervencionesHome> createState() => _IntervencionesHomeState();
}

class _IntervencionesHomeState extends State<IntervencionesHome> {
  int currentIndex = 0;

  String iconIntervencion = 'assets/icons/icon_intervencion.png';
  String iconActividades = 'assets/icons/actividades.png';
  String tipoPlataforma = "";
  String unidadTerritorial = "";
  List<Perfil> idMenuPadre = [];

  @override
  void initState() {
    // TODO: implement initState
    _fetchData();
    mostrarTmbo();
    super.initState();
  }

  Future<void> _fetchData() async {
    var res = await DatabasePr.db.loginUser();
    if (res.isNotEmpty) {
      idMenuPadre.addAll(res.map((e) => Perfil(idMenuPadre: e.rol)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (idMenuPadre.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    List<HomeOptions> aHomeOptions = [];

    final Responsive responsive = Responsive.of(context);
    double wp = responsive.wp(14);
    double hp65 = responsive.hp(27);
    wp = responsive.wp(20);
    hp65 = responsive.wp(15);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (!isPortrait) {}

    for (int i = 0; i < idMenuPadre.length; i++) {
      print(idMenuPadre[i].idMenuPadre);
      switch (idMenuPadre[i].idMenuPadre) {
        case '115':
          if (tipoPlataforma == "TAMBO") {
           /* aHomeOptions.add(
              HomeOptions(
                code: 'OPT1012',
                name: 'PROGRAMAR PRESTACION'.tr,
                types: const ['Ver'],
                image: iconActividades,
                color: const Color(0xFF78b8cd),
              ),
            );*/

            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1003',
                name: 'TileEjeIntervencion'.tr,
                types: const ['Ver'],
                image: iconIntervencion,
                color: const Color(0xFF78b8cd),
              ),
            );
          } else {
            aHomeOptions.add(
              HomeOptions(
                code: 'OPT1011',
                name: 'PLAN DE TRABAJO MENSUAL'.tr,
                types: const ['Ver'],
                image: iconActividades,
                color: const Color(0xFF78b8cd),
              ),
            );
          }
          break;
        case '110':
          /*aHomeOptions.add(
            HomeOptions(
              code: 'OPT1012',
              name: 'PROGRAMAR PRESTACION'.tr,
              types: const ['Ver'],
              image: iconActividades,
              color: const Color(0xFF78b8cd),
            ),
          );
*/
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1011',
              name: 'PLAN DE TRABAJO MENSUAL'.tr,
              types: const ['Ver'],
              image: iconActividades,
              color: const Color(0xFF78b8cd),
            ),
          );

          break;
        case '1':
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1012',
              name: 'PROGRAMAR PRESTACION'.tr,
              types: const ['Ver'],
              image: iconActividades,
              color: const Color(0xFF78b8cd),
            ),
          );

          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1011',
              name: 'PLAN DE TRABAJO MENSUAL'.tr,
              types: const ['Ver'],
              image: iconActividades,
              color: const Color(0xFF78b8cd),
            ),
          );

          break;
      }
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
                    switch (oHomeOptionSelect.code) {
                      case 'OPT1003':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Intervenciones(unidadTerritorial),
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
                      case 'OPT1012':
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ListaIntervecionesProgramadas(),
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
          centerTitle: true
      ),
      body: listPages[currentIndex],
    );

  }

  Future<void> traerDatosDeUsuario() async {
    await DatabasePr.db.initDB();
    var usuario = await DatabasePr.db.getAllConfigPersonal();

    if (usuario.isNotEmpty) {
      print("usuario[0].rol ${usuario[0].rol}");
    }
  }

  mostrarTmbo() async {
    await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.isNotEmpty) {
      tipoPlataforma = abc[0].tipoPlataforma;
      unidadTerritorial = abc[0].unidTerritoriales;
      await traerDatosDeUsuario();
      setState(() {});
    }
  }

}
