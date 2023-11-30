import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/sexe_carte.dart';

class EntrerSexe extends StatefulWidget {
  const EntrerSexe({super.key});
  static String page = "entrer-sexe";
  @override
  State<EntrerSexe> createState() => _EntrerSexeState();
}

class _EntrerSexeState extends State<EntrerSexe> {
  bool estUnHomme = false;
  bool estUneFemme = false;

  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.of(context).size;
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
                setState(() {});
                estUnHomme = true;
                estUneFemme = false;
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
                setState(() {});
                estUneFemme = true;
                estUnHomme = false;
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
