import 'package:flutter/material.dart';
import 'package:friendzy/pages/inscription/via-numero-telephone/entrer_code_de_confirmation_numero_de_telephone.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/barreDapplication.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/formulaire_numero_de_telephone.dart';

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
      appBar: BarreDapplication(),
      backgroundColor: couleurArrierePlan,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: h20px),
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
                style: TailleDuText.texte16Gras(texteCouleurBlanc)),
            SizedBox(height: h40px),
          ],
        ),
      ),
    );
  }
}
