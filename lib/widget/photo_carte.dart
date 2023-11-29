import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';

class PhotoCarte extends StatelessWidget {
  const PhotoCarte(
      {super.key,
      required this.taille,
      required this.largeur,
      required this.hauteur,
      required this.tailleDeMonEmoji,
      required this.hauteurDuButton,
      this.photoExiste = false});
  final Size taille;
  final double largeur;
  final double hauteur;
  final double tailleDeMonEmoji;
  final double hauteurDuButton;
  final bool photoExiste;

  @override
  Widget build(BuildContext context) {
    double largeurDeMonButton = photoExiste ? h100px + 50 : h80px;
    return Container(
      width: largeur,
      height: hauteur,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(h20px),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: (hauteur / 2) - (tailleDeMonEmoji / 1.1),
            left: (largeur / 2) - (tailleDeMonEmoji / 2),
            child: Icon(
              Icons.emoji_emotions,
              size: tailleDeMonEmoji,
              color: couleurSecondaire.withOpacity(.1),
            ),
          ),
          photoExiste
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h20px),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(.2),
                        ],
                      )),
                )
              : const SizedBox(),
          Positioned(
            left: (largeur / 2) - (largeurDeMonButton / 2),
            bottom: h10px,
            width: largeurDeMonButton,
            height: hauteurDuButton,
            child: ElevatedBtn(
              onPressed: photoExiste ? () {} : () {},
              couleurDubutton: photoExiste
                  ? Colors.white.withOpacity(.3)
                  : couleurSecondaire,
              rembourage: EdgeInsets.zero,
              style: TailleDuText.texte16Normal(texteCouleurBlanc),
              enfant: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    photoExiste ? Icons.camera_alt_rounded : Icons.add_rounded,
                    size: h16px,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    photoExiste ? "Change Photo" : "Add",
                    style: TailleDuText.texte16DemiGras(texteCouleurBlanc),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
