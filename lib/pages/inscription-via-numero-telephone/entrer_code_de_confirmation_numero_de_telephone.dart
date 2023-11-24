import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/formulaire_numero_de_telephone.dart';
import 'package:friendzy/widget/formulaire_verification_de_telephone.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';

class EntrerConfirmationDeCodeDuNumeroDeTelephone extends StatefulWidget {
  const EntrerConfirmationDeCodeDuNumeroDeTelephone({super.key});
  static String page = "entrer-numero-de-telephone";

  @override
  State<EntrerConfirmationDeCodeDuNumeroDeTelephone> createState() =>
      _EntrerConfirmationDeCodeDuNumeroDeTelephone();
}

class _EntrerConfirmationDeCodeDuNumeroDeTelephone
    extends State<EntrerConfirmationDeCodeDuNumeroDeTelephone> {
  int tailleDuNumeroDeTelephone = 8;
  String numeroDeTelephone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Center(
          child: SizedBox(
            width: h40px,
            height: h40px,
            child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: const BorderSide(color: couleurPrincipal))),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: texteCouleurNoir,
                  size: h20px,
                )),
          ),
        ),
        backgroundColor: couleurArrierePlan,
      ),
      backgroundColor: couleurArrierePlan,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: h40px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: h10px,
            ),
            Text(
              "Enter 6-digits code",
              textAlign: TextAlign.center,
              style: TailleDuText.texte24Gras(texteCouleurNoir),
            ),
            SizedBox(
              height: h30px,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter OTP code we sent to",
                  textAlign: TextAlign.center,
                  style: TailleDuText.texte16Normal(texteCouleurNoir),
                ),
                Text(
                  "+1234++",
                  textAlign: TextAlign.center,
                  style: TailleDuText.texte16DemiGras(couleurPrincipal),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This code will expired in ",
                  textAlign: TextAlign.center,
                  style: TailleDuText.texte16Normal(texteCouleurNoir),
                ),
                Text(
                  "01:23",
                  textAlign: TextAlign.center,
                  style: TailleDuText.texte16DemiGras(couleurSecondaire),
                ),
              ],
            ),
            SizedBox(height: h40px),
            FormulaireVerificationDuNumeroDeTelephone(),
            SizedBox(height: h40px),
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
                    "Resend code",
                    textAlign: TextAlign.center,
                    style: TailleDuText.texte16DemiGras(couleurSecondaire),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedBtn(
                onPressed: () {},
                texte: "Verify",
                style: TailleDuText.texte16DemiGras(texteCouleurBlanc)),
            SizedBox(height: h40px),
          ],
        ),
      ),
    );
  }
}
