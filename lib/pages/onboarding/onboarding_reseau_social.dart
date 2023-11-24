import 'package:flutter/material.dart';
import 'package:friendzy/pages/inscription-via-numero-telephone/entrer_numero_de_telephone.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/elevatedBtnAvecIcone.dart';
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
            padding: EdgeInsets.symmetric(horizontal: h40px),
            child: ElevatedBtnAvecIcone(
                texte: "Login with Phone",
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EntrerNumeroDeTelephone())),
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
            padding: EdgeInsets.symmetric(horizontal: h40px),
            child: ElevatedBtnAvecIcone(
                texte: "Login with Google",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account ? ",
                textAlign: TextAlign.center,
                style: TailleDuText.texte16Normal(texteCouleurNoir),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TailleDuText.texte16DemiGras(couleurSecondaire),
                ),
              ),
            ],
          ),
          SizedBox(
            height: h30px + 10,
          ),
        ],
      ),
    );
  }
}