import 'package:actividades_pais/src/datamodels/Provider/PorviderLogin.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Intervenciones/EjecucionProgramacion.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/listaParaSincronizar/pendienteSincronizar.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../util/app-config.dart';

// ignore: must_be_immutable
class Intervenciones extends StatefulWidget {
//  int snip;
  // List<int> snips =[];
  String unidadTerritorial;
  String snip="";
  bool anterior = false;

  Intervenciones(this.unidadTerritorial,{super.key, this.snip=""});

  @override
  State<Intervenciones> createState() => _IntervencionesState();
}

class _IntervencionesState extends State<Intervenciones> {
  ProviderDatos provider = ProviderDatos();
  Listas listas = Listas();

  bool anterior = false;
  bool _isloading = false;
  bool loadPart = false;
  bool cargardialog = false;
  var todoParticiw = 0;
  var cargarBarra = 0;
  var isInternet = false;
  var isTab = true;

  @override
  void initState() {
    CalcularParticipantes();
    internet();
    cargarDatosIntervenciones();
    super.initState();
//    refreshList();
    CalcularParticipantes();
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 0));
    cargarIntervenciones();
    setState(() {});
  }

  internet() async {
    var chc = await ProviderLogin().checkInternetConnection();
    setState(() {});
    return chc;
  }

  @override
  Widget build(BuildContext context) {
    print(todoParticiw);

    if (todoParticiw == 0) {
      setState(() {
        _isloading = true;
      });

      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppConfig.primaryColor,
            leading:
                Util().iconbuton(() => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomePagePais()),
                    )),
            title: const Text("Intervenciones"),
          ),
          body: esperadecara(
              "Cargando informacion de usuarios de la region, un momento por favor."));
    }
    return WillPopScope(
      onWillPop: systemBackButtonPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppConfig.primaryColor,
          leading: Util().iconbuton(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePagePais()),
              )),
          title: Text(
            "EJECUCION INTERVENCION",
            style: TextStyle(color: AppConfig.letrasColor, fontSize: 12),
          ),
          actions: [accionesBotones()],
        ),
        body: FutureBuilder<List<TramaIntervencion>>(
          future: DatabasePr.db.listarInterciones(snip: widget.snip),
          builder: (BuildContext context,
              AsyncSnapshot<List<TramaIntervencion>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                final listaPersonalAux = snapshot.data;

                if (listaPersonalAux!.isEmpty) {
                  return esperadecara(
                      'Espere un momento... \nEl aplicativo esta recuperando las '
                      'intervenciones de su tambo...');
                } else {
                  return lista(listaPersonalAux);
                }
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
    /* WillPopScope(
      onWillPop: systemBackButtonPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppConfig.primaryColor,
          leading: Util().iconbuton(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePagePais()),
              )),
          title: Text(
            "EJECUCION INTERVENCION",
            style: TextStyle(color: AppConfig.letrasColor, fontSize: 12),
          ),
          actions: [accionesBotones()],
        ),
        body: FutureBuilder<List<TramaIntervencion>>(
          future: DatabasePr.db.listarInterciones(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TramaIntervencion>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                final listaPersonalAux = snapshot.data;

                if (listaPersonalAux!.length == 0) {
                  return esperadecara(
                      'Espere un momento... \nEl aplicativo esta recuperando las '
                      'intervenciones de su tambo...');
                } else {
                  return lista(listaPersonalAux);
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );*/
  }

  Widget esperadecara(texto) {
    return Center(
      child: _isloading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/loading_icon.gif",
                  height: 125.0,
                  width: 200.0,
                  //color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      height: 100,
                      width: 250,
                      child: Text(
                        texto,
                        style: const TextStyle(fontSize: 17),
                      ),
                    )
                  ],
                ),
              ],
            )
          : const Text(
              'No hay intervenciones',
              style: TextStyle(fontSize: 19),
            ),
      //Text("No hay informacion"),
    );
  }

