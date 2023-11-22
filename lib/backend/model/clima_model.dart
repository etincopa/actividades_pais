class ClimaField {
  static String temp = "temperature";
  static String speed = "windspeed";
  static String direction = "winddirection";
  static String code = "weathercode";
  static String tiempo = "time";
}

class ClimaModel {
  double? temp;
  double? speed;
  int? direction;
  int? code;
  String? tiempo;

  ClimaModel.empty();

  ClimaModel({
    this.temp,
    this.speed,
    this.direction,
    this.code,
    this.tiempo,
  });

  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    return ClimaModel(
      temp: json[ClimaField.temp],
      speed: json[ClimaField.speed],
      direction: json[ClimaField.direction],
      code: json[ClimaField.code],
      tiempo: json[ClimaField.tiempo],
    );
  }
}
