import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  Map<String, List> itemsImagesAll = {};

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> selectMultipleImage(String nameInputImage) async {
    images = await _picker.pickMultiImage();
    listImagePath = [];
    int count = 0;
    if (images != null) {
      itemsImagesAll.forEach((key, items) {
        if (key == nameInputImage) {
          items.forEach((entry) {
            if (count < 4 && listImagePath.length < 4) {
              listImagePath.add(entry);
            }
            count++;
          });
        }
      });
      if (count < 4) {
        for (XFile file in images!) {
          if (listImagePath.length < 4) {
            listImagePath.add(file.path);
            itemsImagesAll.addAll({nameInputImage: listImagePath});
          }
        }
      } else {
        Get.snackbar('Error', 'Solo esta permitido 4 imaganes',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } else {
      Get.snackbar('Error', 'Ninguna Imagen Selecionada',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    itemsImagesAll[nameInputImage] = listImagePath;
  }

  Future<void> removeMultipleImage(String index, String nameInputImage) async {
    listImagePath = [];
    itemsImagesAll.forEach((key, items) {
      if (key == nameInputImage) {
        items.remove(index);
        items.forEach((entry) {
          listImagePath.add(entry);
        });
      }
    });
    itemsImagesAll[nameInputImage] = listImagePath;
  }
}