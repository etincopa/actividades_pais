import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/src/datamodels/Clases/CierreUsuario.dart';
import 'package:actividades_pais/src/datamodels/Clases/UbicacionUsuario.dart';
import 'package:actividades_pais/src/datamodels/Formulario/FormularioReq.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

// ignore: must_be_immutable
class CierreActividadesPage extends StatefulWidget {
  dynamic dni,
      latitud,
      longitud,
      fechaHora,
      snip,
      idLugarDeprestacion,
      idUnidTerritoriales,
      idUnidadesOrganicas,
      idPlataforma;
  CierreActividadesPage(
      {super.key, this.dni,
      this.latitud,
      this.longitud,
      this.fechaHora,
      this.snip,
      this.idLugarDeprestacion,
      this.idUnidTerritoriales,
      this.idUnidadesOrganicas,
      this.idPlataforma});
  static Color primaryColor = const Color(0xFF3949AB);

  @override
  State<CierreActividadesPage> createState() => _CierreActividadesPageState();
}

class _CierreActividadesPageState extends State<CierreActividadesPage> {
  final TextEditingController _controllerNDocumento = TextEditingController();

  final TextEditingController _controllerApPaterno = TextEditingController();

  final TextEditingController _controllerApMaterno = TextEditingController();

  final TextEditingController _controllerNombres = TextEditingController();

  final TextEditingController _controllerCargo = TextEditingController();

  final TextEditingController _controller = TextEditingController();

  var _image;

  File? _imageby;
  String image64 = '';

  String fotonomm = 'assets/imagenatencion.png';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";

  ProviderDatos provider = ProviderDatos();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[800],
            leading: Util().iconbuton(() => Navigator.of(context).pop()),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Actividad"),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: FormularioReq().myBoxDecoration(),
                    child: TextField(
                      maxLines: 8, //or
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      // textCapitalization: TextCapitalization.words,
                      controller: _controller,
                      enabled: true,
                      //obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CierreActividadesPage.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CierreActividadesPage.primaryColor),
                        ),

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CierreActividadesPage.primaryColor),
                        ),
                        labelText: "Descripcion de Actividad Realizada",

                        //   suffixIcon: Icon(Icons.https, color: primaryColor)
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[const SizedBox(height: 20.0), _tomarImagen],
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3949AB),
                        ),
                        child: const Text(
                          "REGISTRAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_controller.text == "") {
                            Fluttertoast.showToast(
                                msg: "Ingresar Datos",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            var r = CierreUsuario(
                                idUnidadesOrganicas: widget.idUnidadesOrganicas,
                                idPlataforma: widget.idPlataforma,
                                idUnidTerritoriales: widget.idUnidTerritoriales,
                                descripcion: _controller.text,
                                imagen: image64,
                                dni: widget.dni,
                                fechaHora: DateFormat('yyyy-MM-dd HH:mm:s')
                                    .format(DateTime.now()),
                                latitud: widget.latitud,
                                longitud: widget.longitud,
                                snip: widget.snip,
                                idLugarDeprestacion:
                                    widget.idLugarDeprestacion);
                            var sd = await provider.guardarCierre(r);

                            await DatabasePr.db.inserCierreUsuario(r);

                            var a = UbicacionUsuario(
                                actividad: "",
                                snip: 0,
                                dni: "",
                                latitud: "",
                                longitud: "",
                                fechaHora: DateTime.now().toString(),
                                tipo: 0);
                            await DatabasePr.db.inserUbicacionUsuario(a);

                            if (sd == "200") {
                              Fluttertoast.showToast(
                                  msg: "Registro Exitoso",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context, 'OK');
                            }
                          }
                        }),
                  )
                ],
              )),
        ));
  }

  Widget get _tomarImagen {
    return Center(
      child: Stack(
        alignment: const Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
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
          /*  GestureDetector(
            onTap: () {
              // _tomarFotografia(context);
              selectCamera();
              setState(() {});
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Tomar imagen"),
              ));
            },
            child: Container(
              margin: EdgeInsets.only(//top: ,
                  //   right: 3.0,
                  //    left: 16.0
                  ),
              child: Icon(
                Icons.add_a_photo,
                color: Colors.cyan,
              ),
            ),
          ) */
        ],
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

  Future getImageLibrary() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _imageby = File(gallery!.path);
      _image = gallery;
    });
    List<int> bytes = File(_imageby!.path).readAsBytesSync();
    image64 = base64Encode(bytes);
  }

  Future cameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _imageby = File(image!.path);

      _image = File(image.path);
    });
    List<int> bytes = File(_imageby!.path).readAsBytesSync();

    image64 = base64Encode(bytes);
    print(image64);
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
}
