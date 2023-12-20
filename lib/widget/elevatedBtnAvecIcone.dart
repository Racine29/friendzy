import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';

class ElevatedBtnAvecIcone extends StatelessWidget {
  const ElevatedBtnAvecIcone({
    super.key,
    required this.texte,
    this.couleurDubutton = couleurPrincipal,
    required this.style,
    this.icone,
    this.onPressed,
  });
  final String texte;
  final Color couleurDubutton;
  final TextStyle style;
  final Widget? icone;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: EdgeInsets.all(h8px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: couleurDubutton,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icone != null
                ? CircleAvatar(
                    maxRadius: 24, backgroundColor: Colors.white, child: icone)
                : const SizedBox(),
            Text(
              texte,
              style: style,
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
