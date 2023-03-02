import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Util {
  static Future cameraImage(image64) async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 700);
    var _imageby = File(image!.path);
    var _image = File(image.path);
    List<int> bytes = File(_imageby.path).readAsBytesSync();
    image64 = base64Encode(bytes);
    return _image;
    // DatabasePr.db.insertArchivoTramaIntervencion(tramaIntervencion);
    //print(image64);
  }

  showAlertDialogEliminar(titulo, BuildContext context, presse, pressno) {
    Widget okButton = TextButton(child: Text("OK"), onPressed: presse);
    Widget moButton = TextButton(child: Text("NO"), onPressed: pressno);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text("Estas seguro de eliminar este registro "),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialogokno(titulo, BuildContext context, presse, pressno, texto) {
    Widget okButton = TextButton(child: Text("SI"), onPressed: presse);
    Widget moButton = TextButton(child: Text("NO"), onPressed: pressno);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text("$texto."),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  showAlertDialog(titulo, text, BuildContext context, presse) {
    Widget okButton = TextButton(child: Text("OK"), onPressed: presse);

    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text(text),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialogRef(BuildContext context) {

 //  Widget okButton = TextButton(child: Text("OK"), onPressed: presse);

    AlertDialog alert = AlertDialog(
   //   title: Text(titulo),
      content: CircularProgressIndicator(),

     // actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialogAgregar(titulo, BuildContext context, presse, pressno, controllerNovedad) {
    Widget okButton = TextButton(child: Text("Guardar"), onPressed: presse);
    Widget moButton = TextButton(child: Text("Cancelar"), onPressed: pressno);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: controllerNovedad,
        maxLines: 5, //or null
        decoration: InputDecoration.collapsed(hintText: "Insertar detalle"),
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

  iconbuton(press) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: press);
  }


  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.delete,
        color: Colors.red[600],
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.delete,
        color: Colors.red[600],
        size: 32,
      ));
}
