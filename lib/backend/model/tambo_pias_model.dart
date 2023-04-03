class TamboPiasFld {
  static String tambos = "tambos";
  static String pias = "pias";
}

class TamboPias {
  String? tambos = '0';
  String? pias = '0';

  TamboPias.empty() {}

  TamboPias({
    this.tambos,
    this.pias,
  });

  factory TamboPias.fromJson(Map<String, dynamic> json) {
    return TamboPias(
      tambos: json[TamboPiasFld.tambos],
      pias: json[TamboPiasFld.pias],
    );
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
  }
}
