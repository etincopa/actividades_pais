import 'package:sqflite/sqflite.dart';

class ListarPuesto {
  List<Puesto> items = [];
  ListarPuesto();
  ListarPuesto.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = Puesto.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class Puesto {
  String nombrePuesto = '';
  int idPuesto = 0;

/*String  = "3";
  String nombrePuestotipoRegistro="PERSONAL AUXILIAR";*/
  Puesto({this.nombrePuesto = '', this.idPuesto = 0});

  Map<String, dynamic> toMap() {
    return {
      "nombrePuesto": nombrePuesto,
      "idPuesto": idPuesto,
    };
  }

  factory Puesto.fromJson(Map<String, dynamic> parsedJson) => Puesto(
      nombrePuesto: parsedJson['nombrePuesto'],
      idPuesto: parsedJson['idPuesto']);

  Puesto.fromMap(Map<String, dynamic> map) {
    nombrePuesto = map['nombrePuesto'];
    //  idUsuario = map['idUsuario'];
    idPuesto = map['idPuesto'];
  }
}

class DatPuesto {
  Database? _db;
  static final DatPuesto db = DatPuesto._();
  DatPuesto._();
  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  /*  {
        "idPuesto": 3,
        "nombrePuesto": "UT"
    } */

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'databaseConfig.db',
      version: 1,
      onCreate: (Database db, int version) {
      },
    );
    print(_db!.rawQuery("SELECT * FROM DatPuesto"));
  }

  Future<List<Puesto>> getAllTasksPuesto() async {
    List<Map<String, dynamic>> result = await _db!.query("DatPuesto");
    //  print(result[0].toString());
    return result.map((map) => Puesto.fromMap(map)).toList();
  }

  Future updateTaskPuesto(Puesto task) async {
    _db!.update("DatPuesto", task.toMap(),
        where: "id = ?", whereArgs: [task.idPuesto]);
  }

  Future<List<Puesto>> getTodosPuesto() async {
    initDB();
    final res = await _db!.query('DatPuesto');
    List<Puesto> list =
        res.isNotEmpty ? res.map((e) => Puesto.fromJson(e)).toList() : [];
     return list;
  }
}
