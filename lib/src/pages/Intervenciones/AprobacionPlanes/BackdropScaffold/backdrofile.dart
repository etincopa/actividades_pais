import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

class backdrofile extends StatefulWidget {
  const backdrofile({super.key});

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
      for (var item in items) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          filtered.add(item);
        }
      }
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

  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final List<Widget> pages = [Container(), Container()];
    return MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("Navigation Example"),
          actions: const <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),

        frontLayer: pages[currentIndex],
        backLayer: BackdropNavigationBackLayer(
          items: const [
            ListTile(title: Text("Widget 1")),
            ListTile(title: Text("Widget 2")),
          ],
          onTap: (int position) => {setState(() => currentIndex = position)},
        ),
      ),
    );
  }
}