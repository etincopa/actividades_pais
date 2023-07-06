import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Archivos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/ArchivosEvidencia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Nacimiento.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/mostarFoto.dart';

import '../../../../util/app-config.dart';

class Evidencias extends StatefulWidget {
  String idUnicoReporte = '';

  Evidencias(this.idUnicoReporte, {super.key});

  @override
  State<Evidencias> createState() => _EvidenciasState();
}

class _EvidenciasState extends State<Evidencias> {
  Nacimiento nacimiento = Nacimiento();
  List<ArchivosEvidencia> listArc = [];
  File? _image;
  String lastSelectedValue = "";
  Archivos ar = Archivos();
  List<ArchivosEvidencia> listArchivo = [];

  @override
  void initState() {
    super.initState();
    listArchivo = [];
    taerArchivos();
  }

  taerArchivos() async {
    listArc = await DatabasePias.db.listarArchivosUnico(widget.idUnicoReporte);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            selectCamera();
          },
          backgroundColor: AppConfig.primaryColor,
          child: const Icon(Icons.camera_enhance_rounded)),
      body: Container(
      //  color: Colors.black,
        child: ListView(

          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  for (var i in listArc) tomarImagen(i.file),

                  const SizedBox(
                    height: 10,
                  ),
                  // _tomarImagen2(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tomarImagen(i) {
    var i2 = i;
    i = File.fromUri(Uri.parse(i));
    return Container(
      margin: const EdgeInsets.only(top: 5),
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
                  onTap: () async {
                    await DatabasePias.db.eliminarArchivoEvPorId(i2);
                    await taerArchivos();
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.only(right: 1.0, top: 30, left: 10.2),
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(100.0),
                // ignore: unnecessary_new
                child: new ClipRRect(
                    //  borderRadius: new BorderRadius.circular(100.0),
                    child: GestureDetector(
                        onTap: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagenMostar(
                                        imagen: i2,
                                      )));
                        },
                        child: PhotoView(
                          imageProvider: FileImage(File(i2!)),
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
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 700);
   // _image = File(image!.path);


    ArchivosEvidencia ar = ArchivosEvidencia();
    ar.file = image!.path;
    ar.idUnicoReporte = widget.idUnicoReporte;
    await DatabasePias.db.insertArchivosEv(ar);
    await taerArchivos();
    setState(() {
    });
  }

  Future getImageLibrary() async {
    var gallery =
        await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 700);
  //  _image =  File(gallery!.path);

/*    setState(() {
     });*/
    ArchivosEvidencia ar2 = ArchivosEvidencia();
    ar2.file = gallery!.path.toString();
    ar2.idUnicoReporte = widget.idUnicoReporte;
    await DatabasePias.db.insertArchivosEv(ar2);

    await taerArchivos();
    setState(() {
    });
  }
}
