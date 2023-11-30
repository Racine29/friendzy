import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/pages/onboarding/onboarding.dart';
import 'package:sizer/sizer.dart';
import "package:provider/provider.dart";

void main() {
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
            home: Onboarding(),
          );
        });
      },
    );
  }
}
