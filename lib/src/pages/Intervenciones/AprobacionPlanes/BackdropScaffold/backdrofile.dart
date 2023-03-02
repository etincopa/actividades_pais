import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class backdrofile extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<backdrofile> {
  List<String> items = [    'Manzana',    'Banana',    'Pera',    'Naranja',    'Kiwi',    'Melón'  ];

  List<String> filteredItems = ["",""];

  String filter = '';

  void filterList(String query) {
    List<String> filtered = [];
    if (query.isNotEmpty) {
      items.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          filtered.add(item);
        }
      });
    } else {
      filtered = List.from(items);
    }
    setState(() {
      filteredItems = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    final List<Widget> _pages = [Container(), Container()];
    return MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Navigation Example"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),

        frontLayer: _pages[_currentIndex],
        backLayer: BackdropNavigationBackLayer(
          items: [
            ListTile(title: Text("Widget 1")),
            ListTile(title: Text("Widget 2")),
          ],
          onTap: (int position) => {setState(() => _currentIndex = position)},
        ),
      ),
    );
  }
}