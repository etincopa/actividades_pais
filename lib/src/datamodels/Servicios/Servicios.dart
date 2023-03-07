
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Servicios {
  /* Future loadTablaPlataformas() async {
    return await rootBundle.loadString('assets/TablaPlataformas.json');
  } */

  Future loadunidadesOrganicas() async {
    return await rootBundle.loadString('assets/unidadesOrganicas.json');
  }

  Future loadunidadesTerritoriales() async {
    return await rootBundle.loadString('assets/unidadesTerritoriales.json');
  }

  Future loadunidadesLugarPrestacion() async {
    return await rootBundle.loadString('assets/lugarPrestacion.json');
  }

  /*Future<String> loadUnidadesTablaPlataforma() async {
    return await rootBundle.loadString('assets/TablaPlataformas.json');
  } */

  Future loadPuesto() async {
    return await rootBundle.loadString('assets/puesto.json');
  }

  Future loadNumeroTelefono() async {
    return await rootBundle.loadString('assets/numeroTelefono.json');
  }

  Future loadprovincias() async {
    return await rootBundle.loadString('assets/provincias.json');
  }

/*  Future loadPlataformaUbigeos() async {
    return await rootBundle.loadString('assets/plataforma_ubigeos.json');
  }
 */
  Future loadTipoDocumento() async {
    return await rootBundle.loadString('assets/tipoDocumento.json');
  }

  Future loadSexo() async {
    return await rootBundle.loadString('assets/Sexo.json');
  }

  Future loadTipoPlataforma() async {
    return await rootBundle.loadString('assets/tipoPlataforma.json');
  }

  Future loadCLima() async {
    return await rootBundle.loadString('assets/climas.json');
  }

  Future loadCampanias() async {
    return await rootBundle.loadString('assets/campanias.json');
  }

  Future loadtipoAtencion() async {
    return await rootBundle.loadString('assets/tipoAtencion.json');
  }

  Future loadUnidad() async {
    return await rootBundle.loadString('assets/unidad.json');
  }

/*  Future loadParticipantes() async {
    return await rootBundle.loadString('assets/participantesIntervenciones.json');
  }*/
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: Color(0xFF1E88E5)),
      borderRadius: BorderRadius.all(
          Radius.circular(11) //                 <--- border radius here
          ),
    );
  }

  Future loadParticipantes() async {
    late File jsonFile;
    late Directory dir;
    String fileName = "myJSONFile.json";
    bool fileExists = false;
    var fileEncode;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
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
    var fileEncode;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
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
    var fileEncode;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
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
