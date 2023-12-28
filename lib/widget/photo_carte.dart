import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';

class PhotoCarte extends StatelessWidget {
  const PhotoCarte({
    super.key,
    required this.taille,
    required this.largeur,
    required this.hauteur,
    required this.tailleDeMonEmoji,
    required this.hauteurDuButton,
    this.surClique,
    this.fichier,
    this.changerTexteDuButton = false,
    this.imageUrl,
  });
  final Size taille;
  final double largeur;
  final double hauteur;
  final double tailleDeMonEmoji;
  final double hauteurDuButton;
  final VoidCallback? surClique;
  final XFile? fichier;
  final String? imageUrl;
  final bool changerTexteDuButton;

  ombreSurMaPhoto() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h20px),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.withOpacity(0.1),
            Colors.black.withOpacity(.6),
          ],
        ),
      ),
    );
  }

  double changerLaTailleDeMonButton() {
    if (fichier != null && changerTexteDuButton ||
        imageUrl != null && changerTexteDuButton) {
      return h100px + 50;
    }

    return h80px;
  }

  Color changerCouleurDuButton() {
    if (fichier != null && changerTexteDuButton ||
        imageUrl != null && changerTexteDuButton) {
      return Colors.white.withOpacity(.3);
    }

    return couleurSecondaire;
  }

  String changerLeTexteDuButton() {
    if (fichier != null && changerTexteDuButton ||
        imageUrl != null && changerTexteDuButton) {
      return "Change Photo";
    }

    return "Add";
  }

  @override
  Widget build(BuildContext context) {
    double largeurDeMonButton = changerLaTailleDeMonButton();
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
          if (imageUrl != null) ...{
            ClipRRect(
                borderRadius: BorderRadius.circular(h20px),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                )),
            ombreSurMaPhoto(),
          },
          if (fichier != null) ...{
            ClipRRect(
              borderRadius: BorderRadius.circular(h20px),
              child: Image.file(
                File(fichier!.path),
                fit: BoxFit.cover,
              ),
            ),
            ombreSurMaPhoto(),
          },
          Positioned(
            left: (largeur / 2) - (largeurDeMonButton / 2),
            bottom: h10px,
            width: largeurDeMonButton,
            height: hauteurDuButton,
            child: ElevatedBtn(
              onPressed: surClique,
              couleurDubutton: changerCouleurDuButton(),
              rembourage: EdgeInsets.zero,
              style: TailleDuText.texte16Normal(texteCouleurBlanc),
              enfant: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    fichier != null || imageUrl != null && changerTexteDuButton
                        ? Icons.camera_alt_rounded
                        : Icons.add_rounded,
                    size: h16px,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    changerLeTexteDuButton(),
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
