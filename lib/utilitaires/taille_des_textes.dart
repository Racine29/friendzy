import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/poids_du_texte.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';

class TailleDuText {
  static TextStyle texte12Normal(Color color) => TextStyle(
        color: color,
        fontSize: s12px,
        fontWeight: PoidsDeLaPolice.normal,
      );

  static TextStyle texte16Normal(Color color) => TextStyle(
        color: color,
        fontSize: s16px,
        fontWeight: PoidsDeLaPolice.normal,
      );
  static TextStyle texte16DemiGras(Color color) => TextStyle(
        color: color,
        fontSize: s16px,
        fontWeight: PoidsDeLaPolice.demiGras,
      );
  static TextStyle texte16Gras(Color color) => TextStyle(
        color: color,
        fontSize: s16px,
        fontWeight: PoidsDeLaPolice.gras,
      );

  static TextStyle texte18DemiGras(Color color) => TextStyle(
        color: color,
        fontSize: s18px,
        fontWeight: PoidsDeLaPolice.demiGras,
      );
  static TextStyle texte18Gras(Color color) => TextStyle(
        color: color,
        fontSize: s18px,
        fontWeight: PoidsDeLaPolice.gras,
      );

  static TextStyle texte24DemiGras(Color color) => TextStyle(
        color: color,
        fontSize: s24px,
        fontWeight: PoidsDeLaPolice.demiGras,
      );
  static TextStyle texte24Gras(Color color) => TextStyle(
        color: color,
        fontSize: s24px,
        fontWeight: PoidsDeLaPolice.gras,
      );

  static TextStyle texte28Gras(Color color) => TextStyle(
        color: color,
        fontSize: s28px,
        fontWeight: PoidsDeLaPolice.gras,
      );
  static TextStyle texte32Gras(Color color) => TextStyle(
        color: color,
        fontSize: s32px,
        fontWeight: PoidsDeLaPolice.gras,
      );
}
