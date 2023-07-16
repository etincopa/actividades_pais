class ListaPersonalSoportes {
  List<ListaPersonalSoporte> items = [];

  ListaPersonalSoportes();

  ListaPersonalSoportes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = ListaPersonalSoporte.fromJson(item);
      items.add(listarasistenciaActual);
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
final Map<String, dynamic> data = <String, dynamic>{};
data['id_empleado'] = idEmpleado;
data['DNI'] = dNI;
data['NOMBRE_APELLIDOS'] = nOMBREAPELLIDOS;
return data;
}
}