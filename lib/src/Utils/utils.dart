import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class utils {
  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));

  showAlertDialog(titulo, text, BuildContext context, presse) {
    Widget okButton = TextButton(child: const Text("OK"), onPressed: presse);

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
    Widget okButton =
        TextButton(child: const Text("Guardar"), onPressed: guardar);
    Widget moButton =
        TextButton(child: const Text("Cancelar"), onPressed: cancelar);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: TextField(
        controller: texto,
        maxLines: 8,
        maxLength: 255,
        decoration: const InputDecoration(
          labelText: 'Observación',
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

  showAlertDialogAprobar(
      titulo, BuildContext context, guardar, cancelar, texto) {
    Widget okButton =
        TextButton(child: const Text("Confirmar"), onPressed: guardar);
    Widget moButton =
        TextButton(child: const Text("Cancelar"), onPressed: cancelar);
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

  showMyDialog(BuildContext context, String? title,
      {Widget? wFormulario, onPressed1,onPressed2, texto1, texto2}) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        //    return   StatefulBuilder(builder: (context, setState) {
        return CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             // Container(child: Text(title!),width: 150,),
              GestureDetector(
                child: const Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Form(
            // key: _formKey1,
            child: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child:  Container(child: Text(title!,style: TextStyle(color: Colors.black),),width: 150,),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onPressed1,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child:   Text("$texto1"),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),

                  ElevatedButton(
                    onPressed: onPressed2,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 26, 155, 86)),
                    ),
                    child:   Text(
                      "$texto2",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        );

        ///     );
      },
    );
  }

  ConfgAppBar({titulo, leading}){
    return AppBar(title: Text("$titulo"), backgroundColor: AppConfig.primaryColor,leading: Util().iconbuton(leading),centerTitle: true,);
  }
  tieneNtieneDni({titulo, valor, color, oncalbakc, selectedOption}) {
    return RadioListTile(

      activeColor: color,
      title: Text(titulo),
      value: valor,
      groupValue: selectedOption,
      onChanged: oncalbakc,
    ); //
  }



}
