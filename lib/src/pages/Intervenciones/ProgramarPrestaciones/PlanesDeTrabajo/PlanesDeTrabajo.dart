import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanesDeTrabajo extends StatelessWidget {
  const PlanesDeTrabajo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: utils().ConfgAppBar(
          titulo: "PLANES DE TRABAJO",
          leading: () {
            Navigator.pop(context);
          }),
    );
  }
}
