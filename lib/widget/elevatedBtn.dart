import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn(
      {super.key,
      this.texte,
      this.couleurDubutton = couleurPrincipal,
      this.style,
      this.onPressed,
      this.enfant,
      this.rembourage,
      this.rondeur,
      this.couleurDombreDuButton});
  final String? texte;
  final Color couleurDubutton;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final Widget? enfant;
  final EdgeInsets? rembourage;
  final BorderRadiusGeometry? rondeur;
  final Color? couleurDombreDuButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shadowColor: couleurDombreDuButton,
            foregroundColor: couleurPrincipal,
            backgroundColor: couleurDubutton,
            elevation: 0,
            padding: rembourage ??
                const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            shape: RoundedRectangleBorder(
                borderRadius: rondeur ?? BorderRadius.circular(100))),
        child: enfant ??
            Text(
              texte ?? "",
              style: style,
            ));
  }
}
