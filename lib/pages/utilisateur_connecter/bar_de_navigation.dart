import 'package:flutter/material.dart';
import 'package:friendzy/pages/utilisateur_connecter/accueil.dart';
import 'package:friendzy/pages/utilisateur_connecter/affinite.dart';
import 'package:friendzy/pages/utilisateur_connecter/decouverte.dart';
import 'package:friendzy/pages/utilisateur_connecter/message.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:iconsax/iconsax.dart';

class BarDeNavigation extends StatefulWidget {
  BarDeNavigation();

  static String page = "navigation";

  @override
  State<BarDeNavigation> createState() => _BarDeNavigationState();
}

class _BarDeNavigationState extends State<BarDeNavigation> {
  List<Widget> ecrans = [
    Accueil(),
    Decouverte(),
    Container(),
    Affiniter(),
    Message(),
  ];
  int index = 0;

  BottomNavigationBarItem elementDeNavigation(IconData icone) {
    return BottomNavigationBarItem(
      label: "",
      activeIcon: CircleAvatar(
        backgroundColor: couleurSecondaire,
        child: Icon(
          icone,
          color: Colors.white,
        ),
      ),
      icon: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(icone, color: texteCouleurNoir),
      ),
    );
  }

  Widget menuFlottant() {
    return Container(
        height: h60px,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(h100px),
          boxShadow: [
            BoxShadow(
                blurRadius: 12,
                offset: Offset.zero,
                color: Colors.black.withOpacity(.1))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(h100px),
          child: BottomNavigationBar(
              iconSize: h20px,
              showSelectedLabels: false,
              selectedLabelStyle: const TextStyle(fontSize: 0),
              unselectedLabelStyle: const TextStyle(fontSize: 0),
              currentIndex: index,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.white,
              onTap: (i) {
                if (i != 2) {
                  setState(() {
                    index = i;
                  });
                }
              },
              items: [
                elementDeNavigation(Iconsax.home),
                elementDeNavigation(Iconsax.discover),
                elementDeNavigation(Iconsax.add),
                elementDeNavigation(Iconsax.message),
                elementDeNavigation(Iconsax.user),
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurArrierePlan,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ecrans[index],
          Positioned(
            bottom: h20px,
            left: h20px,
            right: h20px,
            child: menuFlottant(),
          ),
        ],
      ),
    );
  }
}
