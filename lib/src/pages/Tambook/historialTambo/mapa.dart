import 'package:actividades_pais/src/pages/widgets/WebViewTest.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapaTambook extends StatefulWidget {
  @override
  State<MapaTambook> createState() => _MapaTambookState();
}

class _MapaTambookState extends State<MapaTambook> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: WebViewExample(),
      ),
    );
  }
}
