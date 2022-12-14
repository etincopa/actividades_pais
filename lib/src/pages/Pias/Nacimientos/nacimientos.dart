import 'dart:io';

import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Archivos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Nacimiento.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Pias/Nacimientos/agregarNacimiento.dart';
import 'package:intl/intl.dart';
import 'package:actividades_pais/src/pages/Pias/Nacimientos/editarNacimiento.dart';

class Nacimientos extends StatefulWidget {
  String idUnicoReporte = '';

  Nacimientos(this.idUnicoReporte);

  @override
  _NacimientosState createState() => _NacimientosState();
}

class _NacimientosState extends State<Nacimientos> {
  Nacimiento nacimiento = Nacimiento();

  //var _image, _image2, _image3;
  String fotonomm = 'assets/imgBb1.png';
  String fotonomm2 = 'assets/imgbb2.jpg';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarArchivos();
  }
  cargarArchivos()async{
    //var nca = await DatabasePias.db.traerArchivo(widget.idUnicoReporte);
    //print(nca[0].file);
    /// print(nca[].)
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.cyan,
        onPressed: () async {
          final respuesta = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AgregarNacimiento(widget.idUnicoReporte)),
          );
          if (respuesta.toString() == 'nacimiento') {
            await refreshList();
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: FutureBuilder<List<Nacimiento>>(
            future: DatabasePias.db.ListarNacimientoPias(widget.idUnicoReporte),
            builder: (BuildContext context,
                AsyncSnapshot<List<Nacimiento>> snapshot) {
              Nacimiento? depatalits;
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final preguntas = snapshot.data;
              if (preguntas!.length == 0) {
                return Center(
                  child: Text("sin dato"),
                );
              } else {
                return Container(
                  child: ListView.builder(
                    itemCount: preguntas.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) => _bandTile(preguntas[i]),
                  ),
                );
              }
            },
          )),
    );
  }

 iamgenes(s){
    print("aqui $s");
   s = File.fromUri(Uri.parse(s));
  return Card(
     semanticContainer: true,
     clipBehavior: Clip.antiAliasWithSaveLayer,
     child: Image.file(
      s,
       fit: BoxFit.fill,
     ),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10.0),
     ),
     elevation: 5,
     margin: EdgeInsets.all(10),
   );
 }

  _tomarImagen(imag) {
    print(imag);
    if (imag != null) {
      imag = File.fromUri(Uri.parse(imag));
    }
    return Center(
      child: Stack(
        alignment: Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 400,
            width: 350,
            margin: EdgeInsets.only(right: 10.0, bottom: 10, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new Container(
              height: 80.0,
              width: 80.0,
              child: Image.file(
                imag!,
                fit: BoxFit.cover,
                height: 800.0,
                width: 90.0,
              ),
            )),
            ),
        ],
      ),
    );
  }


  Widget _bandTile(Nacimiento band) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direccion) {
        DatabasePias.db.eliminarNacimiento(band.id);
        setState(() {});
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Eliminar ?',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: InkWell(
        onTap: () async {
          final respuesta = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditarNacimiento(
                      idUnicoReporte: widget.idUnicoReporte,
                      detalle: band.detalle!,

                  id: band.id!,
                    )),
          );
          if (respuesta.toString() == 'nacimiento') {
            await refreshList();
            setState(() {});
          }
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(9),
                child: Text(
                  " ${band.detalle}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),

            FutureBuilder<List<Archivos>>(
              future: DatabasePias.db.traerArchivos(widget.idUnicoReporte,band.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Archivos>> snapshot) {
                Archivos? depatalits;
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final preguntas = snapshot.data;
                if (preguntas!.length == 0) {
                  return Center(
                    child: Text("sin dato"),
                  );
                } else {
                  return Container(
                    height: 150,
                   // width: 1000,
                   // margin: EdgeInsets.only(left: 10, right: 10,),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: preguntas.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) => SizedBox(
                        width: 150,
                        child:  _tomarImagen(preguntas[i].file),
                      ),
                    ),
                  );
                }
              },
            ),

            ],
          ),
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      DatabasePias.db.ListarNacimientoPias(widget.idUnicoReporte);
    });
  }
}
