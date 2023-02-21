import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetCustoms {
  static AppBar appBar(
    String title, {
    BuildContext? context,
    IconData? icon,
    IconData? iconAct,
    SystemUiOverlayStyle? systemOverlayStyle,
    void Function()? onPressed,
    void Function()? onPressedAct,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
  }) =>
      AppBar(
        backgroundColor: color_10o15,
        shadowColor: color_10o15,
        systemOverlayStyle: systemOverlayStyle,
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: color_01,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            icon ?? Icons.arrow_back,
            color: color_01,
          ),
          onPressed: onPressed ??
              () {
                Navigator.maybePop(context!);
              },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: onPressedAct,
              icon: Icon(
                iconAct,
                color: color_01,
              ),
            ),
          ),
        ],
        flexibleSpace: flexibleSpace,
        bottom: bottom,
      );
}
