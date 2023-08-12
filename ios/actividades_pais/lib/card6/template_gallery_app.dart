import 'package:actividades_pais/card6/ui/contact_list_page.dart';
import 'package:flutter/material.dart';

class Card6 extends StatelessWidget {
  const Card6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff23202a),
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white70,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[800]),
        ),
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      home: const ContactListPage(),
    );
  }
}
