import "dart:io";

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_image_compress/flutter_image_compress.dart";
import "package:friendzy/fournisseurs/utilisateur_fournisseur.dart";
import "package:friendzy/modeles/centre_dinteret_modele.dart";
import "package:friendzy/modeles/utilisateur_modele.dart";
import "package:friendzy/pages/ecran_chargement.dart";
import "package:friendzy/pages/inscription/etape/centre_dinteret.dart";
import "package:friendzy/pages/inscription/etape/photo.dart";
import "package:friendzy/services/service_dauthentification.dart";
import "package:friendzy/utilitaires/couleurs.dart";
import "package:friendzy/utilitaires/taille_des_polices.dart";
import "package:friendzy/utilitaires/taille_des_textes.dart";
import "package:friendzy/widget/barreDapplication.dart";
import "package:friendzy/widget/bordure_du_champ_formulaire.dart";
import "package:friendzy/widget/elevatedBtn.dart";
import "package:friendzy/widget/sexe_carte.dart";
import 'package:flutter/cupertino.dart';
import "package:provider/provider.dart";
import 'package:friendzy/widget/photo_carte.dart';
import 'package:friendzy/modeles/images_modele.dart';
import 'package:friendzy/services/service_image.dart';

class ModificationDuProfile extends StatefulWidget {
  const ModificationDuProfile({super.key, required this.utilisateur});
  static String page = "modification_du_profile";
  final UtilisateurModel utilisateur;

  @override
  State<ModificationDuProfile> createState() => _ModificationDuProfileState();
}

