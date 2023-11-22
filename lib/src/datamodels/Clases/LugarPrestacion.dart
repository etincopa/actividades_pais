class ListarLugarPrestacion {
  List<LugarPrestacion> items = [];
  ListarLugarPrestacion();
  ListarLugarPrestacion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = LugarPrestacion.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class LugarPrestacion {
  String nombreLugarPrestacion = '';
  int idLugarPrestacion = 0;

/*String  = "3";
  String nombreLugarPrestaciontipoRegistro="PERSONAL AUXILIAR";*/
  LugarPrestacion(
      {this.nombreLugarPrestacion = '', this.idLugarPrestacion = 0});

  Map<String, dynamic> toMap() {
    return {
      "nombreLugarPrestacion": nombreLugarPrestacion,
      "idLugarPrestacion": idLugarPrestacion,
    };
  }

  factory LugarPrestacion.fromJson(Map<String, dynamic> parsedJson) =>
      LugarPrestacion(
          nombreLugarPrestacion: parsedJson['nombreLugarPrestacion'],
          idLugarPrestacion: parsedJson['idLugarPrestacion']);

  LugarPrestacion.fromMap(Map<String, dynamic> map) {
    nombreLugarPrestacion = map['nombreLugarPrestacion'];
    //  idUsuario = map['idUsuario'];
    idLugarPrestacion = map['idLugarPrestacion'];
  }
}
