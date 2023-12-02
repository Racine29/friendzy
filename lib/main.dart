import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendzy/firebase_options.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/pages/ecran_emballage.dart';
import 'package:friendzy/pages/inscription/etape/centre_dinteret.dart';
import 'package:friendzy/pages/inscription/etape/nom.dart';
import 'package:friendzy/pages/inscription/etape/photo.dart';
import 'package:friendzy/pages/inscription/etape/sexe.dart';
import 'package:friendzy/pages/inscription/via-numero-telephone/entrer_code_de_confirmation_numero_de_telephone.dart';
import 'package:friendzy/pages/inscription/via-numero-telephone/entrer_numero_de_telephone.dart';
import 'package:friendzy/pages/onboarding/onboarding.dart';
import 'package:friendzy/pages/onboarding/onboarding_reseau_social.dart';
import 'package:friendzy/pages/seFaireDesAmis/accueil.dart';
import 'package:sizer/sizer.dart';
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UtilisateurFournisseur())
      ],
      builder: (context, _) {
        return Sizer(builder: (context, _, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Hellix"),
            initialRoute: Onboarding.page,
            routes: {
              Onboarding.page: (context) => Onboarding(),
              EcranEmballage.page: (context) => EcranEmballage(),
              Accueil.page: (context) => Accueil(),
              OnboardingReseauSocial.page: (context) =>
                  OnboardingReseauSocial(),
              EntrerNumeroDeTelephone.page: (context) =>
                  EntrerNumeroDeTelephone(),
              EntrerConfirmationDeCodeDuNumeroDeTelephone.page: (context) =>
                  EntrerConfirmationDeCodeDuNumeroDeTelephone(),
              EntrerNom.page: (context) => EntrerNom(),
              EntrerSexe.page: (context) => EntrerSexe(),
              EntrerPhoto.page: (context) => EntrerPhoto(),
              CentreDinteret.page: (context) => CentreDinteret(),
            },
          );
        });
      },
    );
  }
}
