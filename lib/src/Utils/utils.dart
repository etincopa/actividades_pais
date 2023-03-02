import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class utils{
  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));

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

  showAlertDialogGC(titulo, BuildContext context, guardar, cancelar, texto) {
    Widget okButton = TextButton(child: Text("Guardar"), onPressed: guardar);
    Widget moButton = TextButton(child: Text("Cancelar"), onPressed: cancelar);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: TextField(controller: texto, maxLines: 8,maxLength: 255, decoration: InputDecoration( labelText: 'Observación',),),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogAprobar(titulo, BuildContext context, guardar, cancelar, texto) {
    Widget okButton = TextButton(child: Text("Confirmar"), onPressed: guardar);
    Widget moButton = TextButton(child: Text("Cancelar"), onPressed: cancelar);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text(texto),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}