import 'package:actividades_pais/src/Utils/add_home_icons.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Pias/Actividades/listaActividades.dart';
import 'package:actividades_pais/src/pages/Pias/AtencionesRealizadas/atencionesRealizadas.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/incidentesNovedades.dart';
import 'package:actividades_pais/src/pages/Pias/Nacimientos/nacimientos.dart';
import 'package:actividades_pais/src/pages/Pias/Parte/parte.dart';

import '../../../util/app-config.dart';

class ReporteDiario extends StatefulWidget {
  String plataforma = "", unidadTeritorial = "", idUnicoReporte = '';
  int idPlataforma = 0;
  String long = '';
  String lat = '';
  String campaniaCod = '';

  ReporteDiario({super.key, 
    this.plataforma = "",
    this.unidadTeritorial = "",
    this.idPlataforma = 0,
    this.idUnicoReporte = '',
    this.lat = '',
    this.long = '',
    this.campaniaCod = '',
  });

  @override
  State<ReporteDiario> createState() => _ReporteDiarioState();
}

class _ReporteDiarioState extends State<ReporteDiario> {
  var seleccionarPuesto = 'Seleccionar';
  int currenIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    traerdato();
    super.initState();

  }

  traerdato() async {
    var art = await ProviderDatos().verificacionpesmiso();
    widget.lat = art[0].latitude.toString();
    widget.long = art[0].longitude.toString();
    print(art[0].latitude);
    setState(() {});
  }
  @override
  void dispose() {
    // Guardar los datos de la pantalla actual antes de cambiar a otra
    switch (currenIndex) {
      case 0:
      // Guardar los datos de la pantalla de inicio
       // _guardarDatosPantallaInicio();
        break;
      case 1:
      // Guardar los datos de la pantalla de búsqueda
   //     _guardarDatosPantallaBusqueda();
        break;
      case 2:
      // Guardar los datos de la pantalla de configuración
     //   _guardarDatosPantallaConfiguracion();
        break;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List listPages = [
      Parte(
          unidadTerritorial: widget.unidadTeritorial,
          plataforma: widget.plataforma,
          idPlataforma: widget.idPlataforma,
          idUnicoReporte: widget.idUnicoReporte,
          long: widget.long,
          lat: widget.lat,
          campaniaCod: widget.campaniaCod),
      ListaActividades(widget.idUnicoReporte),
      AtencionesRealizadas(widget.idUnicoReporte),
      IncidentesNovedades(widget.idUnicoReporte),
      Nacimientos(widget.idUnicoReporte)
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            leading: Util().iconbuton(() => Navigator.of(context).pop()),
            backgroundColor:AppConfig.primaryColor,
            title: Container(
              child: Text("REPORTE DIARIO EQUIPO DE\nCAMPAÑA", style: TextStyle(fontSize: 16,color: AppConfig.letrasColor),),
            ),
            actions: [
              InkWell(
                  child: const Icon(Icons.check),
                  onTap: () {
                    Navigator.pop(context, "OK");
                  }),
              const SizedBox(
                width: 10,
              )
            
            ],
          )),
      body: listPages[currenIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currenIndex,
        onItemSelected: (index) {
          setState(() {
            currenIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: const Icon(Icons.pending_actions_rounded),
              title: Text("PARTE",  style: TextStyle(color:AppConfig.letrasColor),),
              activeColor: AppConfig.primaryColor,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.home_rounded),
              title: const Text("Actividades"),
              activeColor: AppConfig.primaryColor,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Add_home.hand_holding_medical),
              title: const Text("Atenciones Realizadas"),
              activeColor: AppConfig.primaryColor,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.handyman),
              title: const Text("Incidentes"),
              activeColor: AppConfig.primaryColor,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.child_friendly),
              title: const Text("Nacimientos"),
              activeColor: AppConfig.primaryColor,
              inactiveColor: Colors.black),
        ],
      ),
    );
  }
}
