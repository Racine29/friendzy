import 'package:flutter/material.dart';
import 'package:friendzy/models/centre_dinteret_model.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/bordure_du_champ_formulaire.dart';
import 'package:friendzy/widget/sexe_carte.dart';

class CentreDinteret extends StatefulWidget {
  const CentreDinteret({super.key});
  @override
  State<CentreDinteret> createState() => _CentreDinteretState();
}

class _CentreDinteretState extends State<CentreDinteret> {
  List<CentreDinteretModel> centredinterets = [
    CentreDinteretModel(
        image: "assets/images/emoji-ballon.png", nom: "Football"),
    CentreDinteretModel(image: "assets/images/emoji-danse.png", nom: "Dancing"),
    CentreDinteretModel(
        image: "assets/images/emoji-ecriture.png", nom: "Writing"),
    CentreDinteretModel(
        image: "assets/images/emoji-fashon.png", nom: "Fashion"),
    CentreDinteretModel(image: "assets/images/emoji-gens.png", nom: "People"),
    CentreDinteretModel(image: "assets/images/emoji-jeu.png", nom: "Gaming"),
    CentreDinteretModel(image: "assets/images/emoji-music.png", nom: "Music"),
    CentreDinteretModel(image: "assets/images/emoji-photo.png", nom: "Gallery"),
  ];

  List<CentreDinteretModel> interetsSelectionner = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: h10px,
        ),
        Text(
          "Select up to 5 interests",
          textAlign: TextAlign.center,
          style: TailleDuText.texte24Gras(texteCouleurNoir),
        ),
        SizedBox(
          height: h30px,
        ),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: centredinterets
              .map((e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if (interetsSelectionner.contains(e)) {
                          interetsSelectionner.remove(e);
                        } else {
                          interetsSelectionner.add(e);
                        }
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: h12px, vertical: h10px),
                        decoration: BoxDecoration(
                          color: interetsSelectionner.contains(e)
                              ? couleurSecondaire
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: couleurPrincipal.withOpacity(.3),
                              width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              e.image,
                              height: h16px,
                            ),
                            SizedBox(
                              width: h8px,
                            ),
                            Text(
                              e.nom,
                              style: TailleDuText.texte16Normal(
                                  interetsSelectionner.contains(e)
                                      ? texteCouleurBlanc
                                      : texteCouleurNoir),
                            )
                          ],
                        )),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
