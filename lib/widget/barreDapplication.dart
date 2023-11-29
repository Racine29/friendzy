import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';

class BarreDapplication extends StatelessWidget implements PreferredSizeWidget {
  const BarreDapplication({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 80,
      toolbarHeight: 70,
      leading: Center(
        child: SizedBox(
          width: h40px,
          height: h40px,
          child: OutlinedButton(
              onPressed: onPressed ?? () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: const BorderSide(color: couleurPrincipal))),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: texteCouleurNoir,
                size: h16px,
              )),
        ),
      ),
      backgroundColor: couleurArrierePlan,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
