import 'dart:io';

import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/src/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyImageMultiple extends StatefulWidget {
  const MyImageMultiple({
    Key? key,
    required this.controller,
    required this.nameField,
    required this.enabled,
  }) : super(key: key);

  final ImageController controller;
  final String nameField;
  final bool? enabled;

  @override
  _MyImageMultipleState createState() => _MyImageMultipleState();
}

class _MyImageMultipleState extends State<MyImageMultiple> {
  @override
  Widget build(BuildContext context) {
    List<String> itemsImagePath = [];
    var selectedItemCount = 0.obs;
    widget.controller.itemsImagesAll.forEach((key, items) {
      if (key == widget.nameField) {
        for (var entry in items) {
          itemsImagePath.add(entry);
        }
      }
    });
    return ListView(
      shrinkWrap: true,
      children: [
        Obx(() {
          selectedItemCount.value = itemsImagePath.length;
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(
              selectedItemCount.value,
              (index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Image.file(
                        File(itemsImagePath[index]),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      widget.enabled!
                          ? Positioned(
                              right: -2,
                              top: -2,
                              child: InkWell(
                                child: const Icon(
                                  Icons.remove_circle,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                onTap: () async {
                                  await widget.controller.removeMultipleImage(
                                    itemsImagePath[index],
                                    widget.nameField,
                                  );
                                  setState(() {});
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }
}
