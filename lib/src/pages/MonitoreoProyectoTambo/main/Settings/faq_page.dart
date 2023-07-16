import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<Panel> panels = [
    Panel('PREGUNTA 1?', 'Respuesta 1', false),
    Panel('PREGUNTA 2?', 'Respuesta 2', false),
    Panel('PREGUNTA 3?', 'Respuesta 3', false)
  ];

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
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24.0, bottom: 16.0),
                child: Text(
                  'FrequentlyAskedQuestions'.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              ...panels
                  .map((panel) => ExpansionTile(
                          title: Text(
                            panel.title,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          children: [
                            Container(
                                padding: const EdgeInsets.all(16.0),
                                color: const Color(0xffFAF1E2),
                                child: Text(panel.content,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12)))
                          ]))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}
