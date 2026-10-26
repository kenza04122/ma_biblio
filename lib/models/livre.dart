
import 'package:flutter/material.dart';

class Livre {
  final String titre;
  final String auteur;
  final int annee;
  final double note;
  final Color couleur;
  final String genre;
  bool lu;

  Livre({
    required this.titre,
    required this.auteur,
    required this.annee,
    required this.note,
    required this.couleur,
    required this.genre,
    this.lu = false,
  });
}
