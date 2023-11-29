import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';

class SexeCarte extends StatelessWidget {
  const SexeCarte({
    super.key,
    required this.taille,
    required this.couleur,
    required this.sexe,
    required this.icone,
    required this.sonSexe,
  });
  final Size taille;
  final Color couleur;
  final String sexe;
  final Icon icone;
  final bool sonSexe;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: taille.height * .22,
      width: taille.width * .42,
      padding: EdgeInsets.all(h10px),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: !sonSexe ? Colors.transparent : couleur,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(h20px),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sonSexe
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.check_circle,
                    color: couleur,
                  ),
                )
              : const SizedBox(),
          Center(
            child: CircleAvatar(
              maxRadius: 30,
              backgroundColor: couleur,
              foregroundColor: couleur,
              child: icone,
            ),
          ),
          SizedBox(
            height: h10px,
          ),
          Text(
            sexe,
            textAlign: TextAlign.center,
            style: TailleDuText.texte16Normal(texteCouleurNoir),
          ),
        ],
      ),
    );
  }
}
