import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';
import 'package:friendzy/pages/inscription/etape/etape_accueil.dart';
import 'package:friendzy/pages/onboarding/onboarding_reseau_social.dart';
import 'package:friendzy/pages/utilisateur_connecter/bar_de_navigation.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:provider/provider.dart';

class EcranEmballage extends StatefulWidget {
  const EcranEmballage({super.key});
  static String page = "/";
  @override
  State<EcranEmballage> createState() => _EcranEmballageState();
}

class _EcranEmballageState extends State<EcranEmballage> {
  final service = ServicesDauthentifications();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: service.estConnecter,
      builder: (context, AsyncSnapshot<User?> utilisateur) {
        print("Le nom de mon est -${utilisateur.data?.displayName}");
        if (utilisateur.hasData && utilisateur.data?.displayName != null) {
          return StreamProvider<UtilisateurModel>(
            create: (_) => service.donneesDeLutilisateur,
            initialData: UtilisateurModel(),
            child: BarDeNavigation(),
          );
        } else if (utilisateur.hasData &&
            utilisateur.data?.displayName == null) {
          return const EtapeAccueil();
        }
        return const OnboardingReseauSocial();
      },
    );
  }
}
