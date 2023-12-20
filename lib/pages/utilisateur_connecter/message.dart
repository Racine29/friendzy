import 'package:flutter/material.dart';
import 'package:friendzy/utilitaires/couleurs.dart';

class Message extends StatelessWidget {
  const Message({super.key});
  static String page = "message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurArrierePlan,
    );
  }
}
