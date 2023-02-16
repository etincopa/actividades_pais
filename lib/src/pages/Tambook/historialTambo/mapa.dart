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
    return Scaffold(
      body: Center(
        child: Container(
          child: WebView(
            initialUrl: 'https://www.pais.gob.pe/mapaoperatividad/mapa.html',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) {
              this._controller = webViewController;
              print(webViewController.toString());
            },
            onPageStarted: (url) {
              print(
                "jola__ $url",
              );
            },
          ),
        ),

      ),
    );
  }
}
