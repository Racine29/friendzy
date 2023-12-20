class CentreDinteretModel {
  final String image;
  final String? id;
  final String nom;

  CentreDinteretModel({required this.image, required this.nom, this.id});

  factory CentreDinteretModel.deJSON(Map<String, dynamic> json) {
    return CentreDinteretModel(
        image: json["image"], nom: json["nom"], id: json["id"]);
  }

  Map<String, dynamic> aMap() {
    return {
      "id": id,
      "nom": nom,
      "image": image,
    };
  }
}
