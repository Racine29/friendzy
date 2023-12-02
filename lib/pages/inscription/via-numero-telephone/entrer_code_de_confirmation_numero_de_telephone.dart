import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/modeles/utilisateur_model.dart';
import 'package:friendzy/pages/ecran_chargement.dart';
import 'package:friendzy/pages/ecran_emballage.dart';
import 'package:friendzy/pages/inscription/etape/etape_accueil.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/barreDapplication.dart';
import 'package:friendzy/widget/elevatedBtn.dart';
import 'package:friendzy/widget/formulaire_verification_de_telephone.dart';
import 'package:provider/provider.dart';

class EntrerConfirmationDeCodeDuNumeroDeTelephone extends StatefulWidget {
  const EntrerConfirmationDeCodeDuNumeroDeTelephone({super.key});
  static String page = "entrer-code-de-confirmation-numero-de-telephone";

  @override
  State<EntrerConfirmationDeCodeDuNumeroDeTelephone> createState() =>
      _EntrerConfirmationDeCodeDuNumeroDeTelephone();
}

class _EntrerConfirmationDeCodeDuNumeroDeTelephone
    extends State<EntrerConfirmationDeCodeDuNumeroDeTelephone> {
  int delaiDattente = 60;
  bool delaiEstVerifier = true;
  String codeDeMonSms = "";

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (delaiEstVerifier) {
        if (delaiDattente > 0) {
          if (mounted) {
            setState(() {
              delaiDattente--;
            });
          }
        } else if (delaiDattente == 0) {
          if (mounted) {
            setState(() {
              delaiEstVerifier = false;
              delaiDattente = 60;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fournisseur = Provider.of<UtilisateurFournisseur>(context);
    return Scaffold(
      appBar: const BarreDapplication(),
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
              "Enter 6-digits code",
              textAlign: TextAlign.center,
              style: TailleDuText.texte24Gras(texteCouleurNoir),
            ),
            SizedBox(
              height: h30px,
            ),
            if (delaiEstVerifier)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter OTP code we sent to",
                    textAlign: TextAlign.center,
                    style: TailleDuText.texte16Normal(texteCouleurNoir),
                  ),
                  Text(
                    "${fournisseur.donnees['numeroDeTelephone'].toString().substring(0, 8)}++",
                    textAlign: TextAlign.center,
                    style: TailleDuText.texte16DemiGras(couleurPrincipal),
                  ),
                ],
              ),
            if (delaiEstVerifier)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "This code will expired in ",
                    textAlign: TextAlign.center,
                    style: TailleDuText.texte16Normal(texteCouleurNoir),
                  ),
                  Text(
                    " $delaiDattente secondes",
                    textAlign: TextAlign.center,
                    style: TailleDuText.texte16DemiGras(couleurSecondaire),
                  ),
                ],
              ),
            SizedBox(height: h40px),
            FormulaireVerificationDuNumeroDeTelephone(
              onChanged: (code) {
                codeDeMonSms = code;
              },
            ),
            SizedBox(height: h40px),
            if (!delaiEstVerifier)
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "Don't received the code ?",
                    textAlign: TextAlign.center,
                    style: TailleDuText.texte16Normal(texteCouleurNoir),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        delaiEstVerifier = true;
                      });
                      await ServicesDauthentifications()
                          .authentification
                          .verifyPhoneNumber(
                              forceResendingToken:
                                  fournisseur.donnees["reenvoieDuToken"],
                              phoneNumber:
                                  fournisseur.donnees["numeroDeTelephone"],
                              verificationCompleted: (_) {},
                              verificationFailed:
                                  (FirebaseAuthException error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(error.code),
                                ));
                              },
                              codeSent: (_, __) {},
                              codeAutoRetrievalTimeout: (_) {});
                    },
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
                onPressed: () {
                  Chargement(context);
                  Future.delayed(const Duration(milliseconds: 30));
                  PhoneAuthCredential credentiel = PhoneAuthProvider.credential(
                      verificationId: fournisseur.donnees["verificationId"],
                      smsCode: codeDeMonSms);
                  fournisseur.completerLesDonnees({"credentiel": credentiel});
                  final authentification = ServicesDauthentifications();
                  // verifier si ce utilisateur est inscrit
                  authentification.utilisateurCollection
                      .where("numeroDeTelephone",
                          isEqualTo: fournisseur.donnees["numeroDeTelephone"])
                      .get()
                      .then((QuerySnapshot snapshot) async {
                    // Si lutilisateur n'existe pas l'enregitrer
                    UtilisateurModel utilisateur = UtilisateurModel.deJSON(
                        snapshot.docs.first.data() as Map<String, dynamic>);
                    if (snapshot.size != 1) {
                      Navigator.popAndPushNamed(context, EtapeAccueil.page);
                    }
                    // Si il existe aller sur la page d'accueil
                    else if (utilisateur.nom != null) {
                      await authentification.authentification
                          .signInWithCredential(credentiel);
                      Navigator.popAndPushNamed(context, EcranEmballage.page);
                    } else if (utilisateur.nom == null) {
                      Navigator.popAndPushNamed(context, EtapeAccueil.page);
                    }
                  });
                },
                texte: "Verify",
                style: TailleDuText.texte16Gras(texteCouleurBlanc)),
            SizedBox(height: h40px),
          ],
        ),
      ),
    );
  }
}
