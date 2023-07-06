import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroTicketEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaPersonalSoporte.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/Mantenimiento.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/TicketsEquipos.dart';
import 'package:flutter/material.dart';

import '../../../datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'DetalleEquipo.dart';

class DetalleEquipoInformatico extends StatefulWidget {
  ListaEquipoInformatico listaEquipoInformatico;

  DetalleEquipoInformatico(this.listaEquipoInformatico);

  @override
  State<DetalleEquipoInformatico> createState() =>
      _DetalleEquipoInformaticoState();
}

class _DetalleEquipoInformaticoState extends State<DetalleEquipoInformatico> {
  bool filterTikets = false;
  FiltroTicketEquipo filtroTicketEquipo = FiltroTicketEquipo();

  var seleccionarPersonal="";

  ///TabController? _tabController;

  @override
  void initState() {
    filtroTicketEquipo.idEquipo = widget.listaEquipoInformatico.idEquipoInformatico;
    //   _tabController = new TabController(vsync: null!, length: 5);

    super.initState();
  }

  @override
  void dispose() {
    //  _tabController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("DETALLE EQUIPO INFORMATICO"),centerTitle: true),
        body: DefaultTabController(
          initialIndex: 0,
          length:3,
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  //       backgroundColor: Colors.primaries,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    //    controller: _tabController,
                    // isScrollable: true,
                    onTap: (index) {
                       setState(() {
                        if (index == 1) {
                          filterTikets = true;
                        } else {
                          filterTikets = false;
                        }
                      });
                    },
                    tabs: [
                      Tab(
                        text: 'Detalle',
                      ),
                      Tab(
                        text: 'Tickets',
                      ),Tab(
                        text: 'Mantenimiento',
                      )
                    ],
                  ),
                  // title: Text('Tabs Demo'),
                )),
            body: TabBarView(
              //controller: _tabController,
              children: [
                DetalleEquipo(widget.listaEquipoInformatico),
                TicketsEquipos(filtroTicketEquipo),
                Mantenimiento(filtroTicketEquipo)
              ],
            ),
          ),
        ));
  }

}
