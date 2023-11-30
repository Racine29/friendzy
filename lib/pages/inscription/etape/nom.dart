import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/bordure_du_champ_formulaire.dart';

class EntrerNom extends StatelessWidget {
  const EntrerNom({super.key});
  static String page = "entrer-nom";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: h10px,
        ),
        Text(
          "What's your name ?",
          textAlign: TextAlign.center,
          style: TailleDuText.texte24Gras(texteCouleurNoir),
        ),
        SizedBox(
          height: h30px,
        ),
        TextFormField(
          cursorColor: couleurPrincipal,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: h16px, horizontal: h10px),
            focusedBorder: bordureDuChampFormulaire(color: couleurSecondaire),
            disabledBorder: bordureDuChampFormulaire(color: couleurSecondaire),
            focusedErrorBorder: bordureDuChampFormulaire(color: Colors.red),
            enabledBorder: bordureDuChampFormulaire(color: couleurSecondaire),
            errorBorder: bordureDuChampFormulaire(
              color: Colors.red,
            ),
            filled: true,
            fillColor: texteCouleurBlanc,
          ),
        )
      ],
    );
  }
}
