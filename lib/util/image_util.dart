import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  Future<String> networkImageToBase64(String sUrl) async {
    http.Response response = await http.get(Uri.parse(sUrl));
    Uint8List bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  /*
   * Encode Image to Base64
   */
  Future<String> imgBase64Encode(XFile file) async {
    File? imageby;
    imageby = File(file.path);
    Uint8List bytes = File(imageby.path).readAsBytesSync();
    String image64 = base64Encode(bytes);
    return image64;
  }

  /*
   * Decode Base64 to Image 
   */
  Future<File> imgBase64Decode(String b64) async {
    //Image.memory(base64Decode(b64));
    Uint8List decodedBytes = base64Decode(b64);
    var file = File("decodedBase64.png");
    file.writeAsBytesSync(decodedBytes);
    return file;
  }

  static Image ImageUrl(
    String sUrl, {
    String? imgDefault,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
  }) =>
      Image.network(
        sUrl,
        height: height ?? 100.0,
        width: width ?? 100.0,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            imgDefault!,
            fit: BoxFit.cover,
          );
        },
      );

  static Image ImageBase64(
    String sB64, {
    String? imgDefault,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
  }) =>
      Image.memory(
        base64Decode(sB64),
        height: height ?? 100.0,
        width: width ?? 100.0,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            alignment: alignment ?? Alignment.center,
            height: height ?? 100.0,
            width: width ?? 100.0,
            child: Image.asset(imgDefault ?? 'assets/Monitor/logo.png'),
          );
        },
      );

  static FadeInImage ImageAssetNetwork(
    String sUrl, {
    String? imgDefault,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
  }) =>
      FadeInImage.assetNetwork(
        image: sUrl,
        placeholder: 'assets/shimmer.gif',
        height: height ?? 100.0,
        width: width ?? 100.0,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        imageErrorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Container(
            alignment: alignment ?? Alignment.center,
            height: height ?? 100.0,
            width: width ?? 100.0,
            child: Image.asset(imgDefault ?? 'assets/logo circular.png'),
          );
        },
      );

/*
  static FadeInImage ImageMemoryNetwork(
    String sImg, {
    String? imgDefault,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
  }) =>
      FadeInImage.memoryNetwork(
        image: sImg,
        placeholder: kTransparentImage,
        height: height ?? 100.0,
        width: width ?? 100.0,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        imageErrorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Container(
            alignment: alignment ?? Alignment.center,
            height: height ?? 100.0,
            width: width ?? 100.0,
            child: Image.asset(imgDefault ?? 'assets/Monitor/logo.png'),
          );
        },
      );

      */
}
