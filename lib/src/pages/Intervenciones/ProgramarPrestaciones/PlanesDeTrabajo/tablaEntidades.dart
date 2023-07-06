import 'package:flutter/material.dart';

class TablaEntidades extends StatelessWidget {
  final List<Map<String, String>> data = [
    {'id': '1', 'nombre': 'Elemento 1'},
    {'id': '2', 'nombre': 'Elemento 2'},
    {'id': '3', 'nombre': 'Elemento 3'},
    {'id': '4', 'nombre': 'Elemento 4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla con acciones'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text(item['nombre']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Acción de editar
                    print('Editar elemento ${item['id']}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Acción de eliminar
                    print('Eliminar elemento ${item['id']}');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}