class _ModificationDuProfileState extends State<ModificationDuProfile> {
  Widget formulaireSimple(
      {String? valeurInitiale,
      TextEditingController? controller,
      bool lire = false,
      VoidCallback? surClique}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h16px),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: couleurPrincipal.withOpacity(.04),
          ),
        ],
      ),
      child: TextFormField(
        cursorColor: couleurPrincipal,
        controller: controller,
        readOnly: lire,
        onTap: surClique,
        style: TailleDuText.texte16DemiGras(texteCouleurNoir),
        decoration: InputDecoration(
          filled: true,
          fillColor: texteCouleurBlanc,
          border: bordureDuChampFormulaire(color: Colors.transparent),
          focusedBorder: bordureDuChampFormulaire(color: couleurPrincipal),
          disabledBorder: bordureDuChampFormulaire(color: Colors.transparent),
          focusedErrorBorder: bordureDuChampFormulaire(color: Colors.red),
          enabledBorder: bordureDuChampFormulaire(color: Colors.transparent),
          errorBorder: bordureDuChampFormulaire(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget formulaireMultiLine(
      {String? valeurInitiale, TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h16px),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: couleurPrincipal.withOpacity(.04),
          ),
        ],
      ),
      child: TextFormField(
        cursorColor: couleurPrincipal,
        initialValue: valeurInitiale,
        controller: controller,
        maxLines: 3,
        style: TailleDuText.texte16DemiGras(texteCouleurNoir),
        decoration: InputDecoration(
          filled: true,
          fillColor: texteCouleurBlanc,
          border: bordureDuChampFormulaire(color: Colors.transparent),
          focusedBorder: bordureDuChampFormulaire(color: couleurPrincipal),
          disabledBorder: bordureDuChampFormulaire(color: Colors.transparent),
          focusedErrorBorder: bordureDuChampFormulaire(color: Colors.red),
          enabledBorder: bordureDuChampFormulaire(color: Colors.transparent),
          errorBorder: bordureDuChampFormulaire(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  TextEditingController controlleurDateDeNaissance = TextEditingController();

  surCliqueDuFormulaireDateDeNaissance(
      {DateTime? dateDeNaissanceActuelle}) async {
    final datePick = await showDatePicker(
        context: context,
        locale: const Locale("fr", "FR"),
        initialDate: dateDeNaissanceActuelle ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(DateTime.now().year, 12, 31),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: couleurPrincipal,
              ),
            ),
            child: child!,
          );
        });

    if (datePick != null) {
      setState(() {
        controlleurDateDeNaissance.text = datePick.toString().split(" ")[0];
      });
    }
  }

  late TextEditingController controlleurDeNom = TextEditingController();
  late TextEditingController controlleurDeGenre = TextEditingController();
  late TextEditingController controlleurDeAPropos = TextEditingController();

  late TextEditingController controlleurDePhotographie =
      TextEditingController();
  late TextEditingController controlleurDeMusic = TextEditingController();
  late TextEditingController controlleurGeolocalisation =
      TextEditingController();

  bool estUnHomme = false;
  bool estUneFemme = false;

  @override
  void initState() {
    super.initState();

    controlleurDeNom = TextEditingController(text: widget.utilisateur.nom);
    controlleurDeGenre = TextEditingController(text: widget.utilisateur.genre);
    controlleurGeolocalisation =
        TextEditingController(text: widget.utilisateur.geolocalisation);
    controlleurDeAPropos =
        TextEditingController(text: widget.utilisateur.aPropos);
    controlleurDePhotographie =
        TextEditingController(text: widget.utilisateur.photographie);
    controlleurDeMusic = TextEditingController(text: widget.utilisateur.music);
    final fournisseur =
        Provider.of<UtilisateurFournisseur>(context, listen: false);
    if (fournisseur.centreDinterets.isNotEmpty) {
      widget.utilisateur.centreDinterets = fournisseur.centreDinterets;
    }
    if (widget.utilisateur.genre == "Homme") {
      estUneFemme = false;
      estUnHomme = true;
    } else {
      estUneFemme = true;
      estUnHomme = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controlleurDePhotographie.clear();
    controlleurDeNom.clear();
    controlleurDeAPropos.clear();
    controlleurDateDeNaissance.clear();
    controlleurGeolocalisation.clear();
    controlleurDeMusic.clear();
    controlleurDeGenre.clear();
    controlleurDeMusic.dispose();
    controlleurDeGenre.dispose();
    controlleurDePhotographie.dispose();
    controlleurDeNom.dispose();
    controlleurGeolocalisation.dispose();
    controlleurDeAPropos.dispose();
    controlleurDateDeNaissance.dispose();
  }

  List<CentreDinteretModel> mesCentresDinterets = [];
  tousLesCentresDinterets() async {
    mesCentresDinterets =
        await ServicesDauthentifications().tousLesCentresDinterets();
  }

  Widget puceACentreDinterets(List<CentreDinteretModel> centreDinterets) {
    return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: centreDinterets.map((e) {
          final monCentreDinteret = widget.utilisateur.centreDinterets!
              .where((element) => element.nom == e.nom);
          return Container(
              padding: EdgeInsets.symmetric(horizontal: h8px, vertical: h10px),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: couleurPrincipal.withOpacity(.3), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: e.image,
                    height: h16px,
                  ),
                  SizedBox(
                    width: h6px,
                  ),
                  Text(
                    e.nom,
                    style: TailleDuText.texte16Normal(texteCouleurNoir),
                  ),
                  if (widget.utilisateur.centreDinterets!.length > 5) ...{
                    SizedBox(
                      width: h6px,
                    ),
                    InkWell(
                      onTap: () {
                        widget.utilisateur.centreDinterets!
                            .remove(monCentreDinteret.first);
                        print(widget.utilisateur.centreDinterets);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: couleurPrincipal.withOpacity(.3),
                        size: h16px,
                      ),
                    )
                  }
                ],
              ));
        }).toList());
  }

  XFile? imagePrincipal;
  XFile? image1;
  XFile? image2;
  XFile? image3;
  XFile? image4;
  XFile? image5;
  List<Images> images = [];
  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.of(context).size;
    final fournisseur = Provider.of<UtilisateurFournisseur>(context);
    return Scaffold(
      appBar: BarreDapplication(
        titre: Text(
          "Edit Profile",
          style: TailleDuText.texte24DemiGras(texteCouleurNoir),
        ),
        centrerLeTitre: true,
        couleurArriereFond: couleurGris50,
      ),
      backgroundColor: couleurGris50,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: h20px),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PhotoCarte(
                      taille: taille,
                      tailleDeMonEmoji: h100px,
                      largeur: taille.width * .5,
                      hauteur: taille.height * .28,
                      hauteurDuButton: h30px,
                      fichier: imagePrincipal,
                      imageUrl: widget.utilisateur.imageDuProfil,
                      changerTexteDuButton: true,
                      surClique: () async {
                        final image =
                            await ImageService().selectionnerUneImage();
                        if (image != null) {
                          imagePrincipal = image;
                          images.add(Images(
                              nom: "imageDuProfil", fichier: imagePrincipal));
                          setState(() {});
                        }
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PhotoCarte(
                          taille: taille,
                          tailleDeMonEmoji: h36px,
                          largeur: taille.width * .35,
                          hauteur: taille.height * .13,
                          hauteurDuButton: h30px,
                          fichier: image1,
                          imageUrl: widget.utilisateur.images.isNotEmpty &&
                                  widget.utilisateur.images
                                      .where(
                                          (element) => element.nom == "image1")
                                      .isNotEmpty
                              ? widget.utilisateur.images
                                  .where((element) => element.nom == "image1")
                                  .first
                                  .url
                              : null,
                          surClique: () async {
                            final image =
                                await ImageService().selectionnerUneImage();
                            if (image != null) {
                              image1 = image;
                              images
                                  .add(Images(nom: "image1", fichier: image1));
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(
                          height: h10px,
                        ),
                        PhotoCarte(
                          taille: taille,
                          tailleDeMonEmoji: h36px,
                          largeur: taille.width * .35,
                          hauteur: taille.height * .13,
                          hauteurDuButton: h30px,
                          fichier: image2,
                          imageUrl: widget.utilisateur.images.isNotEmpty &&
                                  widget.utilisateur.images
                                      .where(
                                          (element) => element.nom == "image2")
                                      .isNotEmpty
                              ? widget.utilisateur.images
                                  .where((element) => element.nom == "image2")
                                  .first
                                  .url
                              : null,
                          surClique: () async {
                            final image =
                                await ImageService().selectionnerUneImage();
                            if (image != null) {
                              image2 = image;
                              images
                                  .add(Images(nom: "image2", fichier: image2));
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: h10px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PhotoCarte(
                      taille: taille,
                      tailleDeMonEmoji: h36px,
                      largeur: taille.width * .28,
                      hauteur: taille.height * .13,
                      hauteurDuButton: h30px,
                      fichier: image3,
                      imageUrl: widget.utilisateur.images.isNotEmpty &&
                              widget.utilisateur.images
                                  .where((element) => element.nom == "image3")
                                  .isNotEmpty
                          ? widget.utilisateur.images
                              .where((element) => element.nom == "image3")
                              .first
                              .url
                          : null,
                      surClique: () async {
                        final image =
                            await ImageService().selectionnerUneImage();
                        if (image != null) {
                          image3 = image;
                          images.add(Images(nom: "image3", fichier: image3));
                          setState(() {});
                        }
                      },
                    ),
                    PhotoCarte(
                      taille: taille,
                      tailleDeMonEmoji: h36px,
                      largeur: taille.width * .28,
                      hauteur: taille.height * .13,
                      hauteurDuButton: h30px,
                      fichier: image4,
                      imageUrl: widget.utilisateur.images.isNotEmpty &&
                              widget.utilisateur.images
                                  .where((element) => element.nom == "image4")
                                  .isNotEmpty
                          ? widget.utilisateur.images
                              .firstWhere((element) => element.nom == "image4")
                              .url
                          : null,
                      surClique: () async {
                        final image =
                            await ImageService().selectionnerUneImage();
                        if (image != null) {
                          image4 = image;
                          images.add(Images(nom: "image4", fichier: image4));
                          setState(() {});
                        }
                      },
                    ),
                    PhotoCarte(
                      taille: taille,
                      tailleDeMonEmoji: h36px,
                      largeur: taille.width * .28,
                      hauteur: taille.height * .13,
                      hauteurDuButton: h30px,
                      fichier: image5,
                      imageUrl: widget.utilisateur.images.isNotEmpty &&
                              widget.utilisateur.images
                                  .where((element) => element.nom == "image5")
                                  .isNotEmpty
                          ? widget.utilisateur.images
                              .where((element) => element.nom == "image5")
                              .first
                              .url
                          : null,
                      surClique: () async {
                        final image =
                            await ImageService().selectionnerUneImage();
                        if (image != null) {
                          image5 = image;
                          images.add(Images(nom: "image5", fichier: image5));
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: h16px),
                Text(
                  "PERSONAL DETAILS",
                  style: TailleDuText.texte16DemiGras(couleurGris400),
                ),
                SizedBox(height: h16px),
                Text(
                  "Full Name",
                  style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                ),
                SizedBox(height: h8px),
                formulaireSimple(controller: controlleurDeNom),
                SizedBox(height: h16px),
                Text(
                  "Birthdate",
                  style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                ),
                SizedBox(height: h8px),
                formulaireSimple(
                  lire: true,
                  controller: controlleurDateDeNaissance.text.isNotEmpty
                      ? controlleurDateDeNaissance
                      : TextEditingController(
                          text: widget.utilisateur.dateDeNaissance),
                  surClique: () {
                    surCliqueDuFormulaireDateDeNaissance(
                        dateDeNaissanceActuelle:
                            widget.utilisateur.dateDeNaissance != null
                                ? DateTime.parse(
                                    widget.utilisateur.dateDeNaissance!)
                                : null);
                  },
                ),
                SizedBox(height: h16px),
                Text(
                  "About",
                  style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                ),
                SizedBox(height: h8px),
                formulaireMultiLine(controller: controlleurDeAPropos),
                SizedBox(height: h16px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Interests",
                      style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        fournisseur.centreDinterets =
                            widget.utilisateur.centreDinterets!;

                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => Scaffold(
                              appBar: const BarreDapplication(),
                              body: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: h20px),
                                child: const CentreDinteret(
                                  modifierMonCompte: true,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Edit",
                        style: TailleDuText.texte16DemiGras(couleurSecondaire),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h8px),
                widget.utilisateur.centreDinterets == null
                    ? const SizedBox()
                    : puceACentreDinterets(widget.utilisateur.centreDinterets!),
                SizedBox(height: h24px),
                Text(
                  "Describe my interested",
                  style: TailleDuText.texte16Gras(texteCouleurNoir),
                ),
                SizedBox(height: h12px),
                Text(
                  "Photography",
                  style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                ),
                SizedBox(height: h8px),
                formulaireMultiLine(controller: controlleurDePhotographie),
                SizedBox(height: h16px),
                Text(
                  "Music",
                  style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                ),
                SizedBox(height: h8px),
                formulaireMultiLine(controller: controlleurDeMusic),
                SizedBox(height: h16px),
                Text(
                  "Gender",
                  style: TailleDuText.texte16DemiGras(texteCouleurNoir),
                ),
                SizedBox(height: h8px),
                formulaireSimple(
                    controller: controlleurDeGenre,
                    lire: true,
                    surClique: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            changerLetatDuSexe(bool femme, bool homme) {
                              setState(() {
                                estUnHomme = homme;
                                estUneFemme = femme;
                                if (estUnHomme) {
                                  controlleurDeGenre.text = "Homme";
                                }
                                if (estUneFemme) {
                                  controlleurDeGenre.text = "Femme";
                                }
                              });
                            }

                            return Container(
                              height: h300px,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(h16px),
                                    topLeft: Radius.circular(h16px),
                                  )),
                              child: Column(
                                children: [
                                  SizedBox(height: h14px),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Container(
                                        height: h40px,
                                        width: h40px,
                                        margin: EdgeInsets.only(left: h12px),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: couleurGris400),
                                            borderRadius:
                                                BorderRadius.circular(h300px)),
                                        child: Icon(Icons.close, size: h20px),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h14px),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: h20px),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            changerLetatDuSexe(false, true);
                                          },
                                          child: SexeCarte(
                                            taille: taille,
                                            couleur: couleurPrincipal,
                                            sexe: "Man",
                                            sonSexe: estUnHomme,
                                            icone: Icon(
                                              Icons.male_outlined,
                                              size: h40px,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: h10px,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            changerLetatDuSexe(true, false);
                                          },
                                          child: SexeCarte(
                                            taille: taille,
                                            couleur: couleurSecondaire,
                                            sexe: "Woman",
                                            sonSexe: estUneFemme,
                                            icone: Icon(
                                              Icons.female_outlined,
                                              size: h40px,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    }),
                SizedBox(height: h24px),
                ElevatedBtn(
                  couleurDombreDuButton: Colors.white,
                  onPressed: () async {
                    final serviceDauthentification =
                        ServicesDauthentifications();
                    FocusScope.of(context).unfocus();
                    Chargement(context);

                    widget.utilisateur.nom = controlleurDeNom.text;
                    widget.utilisateur.aPropos = controlleurDeAPropos.text;
                    widget.utilisateur.photographie =
                        controlleurDePhotographie.text;
                    widget.utilisateur.music = controlleurDeMusic.text;
                    widget.utilisateur.genre = controlleurDeGenre.text;

                    if (controlleurDateDeNaissance.text.isNotEmpty) {
                      final dateDeNaissance = controlleurDateDeNaissance.text
                              .trim()
                              .isNotEmpty
                          ? DateTime.parse(controlleurDateDeNaissance.text)
                          : DateTime.parse(widget.utilisateur.dateDeNaissance!);
                      widget.utilisateur.age =
                          (DateTime.now().difference(dateDeNaissance).inDays /
                                  365.2)
                              .truncate();
                    }
                    widget.utilisateur.dateDeNaissance =
                        controlleurDateDeNaissance.text.trim().isNotEmpty
                            ? controlleurDateDeNaissance.text
                            : widget.utilisateur.dateDeNaissance;

                    for (int i = 0; i < images.length; ++i) {
                      final image = images[i];
                      final url =
                          await serviceDauthentification.telechargerUneImage(
                              File(image.fichier!.path), "photo");
                      if (image.nom == "imageDuProfil") {
                        widget.utilisateur.imageDuProfil = url;
                      } else {
                        widget.utilisateur.images
                            .add(Images(nom: image.nom, url: url));
                      }
                    }

                    await ServicesDauthentifications()
                        .miseAJourDesInformationsDeMonUtilisateur(
                            widget.utilisateur);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  texte: "Save Changes",
                  style: TailleDuText.texte16DemiGras(texteCouleurBlanc),
                  rembourage: EdgeInsets.symmetric(vertical: h20px),
                  couleurDubutton: couleurPrincipal,
                ),
                SizedBox(height: h40px),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
