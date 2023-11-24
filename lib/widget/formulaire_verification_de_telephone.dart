import "package:flutter/material.dart";
import "package:friendzy/utilitaires/couleurs.dart";
import "package:friendzy/utilitaires/taille_des_polices.dart";
import "package:friendzy/utilitaires/taille_des_textes.dart";
import "package:pinput/pinput.dart";

class FormulaireVerificationDuNumeroDeTelephone extends StatelessWidget {
  Function(String)? onChanged;
  FormulaireVerificationDuNumeroDeTelephone({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      focusedPinTheme: PinTheme(
          height: h70px,
          textStyle: TailleDuText.texte16DemiGras(texteCouleurNoir),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: couleurSecondaire,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          )),
      defaultPinTheme: PinTheme(
        height: h70px,
        textStyle: TailleDuText.texte16DemiGras(texteCouleurNoir),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
