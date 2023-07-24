import 'package:flutter/material.dart';

/*
 * PALETA DE COLORES SEGUN LOGO PAIS
 * 
 * #FBFBFB BACKGROUND
 * #BC0514 P
 * #8F9D9F A
 * #7987CC I
 * #65A33E S
 * 
 */

const Color colorGB = Color(0xFFFBFBFB);
const Color colorP = Color(0xFFBC0514);
const Color colorA = Color(0xFF8F9D9F);
const Color colorI = Color(0xFFB40404);
const Color colorS = Color(0xFF65A33E);

/*
 * VARIANTES PALETA COLORES
 */
const Color colorGB_01o27 = Color(0xC5FBFBFB); //27% Opacidad
const Color color_01 = Color(0XFF000000);
const Color color_02o27 = Color(0xB7333333); //27% Opacidad
const Color color_03 = Color(0XFF008980);
const Color color_04 = Color(0XFF666666);
const Color color_05 = Color(0XFF008D3D);
const Color color_06 = Color(0XFF00C1DB);
const Color color_07 = Color(0XFF22C1E4);
const Color color_08o80 = Color(0x5228AEC0); //80% Opacidad
const Color color_09 = Color(0XFF89BFD2);
const Color color_10o15 = Color.fromARGB(220, 225, 238, 245); //15% Opacidad
const Color color_11 = Color(0XFFC12C37);
const Color color_12 = Color(0XFFE06DBF);
const Color color_13 = Color(0XFFFF8E00);
const Color rojo = Color(0xFFB40404);
const Color rojo2 = Color.fromARGB(255, 243, 111, 111);
/*
 * OTROS COLORES
 */

const LinearGradient mainButton4 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    colorI,
    colorI,
    colorI,
    colorI,
  ],
  stops: [0.1, 0.4, 0.7, 0.9],
);

const LinearGradient mainButton5 = LinearGradient(
  colors: [
    color_10o15,
    color_10o15,
  ],
);

const List<BoxShadow> shadow = [
  BoxShadow(
    color: color_01,
    offset: Offset(0, 3),
    blurRadius: 6,
  )
];
