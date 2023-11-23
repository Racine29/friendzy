import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn(
      {super.key,
      required this.texte,
      this.couleurDubutton = couleurPrincipal,
      required this.style,
      this.onPressed});
  final String texte;
  final Color couleurDubutton;
  final TextStyle style;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: couleurDubutton,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child: Text(
          texte,
          style: style,
        ));
  }
}
