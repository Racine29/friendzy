import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';
import 'package:friendzy/pages/inscription/etape/centre_dinteret.dart';
import 'package:friendzy/pages/inscription/etape/nom.dart';
import 'package:friendzy/pages/inscription/etape/photo.dart';
import 'package:friendzy/pages/inscription/etape/sexe.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/barreDapplication.dart';
import 'package:friendzy/widget/button_etape_inscription.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class EtapeAccueil extends StatefulWidget {
  const EtapeAccueil({super.key});
  static String page = "etape-accueil";

  @override
  State<EtapeAccueil> createState() => _EtapeAccueilState();
}

class _EtapeAccueilState extends State<EtapeAccueil> {
  List<Widget> ecrans = [
    EntrerNom(),
    EntrerSexe(),
    CentreDinteret(),
    EntrerPhoto(),
  ];
  int index = 0;

  final stockage = GetStorage();
  enregistrerLesDonneesDunUtilisateur(
      UtilisateurFournisseur fournisseur,
      ServicesDauthentifications serviceDauthentification,
      ModalRoute? parametres) async {
    if (fournisseur.donnees["numeroDeTelephone"] != null) {
      // connexion via le numero de telephone
      PhoneAuthCredential numeroCredentiel =
          fournisseur.donnees["numero-credentiel"];

      final connexionViaNumeroDeTelephone = await serviceDauthentification
          .authentification
          .signInWithCredential(numeroCredentiel);

      // creation d'un utilisateur
      final infoDeMonUtilisateur1 = UtilisateurModel(
        id: connexionViaNumeroDeTelephone.user?.uid,
        nom: fournisseur.donnees["nom"],
        genre: fournisseur.donnees["genre"],
        numeroDeTelephone: fournisseur.donnees["numeroDeTelephone"],
        centreDinterets: fournisseur.centreDinterets,
        indicateurDeProgression: fournisseur.indicateurDeProgression,
      );
      await serviceDauthentification
          .enregistrerUnUtilisateur(infoDeMonUtilisateur1);
      fournisseur.completerLesDonnees(infoDeMonUtilisateur1.aMap());

      await stockage.write("utilisateur", infoDeMonUtilisateur1.aMap());
    } else {
      // connexion via google

      AuthCredential googleCredentiel = (parametres?.settings.arguments
          as Map<String, dynamic>)["google-credentiel"];

      final connexionViaGoogle = await serviceDauthentification.authentification
          .signInWithCredential(googleCredentiel);
      await serviceDauthentification.authentification.currentUser!
          .updateDisplayName("");
      final infoDeMonUtilisateur2 = UtilisateurModel(
        id: connexionViaGoogle.user?.uid,
        nom: fournisseur.donnees["nom"],
        genre: fournisseur.donnees["genre"],
        email: connexionViaGoogle.user?.email,
        centreDinterets: fournisseur.centreDinterets,
        indicateurDeProgression: fournisseur.indicateurDeProgression,
      );
      await serviceDauthentification
          .enregistrerUnUtilisateur(infoDeMonUtilisateur2);
      print("je sui de ja ici -----------------------");
      fournisseur.completerLesDonnees(infoDeMonUtilisateur2.aMap());
      await stockage.write("utilisateur", infoDeMonUtilisateur2.aMap());
    }
  }

  bool vide(int index, UtilisateurFournisseur fournisseur) {
    if (index == 0 && fournisseur.donnees["nom"] == null ||
        fournisseur.donnees["nom"] == "") {
      return true;
    } else if (index == 1 && fournisseur.donnees["genre"] == null ||
        fournisseur.donnees["genre"] == "") {
      return true;
    } else if (index == 2 && fournisseur.centreDinterets.length < 5) {
      return true;
    } else {
      return false;
    }
  }

  final service = ServicesDauthentifications();

  @override
  Widget build(BuildContext context) {
    ModalRoute? parametres = ModalRoute.of(context);
    final fournisseur =
        Provider.of<UtilisateurFournisseur>(context, listen: true);
    return Scaffold(
      appBar: BarreDapplication(
        onPressed: () {
          if (index > 0) {
            index--;
            fournisseur.indicateurMiseAJour(index);
          } else if (index == 0) {
            Navigator.of(context).pop();
          }
          setState(() {});
        },
      ),
      backgroundColor: couleurArrierePlan,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: h20px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ecrans[index],
              const Spacer(),
              Column(
                children: [
                  if (index != (ecrans.length - 1))
                    ButtonEtapeDinscription(
                        ecrans: ecrans,
                        index: index,
                        vide: vide(index, fournisseur),
                        mettreAjoursLindexDeMaPage: () {
                          setState(() {
                            index++;
                          });
                          fournisseur.indicateurMiseAJour(index);
                        },
                        enregistrerLesDonnees: () async {
                          final serviceDauthentification =
                              ServicesDauthentifications();
                          final utilisateur = await serviceDauthentification
                              .recupererUnUtilisateur();

                          if (utilisateur?.id == null) {
                            enregistrerLesDonneesDunUtilisateur(fournisseur,
                                serviceDauthentification, parametres);
                          } else {
                            final mesCentreDinterets = fournisseur
                                .centreDinterets
                                .map((e) => e.aMap())
                                .toList();
                            fournisseur.completerLesDonnees(
                              {
                                "id": utilisateur?.id,
                                "centreDinterets": mesCentreDinterets,
                              },
                            );
                            await serviceDauthentification
                                .miseAJourDesInformationsDeMonUtilisateur(
                                    UtilisateurModel.deJSON(
                                        fournisseur.donnees));
                          }
                        }),
                  SizedBox(height: h20px),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style:
                                TailleDuText.texte24DemiGras(texteCouleurNoir),
                          ),
                          Text(
                            "/${ecrans.length}",
                            style:
                                TailleDuText.texte16DemiGras(couleurSecondaire),
                          ),
                        ],
                      ),
                      LayoutBuilder(builder: (context, contrainte) {
                        double valeur = contrainte.maxWidth;
                        double valeurDeMonEtape = valeur / ecrans.length;
                        return SizedBox(
                          height: h8px - 2,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                left: 0,
                                child: Container(
                                  height: h8px - 2,
                                  width: valeurDeMonEtape * (index + 1),
                                  decoration: BoxDecoration(
                                    color: couleurSecondaire,
                                    borderRadius: BorderRadius.circular(h60px),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: h8px - 2,
                                  decoration: BoxDecoration(
                                    color: couleurSecondaire.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(h60px),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: h20px),
                ],
              ),
            ],
          )),
    );
  }
}
