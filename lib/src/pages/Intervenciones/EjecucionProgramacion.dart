import 'dart:convert';
import 'dart:io';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:actividades_pais/src/datamodels/Clases/ArchivoTramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Extrangeros/ListaExtrangeros.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Funcionarios/listaFuncionarios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Participantes/ListaParticipantes.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../util/app-config.dart';

// ignore: must_be_immutable
class EjecucionProgramacionPage extends StatefulWidget {
  int idProgramacion;
  String descripcionEvento;
  int snip;
  String programa;
  TramaIntervencion tramaIntervencion;

  EjecucionProgramacionPage(
      {super.key, this.idProgramacion = 0,
      this.descripcionEvento = '',
      this.snip = 0,
      this.programa = '',
      required this.tramaIntervencion});

  @override
  State<EjecucionProgramacionPage> createState() =>
      _EjecucionProgramacionPageState();
}

class _EjecucionProgramacionPageState extends State<EjecucionProgramacionPage> {
  ProviderDatos provider = ProviderDatos();
  int currenIndex = 0;
  Listas listas = Listas();
  File? _imageby;
  String image64 = '';
  Util util = Util();
  File? _image, _image2, _image3;
  ArchivoTramaIntervencion archivoTramaIntervencion =
      ArchivoTramaIntervencion();
  String fotonomm = 'assets/imagenatencion.png';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";

  @override
  void initState() {
    super.initState();
    cargarFotos();
  }

