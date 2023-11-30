import 'package:flutter/material.dart';
import 'package:friendzy/pages/inscription/etape/centre_dinteret.dart';
import 'package:friendzy/pages/inscription/etape/nom.dart';
import 'package:friendzy/pages/inscription/etape/photo.dart';
import 'package:friendzy/pages/inscription/etape/sexe.dart';
import 'package:friendzy/utilitaires/couleurs.dart';
import 'package:friendzy/utilitaires/taille_des_polices.dart';
import 'package:friendzy/utilitaires/taille_des_textes.dart';
import 'package:friendzy/widget/barreDapplication.dart';
import 'package:friendzy/widget/elevatedBtn.dart';

class EtapeAccueil extends StatefulWidget {
  const EtapeAccueil({super.key});
  static String page = "etape-accueil";

  @override
  State<EtapeAccueil> createState() => _EtapeAccueilState();
}

class _EtapeAccueilState extends State<EtapeAccueil> {
  List<Widget> ecrans = [
    EntrerNom(),
    EntrerSexe(),
    CentreDinteret(),
    EntrerPhoto(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarreDapplication(
        onPressed: () {
          if (index > 0) {
            index--;
          } else if (index == 0) {
            Navigator.of(context).pop();
          }
          setState(() {});
        },
      ),
      backgroundColor: couleurArrierePlan,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: h20px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ecrans[index],
              if (index == (ecrans.length - 1)) ...{
                SizedBox(height: h20px),
                ElevatedBtn(
                  onPressed: () {},
                  texte: "Next",
                  style: TailleDuText.texte16Gras(texteCouleurBlanc),
                ),
              },
              Spacer(),
              Column(
                children: [
                  if (index != (ecrans.length - 1))
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        backgroundColor: couleurPrincipal,
                        onPressed: () {
                          setState(() {
                            if (index < ecrans.length - 1) {
                              index++;
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  SizedBox(height: h20px),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style:
                                TailleDuText.texte24DemiGras(texteCouleurNoir),
                          ),
                          Text(
                            "/${ecrans.length}",
                            style:
                                TailleDuText.texte16DemiGras(couleurSecondaire),
                          ),
                        ],
                      ),
                      LayoutBuilder(builder: (context, contrainte) {
                        double valeur = contrainte.maxWidth;
                        double valeurDeMonEtape = valeur / ecrans.length;
                        return SizedBox(
                          height: h8px - 2,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                left: 0,
                                child: Container(
                                  height: h8px - 2,
                                  width: valeurDeMonEtape * (index + 1),
                                  decoration: BoxDecoration(
                                    color: couleurSecondaire,
                                    borderRadius: BorderRadius.circular(h60px),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: h8px - 2,
                                  decoration: BoxDecoration(
                                    color: couleurSecondaire.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(h60px),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: h20px),
                ],
              ),
            ],
          )),
    );
  }
}
