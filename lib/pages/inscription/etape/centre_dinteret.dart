import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import "package:provider/provider.dart";

class CentreDinteret extends StatefulWidget {
  const CentreDinteret({super.key});
  static String page = "entrer-centre-interet";

  @override
  State<CentreDinteret> createState() => _CentreDinteretState();
}

class _CentreDinteretState extends State<CentreDinteret> {
  List<CentreDinteretModel> centredinterets = [];

  final service = ServicesDauthentifications();

  recupererTousLesCentresDinterets() async {
    final donnees = await service.tousLesCentresDinterets();
    if (donnees.isNotEmpty) {
      centredinterets = donnees;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    recupererTousLesCentresDinterets();
  }

  @override
  Widget build(BuildContext context) {
    final fournisseur = Provider.of<UtilisateurFournisseur>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: h10px,
        ),
        Text(
          "Select up to 5 interests",
          textAlign: TextAlign.center,
          style: TailleDuText.texte24Gras(texteCouleurNoir),
        ),
        SizedBox(
          height: h30px,
        ),
        centredinterets.isEmpty
            ? SizedBox(
                height: h100px,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: couleurPrincipal,
                  ),
                ),
              )
            : Wrap(
                spacing: 6,
                runSpacing: 14,
                children: centredinterets.map((e) {
                  final monCentreDinteret = fournisseur.centreDinterets
                      .where((element) => element.nom == e.nom);
                  return GestureDetector(
                    onTap: () {
                      if (monCentreDinteret.isNotEmpty) {
                        fournisseur
                            .supprimerUnCentreDinteret(monCentreDinteret.first);
                      } else {
                        fournisseur.ajoutDeCentreDinteret(e);
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: h8px, vertical: h10px),
                        decoration: BoxDecoration(
                          color: monCentreDinteret.isNotEmpty
                              ? couleurSecondaire
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: couleurPrincipal.withOpacity(.3),
                              width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              e.image,
                              height: h16px,
                            ),
                            SizedBox(
                              width: h8px,
                            ),
                            Text(
                              e.nom,
                              style: TailleDuText.texte16Normal(
                                  monCentreDinteret.isNotEmpty
                                      ? texteCouleurBlanc
                                      : texteCouleurNoir),
                            )
                          ],
                        )),
                  );
                }).toList(),
              ),
      ],
    );
  }
}
