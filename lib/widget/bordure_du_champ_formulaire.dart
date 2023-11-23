import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';

OutlineInputBorder bordureDuChampFormulaire({
  Color? color,
  double? borderRadius,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? h16px),
    borderSide: BorderSide(
      width: 1.4,
      color: color!,
    ),
  );
}
