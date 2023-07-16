import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:actividades_pais/custom_background.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Settings/change_language_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/auth/change_password_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class SettingsPage extends StatelessWidget {
  SharedPreferences? _prefs;

  SettingsPage({super.key});

  Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: WidgetCustoms.appBar(
          'Settings'.tr,
          context: context,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'General'.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Language'.tr),
                              leading: Image.asset('assets/icons/language.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const ChangeLanguagePage())),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Account'.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('ChangePassword'.tr),
                              leading:
                                  Image.asset('assets/icons/change_pass.png'),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ChangePasswordPage(),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('LogOut'.tr),
                              leading: const Icon(
                                Icons.logout,
                                color: Color.fromARGB(221, 104, 101, 101),
                              ),
                              onTap: () async {
                                await loadPreferences();
                                if (_prefs != null) {
                                  _prefs!.setString("clave", "");
                                  _prefs!.setString("nombres", "");
                                  _prefs!.setString("codigo", "");
                                  _prefs!.setString("rol", "");
                                }

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginPage()),
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
