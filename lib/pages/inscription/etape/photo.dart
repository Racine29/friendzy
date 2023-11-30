import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/photo_carte.dart';

import '../../../utilitaires/couleurs.dart';

class EntrerPhoto extends StatelessWidget {
  const EntrerPhoto({super.key});
  static String page = "entrer-photo";

  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.sizeOf(context);

    return Column(
      children: [
        SizedBox(
          height: h10px,
        ),
        Text(
          "Upload your photos",
          textAlign: TextAlign.center,
          style: TailleDuText.texte24Gras(texteCouleurNoir),
        ),
        SizedBox(
          height: h30px,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h100px,
              largeur: taille.width * .5,
              hauteur: taille.height * .28,
              hauteurDuButton: h30px,
              photoExiste: false,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PhotoCarte(
                  taille: taille,
                  tailleDeMonEmoji: h36px,
                  largeur: taille.width * .35,
                  hauteur: taille.height * .13,
                  hauteurDuButton: h30px,
                ),
                SizedBox(
                  height: h10px,
                ),
                PhotoCarte(
                  taille: taille,
                  tailleDeMonEmoji: h36px,
                  largeur: taille.width * .35,
                  hauteur: taille.height * .13,
                  hauteurDuButton: h30px,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: h10px,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h36px,
              largeur: taille.width * .28,
              hauteur: taille.height * .13,
              hauteurDuButton: h30px,
            ),
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h36px,
              largeur: taille.width * .28,
              hauteur: taille.height * .13,
              hauteurDuButton: h30px,
            ),
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h36px,
              largeur: taille.width * .28,
              hauteur: taille.height * .13,
              hauteurDuButton: h30px,
            ),
          ],
        ),
      ],
    );
  }
}
