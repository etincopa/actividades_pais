import 'package:actividades_pais/src/datamodels/Clases/Sector.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';

import '../../../../datamodels/Clases/ListaTipoGobierno.dart';

class AgregarEntidad extends StatefulWidget {
  const AgregarEntidad({Key? key}) : super(key: key);

  @override
  State<AgregarEntidad> createState() => _AgregarEntidadState();
}

class _AgregarEntidadState extends State<AgregarEntidad> {
  List<TipoGobierno> tipoGobierno=[];
  List<Sector> ListaSector=[];

  bool activoBoton = false;
 @override
  void initState() {
   cargarComboInicial();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,backgroundColor: AppConfig.primaryColor,title: Text("AGREGAR ENTIDAD")), body: registroEntidades());
  }
  cargarComboInicial()async{
    tipoGobierno = await ProviderRegistarInterv().getlistaTipoGobierno();
    setState(() {
    });
  }

  cargarComboSector()async{
    ListaSector = await ProviderRegistarInterv().getlistaTipoGobierno();
    setState(() {
    });
  }

/*  cargarComboInicial()async{
    tipoGobierno = await ProviderRegistarInterv().getlistaTipoGobierno();
    setState(() {
    });
  }*/
  Container registroEntidades() {
    return Container(
      margin:const EdgeInsets.all(20),
      child: ListView(
        children: [
          comboSeleccionar(
            labelTexts: "TIPO DE USUARIO",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {

              setState(() {
                activoBoton = true;
              });
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),
          comboSeleccionar(
            labelTexts: "SECTOR",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),
          comboSeleccionar(
            labelTexts: "PROGRAMA",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),
          comboSeleccionar(
            labelTexts: "CATEGORIA",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),
          comboSeleccionar(
            labelTexts: "SUB CATEGORIA",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),
          comboSeleccionar(
            labelTexts: "TIPO ACTIVIDAD",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),

          comboSeleccionar(
            labelTexts: "SERVICIO",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged:  (value) {
              //  print(value!.idTipoGobierno);
              // Manejar el cambio de valor seleccionado
            },),
        ],
      ),
    );
  }

  comboSeleccionar({String? labelTexts, items, onchanged}) {
    return DropdownButtonFormField<Object>(
        decoration:   InputDecoration(
          isCollapsed: false,
          labelText: labelTexts,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          border: const UnderlineInputBorder(),
        ),
        isExpanded: true,
        items: items,
        onChanged: onchanged
    );
  }
}
