import 'package:flutter/foundation.dart';
import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/modeles/images_modele.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';
import 'package:get_storage/get_storage.dart';

class UtilisateurFournisseur extends ChangeNotifier {
  final Map<String, dynamic> donnees = {};
  List<CentreDinteretModel> centreDinterets = [];
  List<Images> maListeDimages = [];
  final stockage = GetStorage();
  UtilisateurFournisseur() {
    if (stockage.read("utilisateur") != null) {
      final utilisateur = UtilisateurModel.deJSON(stockage.read("utilisateur"));
      ajoutDesCentreDinterets(utilisateur.centreDinterets!);
      completerLesDonnees(utilisateur.aMap());
    }
  }

  completerLesDonnees(Map<String, dynamic> utilisateur) {
    donnees.addAll(utilisateur);

    notifyListeners();
  }

  ajoutDeMaListeDimages(Images donnee) {
    maListeDimages.add(donnee);

    notifyListeners();
  }

  ajoutDesCentreDinterets(List<CentreDinteretModel> donnees) {
    centreDinterets.addAll(donnees);
    notifyListeners();
  }

  ajoutDeCentreDinteret(CentreDinteretModel donnee) {
    centreDinterets.add(donnee);
    notifyListeners();
  }

  supprimerUnCentreDinteret(CentreDinteretModel donnee) {
    centreDinterets.remove(donnee);
    notifyListeners();
  }
}
