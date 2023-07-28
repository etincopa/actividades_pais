
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Servicios {
  /* Future loadTablaPlataformas() async {
    return await rootBundle.loadString('assets/data/TablaPlataformas.json');
  } */

  Future loadunidadesOrganicas() async {
    return await rootBundle.loadString('assets/data/unidadesOrganicas.json');
  }

  Future loadunidadesTerritoriales() async {
    return await rootBundle.loadString('assets/data/unidadesTerritoriales.json');
  }

  Future loadunidadesLugarPrestacion() async {
    return await rootBundle.loadString('assets/data/lugarPrestacion.json');
  }

  /*Future<String> loadUnidadesTablaPlataforma() async {
    return await rootBundle.loadString('assets/data/TablaPlataformas.json');
  } */

  Future loadPuesto() async {
    return await rootBundle.loadString('assets/data/puesto.json');
  }

  Future loadNumeroTelefono() async {
    return await rootBundle.loadString('assets/data/numeroTelefono.json');
  }

  Future loadprovincias() async {
    return await rootBundle.loadString('assets/data/provincias.json');
  }

/*  Future loadPlataformaUbigeos() async {
    return await rootBundle.loadString('assets/data/plataforma_ubigeos.json');
  }
 */
  Future loadTipoDocumento() async {
    return await rootBundle.loadString('assets/data/tipoDocumento.json');
  }

  Future loadSexo() async {
    return await rootBundle.loadString('assets/data/Sexo.json');
  }

  Future loadTipoPlataforma() async {
    return await rootBundle.loadString('assets/data/tipoPlataforma.json');
  }

  Future loadCLima() async {
    return await rootBundle.loadString('assets/data/climas.json');
  }

  Future loadCampanias() async {
    return await rootBundle.loadString('assets/data/campanias.json');
  }

  Future loadtipoAtencion() async {
    return await rootBundle.loadString('assets/data/tipoAtencion.json');
  }

  Future loadUnidad() async {
    return await rootBundle.loadString('assets/data/unidad.json');
  }

/*  Future loadParticipantes() async {
    return await rootBundle.loadString('assets/data/participantesIntervenciones.json');
  }*/
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: const Color(0xFF1E88E5)),
      borderRadius: const BorderRadius.all(
          Radius.circular(11) //                 <--- border radius here
          ),
    );
  }

  Future loadParticipantes() async {
    late File jsonFile;
    late Directory dir;
    String fileName = "myJSONFile.json";
    bool fileExists = false;
    String fileEncode = '';
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File("${dir.path}/$fileName");
      fileExists = jsonFile.existsSync();
      if (fileExists){
        fileEncode = jsonFile.readAsStringSync();
        return fileEncode;
      }

    });
    if (fileExists){
      return fileEncode;
    }
  }
  Future loadFuncionarios() async {
    late File jsonFile;
    late Directory dir;
    String fileName = "jsonFuncionarios.json";
    bool fileExists = false;
    String fileEncode = '';
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File("${dir.path}/$fileName");
      fileExists = jsonFile.existsSync();
      if (fileExists){
        fileEncode = jsonFile.readAsStringSync();
        return fileEncode;
      }

    });
    if (fileExists){
      return fileEncode;
    }

  }
  Future loadDataArchivos(nombreArchivo) async {
    late File jsonFile;
    late Directory dir;
    String fileName = nombreArchivo;
    bool fileExists = false;
    String fileEncode = '';
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File("${dir.path}/$fileName");
      fileExists = jsonFile.existsSync();
      if (fileExists){
        fileEncode = jsonFile.readAsStringSync();
        return fileEncode;
      }

    });
    if (fileExists){
      return fileEncode;
    }

  }
  List data = []; //edited line

}
