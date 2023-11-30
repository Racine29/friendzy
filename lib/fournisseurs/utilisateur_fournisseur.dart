import 'package:flutter/foundation.dart';

class UtilisateurFournisseur extends ChangeNotifier {
  final Map<String, dynamic> donnees = {};

  completerLesDonnees(Map<String, dynamic> utilisateur) {
    donnees.addAll(utilisateur);
    notifyListeners();
  }
}
