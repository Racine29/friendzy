import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/modeles/utilisateur_model.dart';
import 'package:friendzy/pages/onboarding/onboarding_reseau_social.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:provider/provider.dart';
import 'package:friendzy/pages/seFaireDesAmis/accueil.dart';

class EcranEmballage extends StatefulWidget {
  const EcranEmballage({super.key});
  static String page = "/";
  @override
  State<EcranEmballage> createState() => _EcranEmballageState();
}

class _EcranEmballageState extends State<EcranEmballage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ServicesDauthentifications().estConnecter,
      builder: (context, AsyncSnapshot<User?> utilisateur) {
        if (utilisateur.hasData) {
          return StreamProvider<UtilisateurModel>(
            create: (context) =>
                ServicesDauthentifications().donneesDeLutilisateur,
            initialData: UtilisateurModel(),
            child: Accueil(),
          );
        }
        return const OnboardingReseauSocial();
      },
    );
  }
}
