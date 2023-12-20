import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/modeles/images_modele.dart';

class UtilisateurModel {
  final String? nom;
  final String? id;
  final String? email;
  final String? numeroDeTelephone;
  List<Images>? images;
  String? imageDuProfil;
  List<CentreDinteretModel>? centreDinterets;
  final String? genre;
  UtilisateurModel({
    this.id,
    this.nom,
    this.email,
    this.numeroDeTelephone,
    this.images,
    this.centreDinterets,
    this.genre,
    this.imageDuProfil,
  });

  factory UtilisateurModel.deJSON(Map<String, dynamic> json) {
    return UtilisateurModel(
      id: json["id"],
      nom: json["nom"],
      email: json["email"],
      genre: json["genre"],
      imageDuProfil: json["imageDuProfil"],
      numeroDeTelephone: json["numeroDeTelephone"],
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
      "numeroDeTelephone": numeroDeTelephone,
      "imageDuProfil": imageDuProfil,
      "centreDinterets": centreDinterets == null
          ? null
          : centreDinterets!.map((e) => e.aMap()).toList(),
      "images": images == null ? null : images!.map((e) => e.aMap()).toList(),
    };
  }
}
