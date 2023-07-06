
class CLimas {
  List<CLima> items = [];
  CLimas();
  CLimas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = CLima.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class CLima{
int id=0;
String cod='';
String descripcion='';

CLima({
  this.id = 0,
  this.cod='',
  this.descripcion='',
});

  CLima.fromJson(Map<String, dynamic> json) {
  //id = json['id'];
  cod = json['cod'];
  descripcion = json['descripcion'];}

CLima.fromMap(Map<String, dynamic> map) {
  id = map['id'];
  cod = map['cod'];
  descripcion = map['descripcion'];
}

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "descripcion": descripcion,
    };
  }
}