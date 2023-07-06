import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: const Column(
          children: <Widget>[
            Image(
                image: AssetImage(
              'assets/paislogo.png',
            )),
            SizedBox(height: 1),
            // Text(this.titulo, style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
