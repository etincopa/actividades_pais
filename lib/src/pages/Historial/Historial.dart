import 'package:actividades_pais/src/datamodels/Clases/Reportehistorial.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistorialPage extends StatefulWidget {
  String dni;
  HistorialPage({super.key, this.dni = ''});
  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  var cantidad = 0;
  final ProviderDatos _provider = ProviderDatos();
  Future traertodo() async {
    await _provider.getLista();
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      // _provider.getLista();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  traertodo();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      traertodo();
    });
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.indigo[900],
          title: const Text(
            'Historial Registros',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 1,
        ),
        body: FutureBuilder<List<ReporteHistorial>>(
          future: _provider.getLista(dni: widget.dni),
          builder: (BuildContext context,
              AsyncSnapshot<List<ReporteHistorial>> snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("¡No existen registros!"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            final listaPersonalAux = snapshot.data;

            if (listaPersonalAux!.isEmpty) {
              return const Center(
                child: Text("No hay informacion"),
              );
            } else {
              return Container(
                  child: RefreshIndicator(
                      onRefresh: refreshList,
                      child: ListView.builder(
                        itemCount: listaPersonalAux.length,
                        itemBuilder: (context, i) {
                          return _banTitle(listaPersonalAux[i]);
                        },
                      )));
            }
          },
        ));
  }

  ListTile _banTitle(ReporteHistorial band) {
    // final value = "19/56565-D4";

    //2022-01-25 18:00:37.516914

    String fecha = '${band.fechaSeguimiento} ${band.horaSeguimiento}';
    var now = DateTime.now().toString();
    //value.replaceAll(".0000000", "").replaceAll("", "");
    // var now = new DateTime.now().toString();
    var formatter = DateFormat('dd-MM-yyyy');
    //   String
    String formattedTime =
        DateFormat('dd-MM-yyyy kk:mm:a').format(DateTime.parse(fecha));
    //String formattedDate = formatter.format(now);
    print(formattedTime);
    // print(formattedDate);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.indigo[900],
        child: const Icon(
          Icons.calendar_today_outlined,
          color: Colors.white,
        ),
      ),
      title: Text('${band.nombreTipoCheck} ($formattedTime)',
          style: const TextStyle(fontSize: 13)),
      subtitle: Text('${band.tipoTrabajo}', style: const TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.info,
              color: Colors.indigo[900],
            ),
          ),
        ],
      ),
    );
  }
}
