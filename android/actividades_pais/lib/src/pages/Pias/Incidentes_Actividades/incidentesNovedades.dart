import 'package:flutter/material.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/evidencias.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/incidentes.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/novedades.dart';

import '../../../../util/app-config.dart';

class IncidentesNovedades extends StatelessWidget {
  String idUnicoReporte ='';
  IncidentesNovedades(this.idUnicoReporte, {super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor:AppConfig.primaryColor,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Incidentes',
                  ),
                  Tab(
                    text: 'Novedades',
                  ),

              Tab(
              text: 'Evidencias',
            ),
                ],
              ),
              // title: Text('Tabs Demo'),
            )),
        body: TabBarView(
          children: [Incidentes(idUnicoReporte), Novedades(idUnicoReporte), Evidencias(idUnicoReporte)],
        ),
      ),
    );
  }
}
