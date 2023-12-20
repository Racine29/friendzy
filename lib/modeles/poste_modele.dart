import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';

class PosteModel {
  final String id;
  final CentreDinteretModel centreDinteret;
  final String description;
  final DateTime dateDeCreation;
  final String image;
  final UtilisateurModel utilisateur;

  PosteModel({
    required this.image,
    required this.id,
    required this.centreDinteret,
    required this.description,
    required this.dateDeCreation,
    required this.utilisateur,
  });

  PosteModel.deJSON(Map<String, dynamic> json)
      : id = json["id"],
        centreDinteret = CentreDinteretModel.deJSON(
            json["centreDinteret"] as Map<String, dynamic>),
        description = json["description"],
        image = json["image"],
        utilisateur = UtilisateurModel.deJSON(
            json["utilisateur"] as Map<String, dynamic>),
        dateDeCreation = json["dateDeCreation"];

  Map<String, dynamic> aMap() {
    return {
      "id": id,
      "image": image,
      "centreDinteret": centreDinteret.aMap(),
      "description": description,
      "utilisateur": utilisateur.aMap(),
      "dateDeCreation": dateDeCreation,
    };
  }
}

List<PosteModel> postes = [
  // PosteModel(
  //   id: "1",
  //   image: "assets/paysages/1.jpg",
  //   centreDinteret: centredinterets.first,
  //   description:
  //       "If you could live anywhere in the world , where would you pick?",
  //   dateDeCreation: DateTime.now(),
  //   utilisateur: UtilisateurModel(
  //     imageDuProfil: "assets/histoires/1.jpg",
  //     nom: "Micheal",
  //   ),
  // ),
  // PosteModel(
  //   id: "2",
  //   image: "assets/paysages/2.jpg",
  //   centreDinteret: centredinterets.last,
  //   description:
  //       "If you could live anywhere in the world , where would you pick?",
  //   dateDeCreation: DateTime.now(),
  //   utilisateur: UtilisateurModel(
  //     imageDuProfil: "assets/histoires/2.jpg",
  //     nom: "Selena",
  //   ),
  // ),
  // PosteModel(
  //   id: "3",
  //   image: "assets/paysages/3.jpg",
  //   centreDinteret: centredinterets[1],
  //   description:
  //       "If you could live anywhere in the world , where would you pick?",
  //   dateDeCreation: DateTime.now(),
  //   utilisateur: UtilisateurModel(
  //     imageDuProfil: "assets/histoires/3.jpg",
  //     nom: "Clara",
  //   ),
  // ),
];
