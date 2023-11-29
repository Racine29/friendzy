import 'package:flutter/material.dart';
import 'package:friendzy/pages/onboarding/onboarding_reseau_social.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:sizer/sizer.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  static String page = "onboarding";

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
            "assets/images/onboarding-1.png",
            fit: BoxFit.cover,
          ))),
          Text(
            "Make friends with the\npeople like you",
            textAlign: TextAlign.center,
            style: TailleDuText.texte28Gras(texteCouleurNoir),
          ),
          SizedBox(
            height: h8px,
          ),
          Text(
            "Interact with people the same\ninterest like you",
            textAlign: TextAlign.center,
            style: TailleDuText.texte16Normal(texteCouleurNoir),
          ),
          SizedBox(
            height: h22px,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: h20px),
              child: ElevatedBtn(
                  texte: "Continue",
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnboardingReseauSocial())),
                  style: TailleDuText.texte16Gras(texteCouleurBlanc))),
          SizedBox(
            height: h70px,
          ),
        ],
      ),
    );
  }
}
