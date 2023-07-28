class InfoTelefono {
  String imei;
  String mac;
  String ip;
  int id;

  InfoTelefono({this.imei = '', this.mac = '', this.ip = '', this.id = 0});

  Map<String, dynamic> toMap() {
    return {"imei": imei, "mac": mac, "ip": ip, "id": id};
  }

  factory InfoTelefono.fromMap(Map<String, dynamic> map) => InfoTelefono(
      imei: map["imei"], mac: map["mac"], ip: map["ip"], id: map["id"]);
}
