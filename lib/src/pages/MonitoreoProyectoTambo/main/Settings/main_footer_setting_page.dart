import 'package:actividades_pais/util/check_connection.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Settings/faq_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Settings/settings_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Settings/legal_about_page.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class MainFooterSettingPage extends StatefulWidget {
  const MainFooterSettingPage({Key? key}) : super(key: key);

  @override
  State<MainFooterSettingPage> createState() => _MainFooterSettingPageState();
}

class _MainFooterSettingPageState extends State<MainFooterSettingPage> {
  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  String usc = "";
  String usn = "";
  bool isConnec = false;

  loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    usc = _prefs!.getString("codigo") ?? "";
    usn = _prefs!.getString("nombres") ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: kToolbarHeight,
            ),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/Monitor/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    usc,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/contact_us.png'),
                              onPressed: () {},
                            ),
                            Text(
                              usn,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Settings'.tr),
                  subtitle: Text('UserConfig'.tr),
                  leading: Image.asset(
                    'assets/icons/settings.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: blue,
                  ),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                const Divider(),
                ListTile(
                  title: Text('PrivacyPolicy'.tr),
                  subtitle: Text('Legal'.tr),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: blue,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => LegalAboutPage())),
                ),
                const Divider(),
                ListTile(
                  title: Text('FrequentlyAskedQuestions'.tr),
                  subtitle: Text('FrequentlyAskedQuestionsResp'.tr),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: blue,
                  ),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),
                ),
                const Divider(),
                ListTile(
                    title: const Text('Manual de Usuario'),
                    // subtitle: Text('UserConfig'.tr),
                    leading: const Icon(
                      Icons.file_open,
                      color: Color.fromARGB(221, 104, 101, 101),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: blue,
                    ),
                    onTap: () async {
                      isConnec = await CheckConnection.isOnlineWifiMobile();
                      if (isConnec) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (_) => const PDFViewerFromUrl(
                              url:
                                  'https://www.pais.gob.pe/sismonitor/FILES/mop_midis.pdf',
                            ),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (_) => const PDFViewerCachedFromUrl(
                                url:
                                    'https://www.pais.gob.pe/sismonitor/FILES/mop_midis.pdf',
                              ),
                            ));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual de Usuario'),
      ),
      body: const PDF(
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
      ).fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual de Usuario'),
      ),
      body: const PDF(
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
      ).cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
            child: const Text(
                'No se pudo cargar el documento, verifique su conexion a internet'),
          ),
        ),
      ),
    );
  }
}
