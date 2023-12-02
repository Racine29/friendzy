import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/pages/ecran_chargement.dart';
import 'package:friendzy/pages/inscription/via-numero-telephone/entrer_code_de_confirmation_numero_de_telephone.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/barreDapplication.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/formulaire_numero_de_telephone.dart';
import 'package:provider/provider.dart';

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
  bool numeroEstCorrect = false;
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
              onCountryChanged: (pays) {
                setState(() {
                  tailleDuNumeroDeTelephone = pays.maxLength;
                });
              },
              initialCountryCode: 'ML',
              invalidNumberMessage:
                  "Veuillez renseigner un numéro valide sous $tailleDuNumeroDeTelephone chiffres",
              onChanged: (telephone) {
                setState(() {
                  numeroDeTelephone =
                      "${telephone.countryCode} ${telephone.number}";
                  numeroEstCorrect =
                      telephone.number.length == tailleDuNumeroDeTelephone;
                });
              },
            ),
            const Spacer(),
            ElevatedBtn(
                onPressed: !numeroEstCorrect
                    ? null
                    : () async {
                        FocusNode().unfocus();
                        final service = ServicesDauthentifications();
                        Chargement(context);
                        await service.authentification.verifyPhoneNumber(
                            phoneNumber: numeroDeTelephone,
                            verificationCompleted: (_) {},
                            verificationFailed: (FirebaseAuthException error) {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(error.code),
                              ));
                            },
                            codeSent: (verificationId, reenvoieDuToken) async {
                              final fournisseur =
                                  Provider.of<UtilisateurFournisseur>(context,
                                      listen: false);
                              fournisseur.completerLesDonnees({
                                "verificationID": verificationId,
                                "reenvoieDuToken": reenvoieDuToken,
                                "numeroDeTelephone": numeroDeTelephone,
                              });
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context,
                                  EntrerConfirmationDeCodeDuNumeroDeTelephone
                                      .page);
                            },
                            codeAutoRetrievalTimeout: (_) {});
                      },
                texte: "Continue",
                style: TailleDuText.texte16Gras(texteCouleurBlanc)),
            SizedBox(height: h40px),
          ],
        ),
      ),
    );
  }
}
