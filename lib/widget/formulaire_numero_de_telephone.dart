import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/widget/bordure_du_champ_formulaire.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class FormulaireNumeroDeTelephone extends StatelessWidget {
  Function(PhoneNumber)? onChanged;
  Function(Country)? onCountryChanged;

  String? initialValue;
  String? invalidNumberMessage;
  String? initialCountryCode;
  TextEditingController? phoneNumberController;
  FormulaireNumeroDeTelephone({
    this.onChanged,
    this.initialValue,
    this.onCountryChanged,
    this.invalidNumberMessage,
    this.initialCountryCode,
    this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      searchText: "Chercher un pays",
      invalidNumberMessage: invalidNumberMessage,
      onCountryChanged: onCountryChanged,
      initialValue: initialValue,
      controller: phoneNumberController,
      cursorColor: couleurPrincipal,
      dropdownIcon: const Icon(
        Icons.arrow_drop_down,
        color: couleurPrincipal,
      ),
      decoration: InputDecoration(
        hintText: "n° de téléphone",
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
        fillColor: Colors.white,
      ),
      initialCountryCode: initialCountryCode,
      onSubmitted: (phone) {},
      onChanged: onChanged,
    );
  }
}
