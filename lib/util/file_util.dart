import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  File? jsonFile;
  Directory? dir;

  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    //final directory = await getExternalStorageDirectory();
    Directory target = Directory(directory.path);
    bool folderExist = false;
    if (target.existsSync()) {
      folderExist = true;
    } else {
      try {
        target.createSync();
        folderExist = true;
      } catch (exception) {
        print('${target.path} -- failed to create -- ${exception.toString()}');
      }
    }
    return folderExist ? target.path : directory.path;
  }

  Future<bool> isFileExist(
    String storage,
  ) async {
    String sPath = await _localPath;
    jsonFile = File("$sPath/$storage.json");
    bool fileExists = jsonFile!.existsSync();

    return fileExists;
  }

  /*
    Crear un nuevo archivo
    @Map data : Registros para almacenar
    @Directory dir: Ubicación del archivo
    @String storage: Nombre de la tienda
   */
  Future<bool> createFile(
    dynamic data,
    String storage,
  ) async {
    String sPath = await _localPath;
    File file = File("$sPath/$storage.json");
    String aContent = jsonEncode(data);
    file.createSync();
    file.writeAsStringSync(aContent);
    return true;
  }

  /*
    Obtener todos los registros del archivo LocalStorage
    @String storage : Nombre de la tienda
    @T: Callback para el retorno de la data y parseo 
   */
  Future<T?> readDataFile<T>(
    String storage,
    T Function(dynamic data)? parser,
  ) async {
    bool fileExists = await isFileExist(storage);
    if (fileExists) {
      String sContent = jsonFile!.readAsStringSync();
      return parser!(jsonDecode(sContent));
    } else {
      await createFile(List.empty(), storage);
    }

    return parser!(null);
  }

  /*
    Añadir nuevos registros al archivo
    @String storage : Nombre de la tienda
    @dynamic data: registros para almacenar en el LocalStorage
   */
  Future<bool> writeToAllDataFile<T>(
    String storage,
    dynamic data,
  ) async {
    bool fileExists = await isFileExist(storage);
    String aContent = jsonEncode(data);
    if (fileExists) {
      jsonFile!.writeAsStringSync(aContent);
    } else {
      await createFile(data, storage);
    }
    return true;
  }
}
