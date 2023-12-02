import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';

Future Chargement(
  BuildContext context,
) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: h100px,
            height: h100px,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(h20px),
            ),
            child: const Center(
                child: CircularProgressIndicator(
              color: couleurPrincipal,
            )),
          ),
        );
      });
}
