import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';

import 'package:flutter/material.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  ProviderServicios providerServicios = ProviderServicios();
  // ProviderServicios providerServicios = new ProviderServicios();
  @override
  void initState() {
    providerServicios.requestSqlData();
    // TODO: implement initState
    getToken();
    super.initState();
  }

  var cantidad = 0;

/*  mostrarDatos() async {
    _datdb.initDB();
    var abc = await _datdb.getAllTasks();
    cantidad = abc.length;

    print(cantidad);

    if (cantidad == 0) {
      // providerServicios.requestSqlData();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home_Asis()));
    }
  } */

  mostrarInicio() {
 /*   Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ConfiguracionInicial()));*/
  }

  Future<int> getToken() async {
    await Future.delayed(const Duration(seconds: 4))
        .then((value) => mostrarInicio());
    // var abc = await _datdb.getAllTasks();

    return cantidad;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      // mostrarDatos();
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
