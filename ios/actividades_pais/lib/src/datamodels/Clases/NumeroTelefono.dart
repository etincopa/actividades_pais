import 'package:sqflite/sqflite.dart';

class ListarNumerosTelef {
  List<NumerosTelef> items = [];
  ListarNumerosTelef();
  ListarNumerosTelef.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = NumerosTelef.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class NumerosTelef {
  String numeroTelefono = '';
  int idNumeroTelefono = 0;

/*String  = "3";
  String numeroTelefonotipoRegistro="PERSONAL AUXILIAR";*/
  NumerosTelef({this.numeroTelefono = '', this.idNumeroTelefono = 0});

  Map<String, dynamic> toMap() {
    return {
      "numeroTelefono": numeroTelefono,
      "id": idNumeroTelefono,
    };
  }

  factory NumerosTelef.fromJson(Map<String, dynamic> parsedJson) =>
      NumerosTelef(
          numeroTelefono: parsedJson['numeroTelefono'],
          idNumeroTelefono: parsedJson['idNumeroTelefono']);

  NumerosTelef.fromMap(Map<String, dynamic> map) {
    numeroTelefono = map['numeroTelefono'];
    //  idUsuario = map['idUsuario'];
    idNumeroTelefono = map['idNumeroTelefono'];
  }
}

class DatNumerosTelef {
  Database? _db;
  static final DatNumerosTelef db = DatNumerosTelef._();
  DatNumerosTelef._();
  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  /*  {
        "idNumeroTelefono": 3,
        "numeroTelefono": "UT"
    } */

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'database.db',
      version: 1,
      onCreate: (Database db, int version) {
        /*    db.execute(
            "CREATE TABLE DatNumerosTelef (id INTEGER PRIMARY KEY, idNumeroTelefono INTEGER, numeroTelefono TEXT)"); */
      },
    );
    print(_db!.rawQuery("SELECT * FROM DatNumerosTelef"));
  }

  Future<List<NumerosTelef>> getAllTasksNumerosTelef() async {
    List<Map<String, dynamic>> result = await _db!.query("DatNumerosTelef");
    return result.map((map) => NumerosTelef.fromMap(map)).toList();
  }

  Future updateTaskNumerosTelef(NumerosTelef task) async {
    _db!.update("DatNumerosTelef", task.toMap(),
        where: "id = ?", whereArgs: [task.idNumeroTelefono]);
  }

  Future<List<NumerosTelef>> getTodosNumerosTelef() async {
    initDB();

    final res = await _db!.query('DatNumerosTelef');
    print(res);

    List<NumerosTelef> list =
        res.isNotEmpty ? res.map((e) => NumerosTelef.fromJson(e)).toList() : [];
    print(list[0].toString());
    return list;
  }
}
