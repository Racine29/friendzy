import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/modeles/images_modele.dart';

class UtilisateurModel {
  String? nom;
  String? id;
  String? email;
  int? age;
  String? numeroDeTelephone;
  String? aPropos;
  String? dateDeNaissance;
  String? photographie;
  String? music;
  String? geolocalisation;
  List<Images> images;
  String? imageDuProfil;
  List<CentreDinteretModel>? centreDinterets;
  String? genre;
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
    List<Images>? images,
    this.centreDinterets,
    this.genre,
    this.age,
    this.imageDuProfil,
    this.indicateurDeProgression = 0,
  }) : images = images ?? [];

  factory UtilisateurModel.deJSON(Map<String, dynamic> json) {
    return UtilisateurModel(
      id: json["id"],
      nom: json["nom"],
      email: json["email"],
      genre: json["genre"],
      age: json["age"],
      dateDeNaissance: json["dateDeNaissance"],
      music: json["music"],
      aPropos: json["aPropos"],
      photographie: json["photographie"],
      geolocalisation: json["geolocalisation"],
      imageDuProfil: json["imageDuProfil"],
      numeroDeTelephone: json["numeroDeTelephone"],
      indicateurDeProgression: json["indicateurDeProgression"],
      images: json["images"] == null
          ? []
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
      "age": age,
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
      "images": images.isEmpty ? null : images.map((e) => e.aMap()).toList(),
    };
  }
}
