import 'package:flutter/material.dart';
import 'package:friendzy/fournisseurs/utilisateur_fournisseur.dart';
import 'package:friendzy/modeles/poste_modele.dart';
import 'package:friendzy/services/service_dauthentification.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  Accueil({super.key});
  static String page = "accueil";

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Map<String, dynamic>> histoires = [
    {
      "image": "assets/histoires/1.jpg",
      "nom": "My Story",
    },
    {
      "image": "assets/histoires/2.jpg",
      "nom": "Selena",
    },
    {
      "image": "assets/histoires/3.jpg",
      "nom": "Clara",
    },
    {
      "image": "assets/histoires/4.jpg",
      "nom": "Fabian",
    },
    {
      "image": "assets/histoires/5.jpg",
      "nom": "Jhon",
    },
    {
      "image": "assets/histoires/6.jpg",
      "nom": "Selena",
    },
    {
      "image": "assets/histoires/7.jpg",
      "nom": "Clara",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.sizeOf(context);
    final tailleDeMesPostes = taille.height * .5;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: h70px,
        backgroundColor: couleurArrierePlan,
        title: Text(
          "Friendzy",
          style: TailleDuText.texte28Gras(texteCouleurVoilet),
        ),
        actions: [
          Center(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(h100px),
                border: Border.all(color: couleurPrincipal.withOpacity(.2)),
              ),
              child: InkWell(
                onTap: () async {
                  final fournisseur = Provider.of<UtilisateurFournisseur>(
                      context,
                      listen: false);

                  fournisseur.centreDinterets.clear();
                  fournisseur.donnees.clear();
                  await GoogleSignIn().signOut();
                  await ServicesDauthentifications().authentification.signOut();
                },
                borderRadius: BorderRadius.circular(h100px),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Iconsax.notification,
                        color: texteCouleurNoir,
                        size: h22px,
                      ),
                    ),
                    Positioned(
                      right: (50 / 2) - h8px - 3,
                      top: (50 / 2) - h8px - 2,
                      child: Container(
                        height: h8px,
                        width: h8px,
                        decoration: BoxDecoration(
                          color: couleurSecondaire,
                          borderRadius: BorderRadius.circular(h100px),
                          border: Border.all(
                              color: couleurPrincipal.withOpacity(.2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: h10px,
          )
        ],
      ),
      backgroundColor: couleurArrierePlan,
      body: ListView(children: [
        //  Histoires ----------------------------------------------------------------
        SizedBox(
          height: h100px,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: histoires.length,
              padding: EdgeInsets.symmetric(horizontal: h12px),
              itemBuilder: (_, index) {
                final histoire = histoires[index];
                String nom = histoire["nom"];
                String image = histoire["image"];
                return index == 0
                    ? carteDuneHistoire(
                        image: image,
                        nom: nom,
                        pasDeBordure: true,
                        enfant: Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: h20px,
                            width: h20px,
                            decoration: BoxDecoration(
                                color: couleurSecondaire,
                                borderRadius: BorderRadius.circular(h100px),
                                border:
                                    Border.all(width: 2, color: Colors.white)),
                            child: Icon(Iconsax.add,
                                size: h14px, color: Colors.white),
                          ),
                        ),
                      )
                    : carteDuneHistoire(image: image, nom: nom);
              }),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: h12px),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: postes.length,
              itemBuilder: (context, index) {
                final poste = postes[index];
                return Container(
                  height: tailleDeMesPostes,
                  width: taille.width,
                  margin: EdgeInsets.symmetric(vertical: h10px),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(h20px),
                  ),
                  child: Stack(fit: StackFit.expand, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(h20px),
                      child: Image.asset(
                        poste.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h20px),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.2),
                            Colors.black.withOpacity(.3),
                          ],
                        ),
                      ),
                    ),

                    // ? Centre d'interet --------------------------------
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                          height: h40px,
                          padding: EdgeInsets.symmetric(horizontal: h8px),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                poste.centreDinteret.image,
                                height: h14px,
                              ),
                              SizedBox(
                                width: h6px,
                              ),
                              Text(
                                poste.centreDinteret.nom,
                                style: TailleDuText.texte16Normal(
                                    texteCouleurBlanc),
                              )
                            ],
                          )),
                    ),

                    Positioned(
                      right: 0,
                      top: (tailleDeMesPostes / 2) - ((h100px + h40px) / 2),
                      child: Container(
                        height: h100px + h40px,
                        padding: EdgeInsets.symmetric(
                          horizontal: h8px,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(h22px),
                              bottomLeft: Radius.circular(h22px),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 24,
                              backgroundColor: Colors.white.withOpacity(.45),
                              child: Icon(
                                Iconsax.like_15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: h12px),
                            CircleAvatar(
                              maxRadius: 24,
                              backgroundColor: Colors.white.withOpacity(.45),
                              child: Icon(
                                Iconsax.message1,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                        left: 20,
                        bottom: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: taille.width / 1.5,
                              child: Text(
                                poste.description.length < 80
                                    ? poste.description
                                    : "${poste.description.substring(0, 80)}...",
                                style: TailleDuText.texte18DemiGras(
                                  Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h8px,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(h100px),
                                  child: SizedBox(
                                    height: h45px,
                                    width: h45px,
                                    child: Image.asset(
                                      poste.utilisateur.imageDuProfil ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: h6px),
                                Text(
                                  poste.utilisateur.nom!.length < 10
                                      ? poste.utilisateur.nom!
                                      : "${poste.utilisateur.nom!.substring(0, 10)}...",
                                  style: TailleDuText.texte16DemiGras(
                                      Colors.white),
                                ),
                              ],
                            )
                          ],
                        ))
                  ]),
                );
              }),
        ),

        SizedBox(height: h100px),
      ]),
    );
  }
}

class carteDuneHistoire extends StatelessWidget {
  carteDuneHistoire(
      {super.key,
      required this.image,
      required this.nom,
      this.pasDeBordure = false,
      this.enfant = const SizedBox()});

  final String image;
  final String nom;
  bool pasDeBordure;
  Widget enfant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: h16px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: h60px,
                width: h60px,
                padding: EdgeInsets.all(pasDeBordure ? 0 : 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(h100px),
                    border: Border.all(
                        width: pasDeBordure ? 1 : 2,
                        color: pasDeBordure
                            ? Colors.grey.withOpacity(.2)
                            : couleurSecondaire)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(h100px),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              enfant
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            nom.length < 10 ? nom : "${nom.substring(0, 10)}...",
            style: TailleDuText.texte14Normal(texteCouleurNoir),
          ),
        ],
      ),
    );
  }
}