/*  eliminarArchivoParticipantes() async {
    var ar = [];
    showAlertDialogBarra(context, titulo: 'Participantes', presse: () async {
      loadPart = true;
      Navigator.pop(context);
      setState(() {});
      var chc = await ProviderLogin().checkInternetConnection();
      if (chc == true) {
        ar = await ProviderDatos()
            .getInsertParticipantesIntervencionesMovilMundo(
                widget.unidadTerritorial);
      }
      setState(() {
        cargardialog = false;
      });
      loadPart = false;
    }, pressno: () {
      Navigator.pop(context);
    },
        texto:
            '¿Estas seguro de eliminar los datos existentes para sincronizar nuevos participantes',
        a: cargardialog);
    setState(() {});
    if (ar.length > 1) {
      loadPart = false;
    }
  }*/
  eliminarArchivoParticipantes() async {
    var ar = [];
    showAlertDialogBarra(context, titulo: 'Participantes', presse: () async {
      loadPart = true;
      Navigator.pop(context);
      setState(() {});
      var chc = await ProviderLogin().checkInternetConnection();
      if (chc == true) {
        ar = await ProviderDatos()
            .getInsertParticipantesIntervencionesMovilMundo(
                widget.unidadTerritorial);
      }
      setState(() {
        cargardialog = false;
      });
      loadPart = false;
    }, pressno: () {
      Navigator.pop(context);
    },
        texto:
            '¿Estas seguro de eliminar los datos existentes para sincronizar nuevos participantes',
        a: cargardialog);
    if (ar.length > 1) {
      loadPart = false;
    }
  }

  /* cargarDatosIntervenciones() async {
    var chc = await ProviderLogin().checkInternetConnection();
    if (chc == true) {
      setState(() {
        _isloading = true;
      });
      await DatabasePr.db.eliminarProvincias();
      var data = await DatabasePr.db.getAllTasksConfigInicio();

      if (data[0].unidTerritoriales != null) {
        await ProviderDatos().getInsertParticipantesIntervencionesMovil(
            data[0].unidTerritoriales);
        await ProviderDatos().getInsertFuncionariosIntervencionesMovil();
        await ProviderDatos().getInsertPersonasFallecidas();
        await CalcularParticipantes();
        await cargarIntervenciones();
        setState(() {
          _isloading = false;
        });
        await ProviderDatos().guardarProvincia(data[0].snip);
      }
    } else {
      setState(() {
        _isloading = false;
      });
    }
  }*/

  cargarDatosIntervenciones() async {
    var hasInternet = await ProviderLogin().checkInternetConnection();
    if (!hasInternet) {
      setState(() {
        _isloading = false;
      });
      return;
    }

    setState(() {
      _isloading = true;
    });

    await DatabasePr.db.eliminarProvincias();
    var data = await DatabasePr.db.getAllTasksConfigInicio();
    await ProviderDatos()
        .getInsertParticipantesIntervencionesMovil(data[0].unidTerritoriales, ut: widget.unidadTerritorial);
    await ProviderDatos().getInsertFuncionariosIntervencionesMovil();
    await ProviderDatos().getInsertPersonasFallecidas();
    await CalcularParticipantes();
    await cargarIntervenciones();
    await ProviderDatos().guardarProvincia(data[0].snip, snippre: widget.snip);
    setState(() {
      _isloading = false;
    });


  }

/*

  cargarIntervenciones() async {
    var chc = await ProviderLogin().checkInternetConnection();

    if (chc == true) {
      setState(() {
        _isloading = true;
      });
    //  await eliminarintervenciones();
      var data = await DatabasePr.db.getAllTasksConfigInicio();

      for (var i = 0; i < data.length; i++) {
        var a = await provider.getListaTramaIntervencion(data[i].snip);
        if (a.length == 0) {
          _isloading = false;
          isTab = true;
          setState(() {});
        }
        if (a.length > 0) {
          await DatabasePr.db.listarInterciones();
          _isloading = false;
          isTab = true;
          setState(() {});
        }
      }
    } else {
      setState(() {
        _isloading = false;
        isTab = true;
      });
    }
  }

*/
  cargarIntervenciones() async {
    var isConnected = await ProviderLogin().checkInternetConnection();
    if (isConnected) {
      setState(() => _isloading = true);
      // await eliminarintervenciones();

      var data = await DatabasePr.db.getAllTasksConfigInicio();
      for (var i = 0; i < data.length; i++) {
        var a = await provider.getListaTramaIntervencion(data[i].snip,snippre:  widget.snip);

        if (a.isEmpty) {
          _isloading = false;
          isTab = true;
          setState(() {});
        } else {
          await DatabasePr.db.listarInterciones();
          _isloading = false;
          isTab = true;
          setState(() {});
        }
      }
    } else {
      setState(() {
        _isloading = false;
        isTab = true;
      });
    }
  }

  eliminarintervenciones() async {
    await DatabasePr.db.deleteIntervenciones();
    await DatabasePr.db.eliminarTodoEntidadFuncionario();
    await DatabasePr.db.eliminarTodoParticipanteEjecucion();
    setState(() {});
  }

  CalcularParticipantes() async {
    var todoPartici = await Servicios().loadParticipantes();
    if (todoPartici != null) {
      todoParticiw = todoPartici.length;
      setState(() {});
    }
  }

  accionesBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        loadPart
            ? Image.asset(
                "assets/loaderios.gif",
                height: 40.0,
                width: 50.0,
                //color: Colors.transparent,
              )
            : Container(),
        if (todoParticiw <= 0) ...[
          InkWell(
            child: const Icon(
              Icons.vpn_lock,
              color: Colors.red,
            ),
            onTap: () async {
              //   CalcularParticipantes();

              var ar = [];
              showAlertDialogBarra(context, titulo: 'Participantes',
                  presse: () async {
                loadPart = true;
                Navigator.pop(context);
                setState(() {
                  cargardialog = true;
                });
                var chc = await ProviderLogin().checkInternetConnection();
                if (chc == true) {
                  ar = await ProviderDatos()
                      .getInsertParticipantesIntervencionesMovilMundo(
                          widget.unidadTerritorial);
                }

                Navigator.pop(context);
                loadPart = false;
              }, pressno: () {
                Navigator.pop(context);
              },
                  texto:
                      '¿Estas seguro de eliminar los datos existentes para sincronizar nuevos participantes',
                  a: cargardialog);
              setState(() {});
              if (ar.length > 1) {
                loadPart = false;
              }
            },
          )
        ] else ...[
          InkWell(
            child: const Icon(
              Icons.vpn_lock,
              color: Colors.green,
            ),
            onTap: () async {
              await eliminarArchivoParticipantes();
              //setState(() {});
            },
          ),
        ],
        const SizedBox(
          width: 4,
        ),
        InkWell(
          child: const Icon(Icons.delete),
          onTap: () async {
            await eliminarintervenciones();

            ///refreshList();
          },
        ),
        const SizedBox(
          width: 10,
        ),
        isTab
            ? InkWell(
                child: const Icon(Icons.cloud_download_sharp),
                onTap: () async {
                  isTab = false;
                  setState(() {});
                  await cargarIntervenciones();
                },
              )
            : Container(),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          child: const Icon(Icons.cloud_upload),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PendienteSincronizar()),
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

