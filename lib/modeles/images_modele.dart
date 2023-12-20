import 'package:flutter_image_compress/flutter_image_compress.dart';

class Images {
  String? nom;
  XFile? fichier;
  String? url;
  Images({this.nom, this.fichier, this.url});

  factory Images.deJSON(Map<String, dynamic> json) {
    return Images(nom: json["nom"], url: json["url"]);
  }

  Map<String, dynamic> aMap() {
    return {
      "nom": nom,
      "url": url,
    };
  }
}
