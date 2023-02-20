class ListaPersonalSoportes {
  List<ListaPersonalSoporte> items = [];

  ListaPersonalSoportes();

  ListaPersonalSoportes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual = new ListaPersonalSoporte.fromJson(item);
      items.add(_listarasistenciaActual);
    }
  }
}

class ListaPersonalSoporte {
String? idEmpleado;
String? dNI;
String? nOMBREAPELLIDOS;

ListaPersonalSoporte({this.idEmpleado, this.dNI, this.nOMBREAPELLIDOS});

ListaPersonalSoporte.fromJson(Map<String, dynamic> json) {
idEmpleado = json['id_empleado']??'';
dNI = json['DNI']??'';
nOMBREAPELLIDOS = json['NOMBRE_APELLIDOS']??'';
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id_empleado'] = this.idEmpleado;
data['DNI'] = this.dNI;
data['NOMBRE_APELLIDOS'] = this.nOMBREAPELLIDOS;
return data;
}
}