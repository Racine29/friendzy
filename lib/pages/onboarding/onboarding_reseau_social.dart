import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/pages/ecran_chargement.dart';
import 'package:friendzy/pages/ecran_emballage.dart';
import 'package:friendzy/pages/inscription/etape/etape_accueil.dart';
import 'package:friendzy/pages/inscription/via-numero-telephone/entrer_numero_de_telephone.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtnAvecIcone.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingReseauSocial extends StatelessWidget {
  const OnboardingReseauSocial({super.key});
  static String page = "onboarding-reseau-social";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Center(
                  child: Image.asset(
            "assets/images/onboarding-2.png",
            fit: BoxFit.cover,
          ))),
          Text(
            "Let's meeting new\npeople around you",
            textAlign: TextAlign.center,
            style: TailleDuText.texte28Gras(texteCouleurNoir),
          ),
          SizedBox(
            height: h22px,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: h20px),
            child: ElevatedBtnAvecIcone(
                texte: "Login with Phone",
                onPressed: () {
                  Navigator.pushNamed(context, EntrerNumeroDeTelephone.page);
                },
                couleurDubutton: couleurPrincipal,
                icone: const Icon(
                  Iconsax.call,
                  color: texteCouleurNoir,
                ),
                style: TailleDuText.texte16Gras(texteCouleurBlanc)),
          ),
          SizedBox(
            height: h14px,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: h20px),
            child: ElevatedBtnAvecIcone(
                texte: "Login with Google",
                onPressed: () async {
                  final service = ServicesDauthentifications();
                  List<dynamic>? mesDonnneViaGoogle =
                      await service.connexionViaGoogle();
                  AuthCredential? credentiel = mesDonnneViaGoogle?.first;
                  GoogleSignInAccount? utilisateur = mesDonnneViaGoogle?.last;

                  Chargement(context);
                  if (credentiel?.accessToken != null) {
                    try {
                      service.utilisateurCollection
                          .where("email", isEqualTo: utilisateur?.email)
                          .get()
                          .then((QuerySnapshot snapshot) async {
                        // Si lutilisateur n'existe pas l'enregitrer
                        if (snapshot.docs.isEmpty) {
                          Navigator.popAndPushNamed(context, EtapeAccueil.page,
                              arguments: {
                                "google-credentiel": credentiel,
                              });
                        } else {
                          // Si il existe aller sur la page d'accueil

                          await service.authentification
                              .signInWithCredential(credentiel!);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              EcranEmballage.page, (route) => false);
                        }
                      });
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(e.code),
                      ));
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                couleurDubutton: couleurTertiaire,
                icone: Image.asset(
                  "assets/images/google-icon.png",
                  height: 22,
                ),
                style: TailleDuText.texte16Gras(texteCouleurNoir)),
          ),
          SizedBox(
            height: h22px,
          ),
          SizedBox(
            height: h30px + 10,
          ),
        ],
      ),
    );
  }
}
