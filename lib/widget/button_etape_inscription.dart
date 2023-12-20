import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:friendzy/pages/ecran_chargement.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ButtonEtapeDinscription extends StatelessWidget {
  ButtonEtapeDinscription({
    super.key,
    required this.ecrans,
    required this.index,
    required this.mettreAjoursLindexDeMaPage,
    required this.enregistrerLesDonnees,
    this.vide = false,
  });
  int index;
  final List<Widget> ecrans;
  VoidCallback mettreAjoursLindexDeMaPage;
  VoidCallback enregistrerLesDonnees;
  bool vide;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        backgroundColor: vide ? Colors.grey.shade300 : couleurPrincipal,
        onPressed: vide
            ? null
            : () async {
                if (index < ecrans.length - 1 && index != ecrans.length - 2) {
                  FocusScope.of(context).unfocus();
                  Chargement(context);

                  await Future.delayed(const Duration(milliseconds: 340));

                  Navigator.pop(context);

                  mettreAjoursLindexDeMaPage();
                } else if (index == ecrans.length - 2) {
                  bool result = await InternetConnectionChecker().hasConnection;
                  if (result) {
                    Chargement(context);
                    enregistrerLesDonnees();

                    await Future.delayed(const Duration(milliseconds: 340));

                    Navigator.pop(context);

                    mettreAjoursLindexDeMaPage();
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "Veuillez verifier l'etat de votre connexion interent.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red.withOpacity(.2),
                        textColor: Colors.red,
                        fontSize: 16.0);
                  }
                }
              },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
