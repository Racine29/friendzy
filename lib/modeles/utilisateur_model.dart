import 'package:friendzy/modeles/centre_dinteret_model.dart';

class UtilisateurModel {
  final String? nom;
  final String? id;
  final String? email;
  final String? numeroDeTelephone;
  final List<String>? images;
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
  });

  factory UtilisateurModel.deJSON(Map<String, dynamic> json) {
    return UtilisateurModel(
      id: json["id"],
      nom: json["nom"],
      email: json["email"],
      genre: json["genre"],
      numeroDeTelephone: json["numeroDeTelephone"],
      images: json["images"],
      centreDinterets: json["centreDinterets"] == null
          ? null
          : (json["centreDinterets"] as List<CentreDinteretModel>)
              .map((e) => CentreDinteretModel.deJSON(e.aMap()))
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
      "images": images,
      "centreDinterets": centreDinterets,
    };
  }
}
