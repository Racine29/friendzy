import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/bordure_du_champ_formulaire.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class EntrerNom extends StatelessWidget {
  EntrerNom({super.key});
  static String page = "entrer-nom";
  final stockage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final fournisseur =
        Provider.of<UtilisateurFournisseur>(context, listen: true);

    return Column(
      children: [
        SizedBox(
          height: h10px,
        ),
        Text(
          "What's your name ?",
          textAlign: TextAlign.center,
          style: TailleDuText.texte24Gras(texteCouleurNoir),
        ),
        SizedBox(
          height: h30px,
        ),
        TextFormField(
          validator: (valeur) {
            return valeur!.isEmpty ? "Champ vide." : null;
          },
          onChanged: (valeur) {
            fournisseur.completerLesDonnees({
              "nom": valeur,
            });
          },
          initialValue: fournisseur.donnees["nom"],
          cursorColor: couleurPrincipal,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: h16px, horizontal: h10px),
            focusedBorder: bordureDuChampFormulaire(color: couleurSecondaire),
            disabledBorder: bordureDuChampFormulaire(color: couleurSecondaire),
            focusedErrorBorder: bordureDuChampFormulaire(color: Colors.red),
            enabledBorder: bordureDuChampFormulaire(color: couleurSecondaire),
            errorBorder: bordureDuChampFormulaire(
              color: Colors.red,
            ),
            filled: true,
            fillColor: texteCouleurBlanc,
          ),
        ),
      ],
    );
  }
}