/*  lista(listaPersonalAux) {
    return Container(
      child: RefreshIndicator(
          child: ListView.builder(
            itemCount: listaPersonalAux.length,
            itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                child: listas.cardIntervenciones(
                  listaPersonalAux[i],
                  () async {
                    final respt = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EjecucionProgramacionPage(
                              idProgramacion: int.parse(
                                  listaPersonalAux[i].codigoIntervencion!),
                              descripcionEvento:
                                  listaPersonalAux[i].descripcionEvento!,
                              //   snip: widget.snip,
                              programa: listaPersonalAux[i].programa!,
                              tramaIntervencion: listaPersonalAux[i])),
                    );
                    if (respt == 'ok') {
                      print("aqioioo");
                      refreshList();
                    }
                  },
                ),
                background: buildSwipeActionLeft(),
                secondaryBackground: buildSwipeActionRigth(),
                onDismissed: (direction) async {
                  switch (direction) {
                    case DismissDirection.endToStart:
                      break;
                    case DismissDirection.startToEnd:
                      break;
                  }
                }),
            /*   itemBuilder: (context, i) =>
                              _banTitle(listaPersonalAux[i]), */
          ),
          onRefresh: refreshList),
    );
  }*/
  lista(List<TramaIntervencion> listaPersonalAux) {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: ListView.separated(
        itemCount: listaPersonalAux.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          final personal = listaPersonalAux[i];
          return Dismissible(
            key: UniqueKey(),
            background: buildSwipeActionLeft(),
            secondaryBackground: buildSwipeActionRigth(),
            onDismissed: (direction) {
              // switch (direction) {
              //   case DismissDirection.endToStart:
              //     break;
              //   case DismissDirection.startToEnd:
              //     break;
              // }
            },
            child: listas.cardIntervenciones(
              personal,
              () => _navigateToEjecucionProgramacionPage(personal),
            ),
          );
        },
      ),
    );
  }

  Future<void> _navigateToEjecucionProgramacionPage(
      TramaIntervencion personal) async {
    final respt = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EjecucionProgramacionPage(
          idProgramacion: int.parse(personal.codigoIntervencion!),
          descripcionEvento: personal.descripcionEvento!,
          programa: personal.programa!,
          tramaIntervencion: personal,
        ),
      ),
    );
    if (respt == 'ok') {
      refreshList();
    }
  }

  showAlertDialogBarra(BuildContext context,
      {titulo, presse, pressno, texto, bool a = false}) {
    Widget okButton = TextButton(onPressed: presse, child: const Text("SI"));
    Widget moButton = TextButton(onPressed: pressno, child: const Text("NO"));
    AlertDialog alert = AlertDialog(
      title: Text("$titulo "),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            Text("$texto."),
            a
                ? Image.asset(
                    "assets/loaderios.gif",
                    height: 40.0,
                    width: 50.0,
                    //color: Colors.transparent,
                  )
                : Container(),
          ],
        ),
      ),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.delete,
        color: Colors.red[600],
        size: 32,
      ));

  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.delete,
        color: Colors.red[600],
        size: 32,
      ));

  Future<bool?> _onWillPopScope() {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePagePais()),
    );
  }

  Future<bool> systemBackButtonPressed() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePagePais()));
    return true;
  }
}