  cargarFotos() async {
    var rws = await DatabasePr.db.listarImagenesDB(widget.idProgramacion);
    if (rws.length == 1) {
      _image = File.fromUri(Uri.parse(rws[0].file.toString()));
    } else if (rws.length == 2) {
      _image = File.fromUri(Uri.parse(rws[0].file.toString()));
      _image2 = File.fromUri(Uri.parse(rws[1].file.toString()));
    } else if (rws.length == 3) {
      _image = File.fromUri(Uri.parse(rws[0].file.toString()));
      _image2 = File.fromUri(Uri.parse(rws[1].file.toString()));
      _image3 = File.fromUri(Uri.parse(rws[2].file.toString()));
    }

    setState(() {});
  }

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  // ignore: non_constant_identifier_names
  Future<void> listaFuniconario() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      DatabasePr.db.listarFuncionarios(widget.idProgramacion);
    });
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 0));
    await DatabasePr.db.listarFuncionarios(widget.idProgramacion);

    await DatabasePr.db.listarPartExtrangeros(widget.idProgramacion);
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: (Colors.red[600]!)),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List listPages = [
      Container(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Container(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    miCard('Programa: ${widget.tramaIntervencion.programa}'
                        "\n"
                        "\n"
                        'Hora Inicio: ${widget.tramaIntervencion.horaInicio} - '
                        'Hora Fin: ${widget.tramaIntervencion.horaFin}'
                        '\n'
                        '${widget.tramaIntervencion.tipoIntervencion}'),
                    const SizedBox(
                      height: 0,
                    ),
                    miCard(widget.descripcionEvento),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text("Adjuntar Imagenes"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        _tomarImagen(),
                        _tomarImagen2()
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        _tomarImagen3()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ListaFuncionariosVw(widget.tramaIntervencion),
      ListaParticipantesVw(widget.idProgramacion, widget.snip),
      ListaExtrangeros(widget.idProgramacion)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.primaryColor,
        title: Text(
          "EJECUCION INTERVENCION \n${widget.idProgramacion}",
          style: TextStyle(fontSize: 17, color: AppConfig.letrasColor),
        ),
        leading:
        Util().iconbuton(() => Navigator.of(context).pop()),

        actions: [
          InkWell(
            child: const Icon(Icons.save),
            onTap: () {
              Util().showAlertDialogokno('Ejecucion Programacion', context,
                  () async {
                DatabasePr.db
                    .insertTramaIntervencionesUs(widget.tramaIntervencion);
                /*  await
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => Intervenciones(    int.parse(
                    widget.tramaIntervencion.snip!))));*/
                /* await  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>  Intervenciones(    int.parse(
                widget.tramaIntervencion.snip!))));*/
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => Intervenciones(
                            '')),
                );
              }, () {
                Navigator.pop(context);
              }, '¿Estas seguro de guardar los datos para sincronizarlos?');
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: listPages[currenIndex],
      bottomNavigationBar: BottomNavyBar(
        //   items: items,
        selectedIndex: currenIndex,

        onItemSelected: (index) {
          setState(() {
            currenIndex = index;
          });
        },

        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Inicio"),
              activeColor:const Color(0xFF78b8cd),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.engineering),
              title: const Text("Funcionarios"),
              activeColor: const Color(0xFF78b8cd),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.people_alt),
              title: const Text("Participantes"),
              activeColor: const Color(0xFF78b8cd),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.person_sharp),
              title: const Text("Extranjeros"),
              activeColor: const Color(0xFF78b8cd),
              inactiveColor: Colors.black),
        ],
      ),
    );
  }

  _tomarImagen() {
    return Center(
      child: Stack(
        alignment: const Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image == null
                      ? GestureDetector(
                          onTap: () {
                            selectCamera();
                          },
                          child: SizedBox(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : GestureDetector(
                          onTap: () {
                            selectCamera();
                          },
                          child: SizedBox(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }

  _tomarImagen2() {
    return Center(
      child: Stack(
        alignment: const Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image2 == null
                      ? GestureDetector(
                          onTap: () {
                            selectCamera2();
                          },
                          child: SizedBox(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : GestureDetector(
                          onTap: () {
                            selectCamera2();
                          },
                          child: SizedBox(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image2!,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }

  _tomarImagen3() {
    return Center(
      child: Stack(
        alignment: const Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image3 == null
                      ? GestureDetector(
                          onTap: () {
                            selectCamera3();
                          },
                          child: SizedBox(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : GestureDetector(
                          onTap: () {
                            selectCamera3();
                          },
                          child: SizedBox(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image3!,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }

  // Widget get _tomarImagen {}

  selectCamera() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
            child: const Text('Cancelar'),
          )),
    );
  }

  selectCamera2() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage2();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary2();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
            child: const Text('Cancelar'),
          )),
    );
  }

  selectCamera3() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage3();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary3();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
            child: const Text('Cancelar'),
          )),
    );
  }

  void showDemoActionSheet({BuildContext? context, Widget? child}) {
    showCupertinoModalPopup<String>(
      context: context!,
      builder: (BuildContext context) => child!,
    ).then((String? value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  Future getImageLibrary() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _image = File(gallery!.path);
    });
    List<int> bytes = File(gallery!.path).readAsBytesSync();

    ///image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = gallery.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 1;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 1);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future cameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _image = File(image!.path);
    });
    List<int> bytes = File(image!.path).readAsBytesSync();
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 1);
    print('aquii $image64');
    //image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = image.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 1;

    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future getImageLibrary2() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _image2 = File(gallery!.path);
     // _image2 = gallery;
      //_image2 = gallery;
    });
    List<int> bytes = File(gallery!.path).readAsBytesSync();
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 2);

    /// image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = gallery.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 2;

    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future cameraImage2() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      ///  _imageby = File(image.path);
      _image2 = File(image!.path);
    });
    List<int> bytes = File(image!.path).readAsBytesSync();

    //image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = image.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 2;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 2);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  ///
  Future getImageLibrary3() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
   //   _image3 = gallery;
      _image3 = File(gallery!.path);
    });
    List<int> bytes = File(gallery!.path).readAsBytesSync();
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = gallery.path.toString();
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 3;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 3);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future cameraImage3() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _image3 = File(image!.path);
    });
    List<int> bytes = File(image!.path).readAsBytesSync();
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = image.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 3;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 3);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Card miCard(texto) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
             subtitle: Text(texto),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
