import 'package:flutter/material.dart';
import 'package:friendzy/pages/inscription-via-numero-telephone/entrer_code_de_confirmation_numero_de_telephone.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/formulaire_numero_de_telephone.dart';
import 'package:iconsax/iconsax.dart';

class EntrerNumeroDeTelephone extends StatefulWidget {
  const EntrerNumeroDeTelephone({super.key});
  static String page = "entrer-numero-de-telephone";

  @override
  State<EntrerNumeroDeTelephone> createState() =>
      _EntrerNumeroDeTelephoneState();
}

class _EntrerNumeroDeTelephoneState extends State<EntrerNumeroDeTelephone> {
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
              "Enter your number",
              textAlign: TextAlign.center,
              style: TailleDuText.texte24Gras(texteCouleurNoir),
            ),
            SizedBox(
              height: h30px,
            ),
            FormulaireNumeroDeTelephone(
              onCountryChanged: (country) {
                setState(() {
                  tailleDuNumeroDeTelephone = country.maxLength;
                });
              },
              initialCountryCode: 'ML',
              invalidNumberMessage:
                  "Veuillez renseigner un numéro valide sous $tailleDuNumeroDeTelephone chiffres",
              onChanged: (phone) {
                setState(() {
                  numeroDeTelephone = "${phone.countryCode} ${phone.number}";
                });
              },
            ),
            const Spacer(),
            ElevatedBtn(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EntrerConfirmationDeCodeDuNumeroDeTelephone())),
                texte: "Continue",
                style: TailleDuText.texte16DemiGras(texteCouleurBlanc)),
            SizedBox(height: h40px),
          ],
        ),
      ),
    );
  }
}
