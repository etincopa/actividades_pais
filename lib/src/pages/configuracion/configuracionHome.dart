import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPageAlert extends StatefulWidget {
  const SettingPageAlert({super.key});

  @override
  State<SettingPageAlert> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPageAlert> {
  bool _toggleAirplaneMode = false;
  var idUser = '';
  var tokenSignal = '';
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    obtenerTokens();
  }

  Future obtenerTokens() async {
    _prefs = await SharedPreferences.getInstance();
    idUser = _prefs!.getString("idUser") ?? '';
    final status = await OneSignal.shared.getDeviceState();
    tokenSignal = status!.userId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuración para alertas'),
        ),
        body: Center(
            child: Column(
          children: [
            SwitchListTile(
              title: const Text(
                  'Desea ricibir alertas por incidencias de internet'),
              secondary: const Icon(Icons.wifi),
              onChanged: (value) {
                setState(() {
                  _toggleAirplaneMode = value;
                  print("ID USUARIO ${idUser}");
                  print("TOKEN SIGNAL ${tokenSignal}");
                });
              },
              value: _toggleAirplaneMode,
            ),
            const Divider(
              thickness: 1.2,
            ),
          ],
        )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
