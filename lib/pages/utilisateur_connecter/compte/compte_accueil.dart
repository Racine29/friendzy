import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';
import 'package:friendzy/pages/utilisateur_connecter/compte/modification_du_profile.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CompteAccueil extends StatefulWidget {
  const CompteAccueil({super.key});

  @override
  State<CompteAccueil> createState() => _CompteAccueilState();
}

class _CompteAccueilState extends State<CompteAccueil> {
  /// ? Mon chargement pre donnee
  Widget chargementEnPente({required double angle}) {
    return Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(milliseconds: 400),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(angle),
          ),
        ));
  }

  Widget contenuDuButtonMonCompte(
      {required IconData icone,
      required String titreDuButton,
      String? sousTexte}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icone,
              color: couleurPrincipal,
              size: h24px,
            ),
            SizedBox(width: h12px),
            Text(
              titreDuButton,
              style: TailleDuText.texte16DemiGras(texteCouleurNoir),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              sousTexte ?? "",
              style: TailleDuText.texte14DemiGras(couleurGris400),
            ),
            SizedBox(width: h8px),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: couleurGris400,
              size: h16px,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<UtilisateurModel>(context);

    return Scaffold(
      backgroundColor: couleurArrierePlan,
      body: ListView(
        children: [
          //? profil en tete -------------------------------
          Container(
            height: h300px + h70px,
            padding: EdgeInsets.symmetric(horizontal: h20px),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //? Image du profile ----------------------------
                Container(
                  height: h100px + h10px,
                  width: h100px + h10px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(h300px),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      utilisateur.imageDuProfil == null
                          ? chargementEnPente(angle: h300px)
                          : Padding(
                              padding: EdgeInsets.all(h6px - 2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(h300px),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: utilisateur.imageDuProfil!,
                                  placeholder: (_, __) {
                                    return chargementEnPente(angle: h300px);
                                  },
                                ),
                              ),
                            ),
                      CircularProgressIndicator(
                        value: utilisateur.indicateurDeProgression / 10,
                        color: couleurPrincipal,
                      ),
                    ],
                  ),
                ),

                //  Fin -----------------------------

                //? Nom, age et geolocalisation du profile ----------------------------
                SizedBox(
                  height: h10px,
                ),
                Text(
                  "${utilisateur.nom != null && utilisateur.nom!.length < 10 ? utilisateur.nom : utilisateur.nom!.substring(0, 10)},${utilisateur.age ?? ""}" ??
                      "",
                  style: TailleDuText.texte32DemiGras(texteCouleurNoir),
                ),

                Text(
                  utilisateur.geolocalisation ?? "FLORIDA,US",
                  style: TailleDuText.texte21Normal(
                      texteCouleurNoir.withOpacity(.5)),
                ),
                //  Fin ---------------------------------------
                SizedBox(
                  height: h16px,
                ),
                //  ? Pourcentage d'inscription pour completer mon profile ------------
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: h14px, vertical: h10px),
                  decoration: BoxDecoration(
                    color: couleurPrincipal,
                    borderRadius: BorderRadius.circular(h16px),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: h40px + h6px,
                            width: h40px + h6px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(h300px),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(h6px - 2),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(h300px),
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            "${utilisateur.indicateurDeProgression * 10} %",
                                            style: TailleDuText.texte12DemiGras(
                                                couleurPrincipal),
                                          ),
                                        ),
                                      )),
                                ),
                                CircularProgressIndicator(
                                  value:
                                      utilisateur.indicateurDeProgression / 10,
                                  color: couleurSecondaire,
                                  strokeWidth: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: h6px,
                      ),
                      Expanded(
                        child: Text(
                          "Complete your profile to stand out",
                          style: TailleDuText.texte12DemiGras(Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: h20px,
                      ),
                      ElevatedBtn(
                        couleurDubutton: couleurSecondaire,
                        style: TailleDuText.texte14DemiGras(Colors.white),
                        texte: "Edit Profile",
                        rembourage: EdgeInsets.symmetric(
                            horizontal: h14px, vertical: h8px),
                        onPressed: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => ModificationDuProfile(
                                utilisateur: utilisateur,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Fin -------------------------------------
              ],
            ),
          ),
          SizedBox(
            height: h16px,
          ),
// ? Button de mes parametres --------------------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: h14px),
            child: Column(
              children: [
                SizedBox(
                  height: h60px,
                  child: ElevatedBtn(
                      onPressed: () async {},
                      couleurDubutton: Colors.white,
                      couleurDombreDuButton: Colors.transparent,
                      rondeur: BorderRadius.circular(h16px),
                      enfant: contenuDuButtonMonCompte(
                          icone: Iconsax.user, titreDuButton: "My Account")),
                ),
                SizedBox(
                  height: h16px,
                ),
                SizedBox(
                  height: h60px,
                  child: ElevatedBtn(
                      onPressed: () {},
                      couleurDubutton: Colors.white,
                      couleurDombreDuButton: Colors.transparent,
                      rondeur: BorderRadius.circular(h16px),
                      enfant: contenuDuButtonMonCompte(
                        icone: Iconsax.language_square,
                        titreDuButton: "Language",
                        sousTexte: "English",
                      )),
                ),
                SizedBox(
                  height: h16px,
                ),
                SizedBox(
                  height: h60px,
                  child: ElevatedBtn(
                      onPressed: () {},
                      couleurDubutton: Colors.white,
                      couleurDombreDuButton: Colors.transparent,
                      rondeur: BorderRadius.circular(h16px),
                      enfant: contenuDuButtonMonCompte(
                        icone: Iconsax.setting,
                        titreDuButton: "Settings",
                      )),
                ),
                SizedBox(
                  height: h80px,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
