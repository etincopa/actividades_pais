import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Archivos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Nacimiento.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class AgregarNacimiento extends StatefulWidget {
  String idUnicoReporte = '';

  AgregarNacimiento(this.idUnicoReporte, {super.key});

  @override
  State<AgregarNacimiento> createState() => _AgregarNacimientoState();
}

class _AgregarNacimientoState extends State<AgregarNacimiento> {
  Nacimiento nacimiento = Nacimiento();

  File? _image, _image2;
  String fotonomm1 = 'assets/imgBb1.png';
  String fotonomm2 = 'assets/imgbb2.jpg';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";
  Archivos ar = Archivos();
  List<String> listArchivo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listArchivo = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
        backgroundColor:AppConfig.primaryColor,
        title: const Text("Agregar Detalle Nacimiento"),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: 350,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppConfig.primaryColor),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (nacimiento.detalle == null) {
                        Util().showAlertDialog(
                            'Nacimientos', 'Ingresar el detalle', context, () {
                          Navigator.pop(context);
                        });
                      } else {
                        nacimiento.idUnicoReporte = widget.idUnicoReporte;
                        //   nacimiento.imagen2 = listArchivo[0].toString();
                        var aed =
                            await DatabasePias.db.insertNacimiento(nacimiento);
                        if (aed > 0) {
                          for (var i = 0; i < listArchivo.length; i++) {
                            ar.file = listArchivo[i].toString();
                            ar.idNacimiento = aed;
                            ar.idUnicoReporte = widget.idUnicoReporte;
                            await DatabasePias.db.insertArchivos(ar);
                          }
                        }
                        Navigator.pop(context, "nacimiento");
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            nacimiento.detalle = value;
                          },
                          maxLines: 5, //or null
                          decoration: const InputDecoration.collapsed(
                              hintText: "Agregar Detalle"),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 350,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppConfig.primaryColor),
                      ),
                      onPressed: () {
                        selectCamera();
                      },
                      child: const Text(
                        'Agregar Imagen',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                for (var i in listArchivo) _tomarImagen(i),

                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  _tomarImagen(i) {
    var i2 = i;
    i = File.fromUri(Uri.parse(i));
    return Container(
      child: Center(
        child: Stack(
          alignment: const Alignment(0.9, 1.1),
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.black87,
                child: GestureDetector(
                  onTap: () {
                    listArchivo.remove(i2);

                    print('delete image from List ${listArchivo.length} $i2');
                    setState(() {
                      print('set new state of images');
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              width: 300,
              margin: const EdgeInsets.only(right: 10.0, top: 30, left: 10.2),
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(100.0),
                // ignore: unnecessary_new
                child: new ClipRRect(
                    //  borderRadius: new BorderRadius.circular(100.0),
                    child: i == null
                        ? GestureDetector(
                            onTap: () {
                              //  selectCamera();
                            },
                            child: SizedBox(
                                height: 80.0,
                                width: 80.0,
                                // color: primaryColor,
                                child: FadeInImage.assetNetwork(
                                    placeholder: fotonomm1,
                                    imageErrorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(fotonomm1);
                                    },
                                    image: '')))
                        : GestureDetector(
                            onTap: () {
                              //  selectCamera();
                            },
                            child: SizedBox(
                              height: 80.0,
                              width: 80.0,
                              child: Image.file(
                                i!,
                                fit: BoxFit.cover,
                                height: 800.0,
                                width: 80.0,
                              ),
                            ))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

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

  Future cameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _image = File(image!.path);

    });
    listArchivo.add(_image!.path);
    // List<int> bytes = File(image.path).readAsBytesSync();
  }

  Future getImageLibrary() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _image = File(gallery!.path);
      // nacimiento.imagen1 = _image;
    });
    List<int> bytes = File(gallery!.path).readAsBytesSync();
    listArchivo.add(_image!.path.toString());
  }
}
