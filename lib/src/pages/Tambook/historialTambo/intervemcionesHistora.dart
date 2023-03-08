import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderTambok.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/fichaIntervencion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/util/Constants.dart';

class intervencionesHistoria extends StatefulWidget {
  const intervencionesHistoria({Key? key}) : super(key: key);

  @override
  State<intervencionesHistoria> createState() => _intervencionesHistoriaState();
}

class _intervencionesHistoriaState extends State<intervencionesHistoria> {
  final controller = ScrollController();
  bool isLoading = false;
  var pageIndexQ = 1;
  var pageSizeQ = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(_onlistener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(_onlistener);
    super.dispose();
  }

  _onlistener() async {
    print(controller.position.maxScrollExtent);

    if ((controller.offset >= controller.position.maxScrollExtent)) {
      isLoading = true;
      setState(() {
        pageSizeQ = pageSizeQ + 2;
      });
      await traerPaguinado(10);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Null> traerPaguinado(pageSize) async {
    // await Future.delayed(const Duration(seconds: 1));
    //  pageIndexQ = pageIndex;
    await ProviderTambok()
        .listaTamboServicioIntervencionesGeneral(pag: 1, sizePag: pageSize);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Listas listas = Listas();
    return Scaffold(
      backgroundColor: color_10o15,
      body: FutureBuilder<List<TamboServicioIntervencionesGeneral>>(
        future: ProviderTambok().listaTamboServicioIntervencionesGeneral(
            pag: 1, sizePag: pageSizeQ),
        builder: (BuildContext context,
            AsyncSnapshot<List<TamboServicioIntervencionesGeneral>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return const Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;
              if (listaPersonalAux!.length == 0) {
                return const Center(
                  child: Text(
                    'No hay informacion',
                    style: TextStyle(fontSize: 19),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: resetlista,
                            child: ListView.builder(
                              controller: controller,
                              itemCount: listaPersonalAux.length,
                              itemBuilder: (context, i) =>
                                  listas.cardHistrialTambosInter(
                                listaPersonalAux[i],
                                () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FichaIntervencion(
                                                  listaPersonalAux[i]
                                                      .idProgramacion!)));
                                },
                              ),
                            ))),
                    if (isLoading == true)
                      new Center(
                        child: const CircularProgressIndicator(),
                      )
                  ],
                );
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Eliminar", style: TextStyle(color: Colors.red[600])),
          Icon(
            Icons.delete,
            color: Colors.red[600],
            size: 32,
          )
        ],
      ));

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Row(
        children: [
          Text(
            "Editar",
            style: TextStyle(color: Colors.green[600]),
          ),
          Icon(
            Icons.edit,
            color: Colors.green[600],
            size: 32,
          )
        ],
      ));

  Future resetlista() async {
    // await ProviderTambok().listaTamboServicioIntervencionesGeneral(1, 10);
    pageIndexQ = 1;
    pageSizeQ = 2;
    await ProviderTambok().listaTamboServicioIntervencionesGeneral(
        pag: pageIndexQ, sizePag: pageSizeQ);

    setState(() {});
    /*   seleccionarMarca = "Seleccionar Marca";
    seleccionarModelo = "Seleccionar Modelo";
    seleccionarUbicacion = "Seleccionar Ubicacion";
    pageIndex = 1;
    filtroParqueInformatico.codigoPatrimonial = '';
    filtroParqueInformatico.denominacion = '';
    filtroParqueInformatico.idMarca = '';
    filtroParqueInformatico.idModelo = '';
    filtroParqueInformatico.idUbicacion = '';
    filtroParqueInformatico.responsableactual = '';
    filtroParqueInformatico.pageSize = 10;
    filtroParqueInformatico.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico()
          .listaParqueInformatico(filtroParqueInformatico);
    });*/
  }
}
