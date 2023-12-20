import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/sexe_carte.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class EntrerSexe extends StatefulWidget {
  const EntrerSexe({super.key});
  static String page = "entrer-sexe";
  @override
  State<EntrerSexe> createState() => _EntrerSexeState();
}

class _EntrerSexeState extends State<EntrerSexe> {
  bool estUnHomme = false;
  bool estUneFemme = false;

  final stockage = GetStorage();

  changerLetatDuSexe(bool femme, bool homme) {
    setState(() {
      estUnHomme = homme;
      estUneFemme = femme;
    });
  }

  @override
  void initState() {
    super.initState();

    final fournisseur =
        Provider.of<UtilisateurFournisseur>(context, listen: false);

    if (fournisseur.donnees["genre"] == 'Homme') {
      changerLetatDuSexe(false, true);
    } else if (fournisseur.donnees["genre"] == 'Femme') {
      changerLetatDuSexe(true, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.of(context).size;
    final fournisseur =
        Provider.of<UtilisateurFournisseur>(context, listen: true);
    return Column(
      children: [
        SizedBox(
          height: h10px,
        ),
        Text(
          "What is your gender",
          textAlign: TextAlign.center,
          style: TailleDuText.texte24Gras(texteCouleurNoir),
        ),
        SizedBox(
          height: h30px,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                estUnHomme = true;
                estUneFemme = false;
                fournisseur.completerLesDonnees({"genre": "Homme"});
                setState(() {});
              },
              child: SexeCarte(
                taille: taille,
                couleur: couleurPrincipal,
                sexe: "Man",
                sonSexe: estUnHomme,
                icone: Icon(
                  Icons.male_outlined,
                  size: h40px,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: h10px,
            ),
            GestureDetector(
              onTap: () {
                estUneFemme = true;
                estUnHomme = false;
                fournisseur.completerLesDonnees({"genre": "Femme"});
                setState(() {});
              },
              child: SexeCarte(
                taille: taille,
                couleur: couleurSecondaire,
                sexe: "Woman",
                sonSexe: estUneFemme,
                icone: Icon(
                  Icons.female_outlined,
                  size: h40px,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
