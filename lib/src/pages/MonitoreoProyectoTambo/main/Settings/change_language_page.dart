import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/resource/Internationalization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  _ChangeCountryPageState createState() => _ChangeCountryPageState();
}

class _ChangeCountryPageState extends State<ChangeLanguagePage> {
  List<String> languages = MyTraslation.Langs;

  String currentLanguage = '';

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
                  'Language'.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: languages
                      .map((l) => ListTile(
                            onTap: () {
                              setState(() {
                                currentLanguage = l;
                                MyTraslation().changeLocale(currentLanguage);
                                setState(() {});
                              });
                            },
                            title: Text(
                              l,
                              style: const TextStyle(fontSize: 14),
                            ),
                            trailing: l == currentLanguage
                                ? const Icon(
                                    Icons.check_circle,
                                    color: color_13,
                                    size: 16,
                                  )
                                : const SizedBox(),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
