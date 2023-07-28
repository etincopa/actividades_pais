class ThrowCustom implements Exception {
  String? type = 'E';
  String? typeText = 'Error';
  String? msg;
  List<Object?>? obj;

  ThrowCustom({this.type, this.msg, this.obj}) {
    switch (type!) {
      case 'I':
        typeText = "Information";
        break;

      case 'S':
        typeText = "Success";
        break;

      case 'w':
        typeText = "Warning";
        break;
    }
  }

  @override
  String toString() {
    return '$typeText : $msg';
  }
}
