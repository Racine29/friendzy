import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/modeles/images_modele.dart';

class UtilisateurModel {
  final String? nom;
  final String? id;
  final String? email;
  final String? numeroDeTelephone;
  final String? aPropos;
  final DateTime? dateDeNaissance;
  final String? photographie;
  final String? music;
  final String? geolocalisation;
  List<Images>? images;
  String? imageDuProfil;
  List<CentreDinteretModel>? centreDinterets;
  final String? genre;
  int indicateurDeProgression;
  UtilisateurModel({
    this.aPropos,
    this.dateDeNaissance,
    this.photographie,
    this.music,
    this.geolocalisation,
    this.id,
    this.nom,
    this.email,
    this.numeroDeTelephone,
    this.images,
    this.centreDinterets,
    this.genre,
    this.imageDuProfil,
    this.indicateurDeProgression = 0,
  });

  factory UtilisateurModel.deJSON(Map<String, dynamic> json) {
    return UtilisateurModel(
      id: json["id"],
      nom: json["nom"],
      email: json["email"],
      genre: json["genre"],
      dateDeNaissance: json["dateDeNaissance"],
      music: json["music"],
      aPropos: json["aPropos"],
      photographie: json["photographie"],
      geolocalisation: json["geolocalisation"],
      imageDuProfil: json["imageDuProfil"],
      numeroDeTelephone: json["numeroDeTelephone"],
      indicateurDeProgression: json["indicateurDeProgression"],
      images: json["images"] == null
          ? null
          : (json["images"] as List)
              .map((e) => Images.deJSON(e as Map<String, dynamic>))
              .toList(),
      centreDinterets: (json["centreDinterets"] as List)
          .map((e) => CentreDinteretModel.deJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> aMap() {
    return {
      "id": id,
      "nom": nom,
      "email": email,
      "genre": genre,
      "music": music,
      "geolocalisation": geolocalisation,
      "aPropos": aPropos,
      "photographie": photographie,
      "dateDeNaissance": dateDeNaissance,
      "numeroDeTelephone": numeroDeTelephone,
      "imageDuProfil": imageDuProfil,
      "indicateurDeProgression": indicateurDeProgression,
      "centreDinterets": centreDinterets == null
          ? null
          : centreDinterets!.map((e) => e.aMap()).toList(),
      "images": images == null ? null : images!.map((e) => e.aMap()).toList(),
    };
  }
}
