import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class LegalAboutPage extends StatefulWidget {
  const LegalAboutPage({super.key});

  @override
  _LegalAboutPageState createState() => _LegalAboutPageState();
}

class _LegalAboutPageState extends State<LegalAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetCustoms.appBar(
        'Settings'.tr,
        context: context,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Legal'.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('TermsOfUse'.tr),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      title: Text('PrivacyPolicy'.tr),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      title: Text('Penalties'.tr),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
