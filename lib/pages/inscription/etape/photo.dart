import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/modeles/images_modele.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';
import 'package:friendzy/pages/ecran_chargement.dart';
import 'package:friendzy/pages/ecran_emballage.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/services/service_image.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/photo_carte.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../../utilitaires/couleurs.dart';

class EntrerPhoto extends StatefulWidget {
  const EntrerPhoto({
    super.key,
    this.voirElement = true,
  });
  static String page = "entrer-photo";
  final bool voirElement;

  @override
  State<EntrerPhoto> createState() => _EntrerPhotoState();
}

class _EntrerPhotoState extends State<EntrerPhoto> {
  XFile? imagePrincipal;
  XFile? image1;
  XFile? image2;
  XFile? image3;
  XFile? image4;
  XFile? image5;
  List<Images> images = [];
  final serviceDauthentification = ServicesDauthentifications();
  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.sizeOf(context);
    final fournisseur =
        Provider.of<UtilisateurFournisseur>(context, listen: true);

    return Column(
      children: [
        SizedBox(
          height: h10px,
        ),
        if (widget.voirElement) ...{
          Text(
            "Upload your photos",
            textAlign: TextAlign.center,
            style: TailleDuText.texte24Gras(texteCouleurNoir),
          ),
          SizedBox(
            height: h30px,
          ),
        },
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h100px,
              largeur: taille.width * .5,
              hauteur: taille.height * .28,
              hauteurDuButton: h30px,
              fichier: imagePrincipal,
              changerTexteDuButton: true,
              surClique: () async {
                final image = await ImageService().selectionnerUneImage();
                if (image != null) {
                  imagePrincipal = image;
                  images.add(
                      Images(nom: "imageDuProfil", fichier: imagePrincipal));
                  setState(() {});
                }
              },
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
                  fichier: image1,
                  surClique: () async {
                    final image = await ImageService().selectionnerUneImage();
                    if (image != null) {
                      image1 = image;
                      images.add(Images(nom: "image1", fichier: image1));
                      setState(() {});
                    }
                  },
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
                  fichier: image2,
                  surClique: () async {
                    final image = await ImageService().selectionnerUneImage();
                    if (image != null) {
                      image2 = image;
                      images.add(Images(nom: "image2", fichier: image2));
                      setState(() {});
                    }
                  },
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
              fichier: image3,
              surClique: () async {
                final image = await ImageService().selectionnerUneImage();
                if (image != null) {
                  image3 = image;
                  images.add(Images(nom: "image3", fichier: image3));
                  setState(() {});
                }
              },
            ),
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h36px,
              largeur: taille.width * .28,
              hauteur: taille.height * .13,
              hauteurDuButton: h30px,
              fichier: image4,
              surClique: () async {
                final image = await ImageService().selectionnerUneImage();
                if (image != null) {
                  image4 = image;
                  images.add(Images(nom: "image4", fichier: image4));
                  setState(() {});
                }
              },
            ),
            PhotoCarte(
              taille: taille,
              tailleDeMonEmoji: h36px,
              largeur: taille.width * .28,
              hauteur: taille.height * .13,
              hauteurDuButton: h30px,
              fichier: image5,
              surClique: () async {
                final image = await ImageService().selectionnerUneImage();
                if (image != null) {
                  image5 = image;
                  images.add(Images(nom: "image5", fichier: image5));
                  setState(() {});
                }
              },
            ),
          ],
        ),
        SizedBox(height: h40px),
        if (widget.voirElement)
          SizedBox(
            width: double.infinity,
            child: ElevatedBtn(
              onPressed: imagePrincipal == null
                  ? null
                  : () async {
                      final serviceDauthentification =
                          ServicesDauthentifications();
                      Chargement(context);

                      UtilisateurModel utilisateur =
                          UtilisateurModel.deJSON(fournisseur.donnees);

                      for (var i = 0; i < images.length; i++) {
                        final image = images[i];
                        final url =
                            await serviceDauthentification.telechargerUneImage(
                                File(image.fichier!.path), "photo");
                        if (image.nom == "imageDuProfil") {
                          utilisateur.imageDuProfil = url;
                        } else {
                          fournisseur.ajoutDeMaListeDimages(
                              Images(nom: image.nom, url: url));
                        }
                      }

                      utilisateur.images = fournisseur.maListeDimages;
                      utilisateur.indicateurDeProgression = 4;

                      final approuver = await serviceDauthentification
                          .miseAJourDesInformationsDeMonUtilisateur(
                              utilisateur);
                      if (approuver == true) {
                        await serviceDauthentification
                            .authentification.currentUser
                            ?.updateDisplayName(utilisateur.nom);
                        await GetStorage().remove("utilisateur");
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            EcranEmballage.page, (route) => false);
                      }
                    },
              texte: "Next",
              style: TailleDuText.texte16Gras(texteCouleurBlanc),
            ),
          ),
      ],
    );
  }
}
