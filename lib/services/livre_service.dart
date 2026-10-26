
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/livre.dart';

class LivreService {
  static const String _assetPath = 'assets/livres.json';
  static const String _localFileName = 'mabiblio.json';

  // Chemin du fichier local
  Future<File> _obtenirFichierLocal() async {
    final dossier = await getApplicationDocumentsDirectory();

    return File('${dossier.path}/$_localFileName');
  }

  // Q7.4 + Q7.8 : charger les livres
  Future<List<Livre>> chargerLivres() async {
    final fichier = await _obtenirFichierLocal();

    String contenu;

    if (await fichier.exists()) {
      // Priorité aux données sauvegardées
      contenu = await fichier.readAsString();
    } else {
      // Première ouverture : charger l'asset
      contenu = await rootBundle.loadString(_assetPath);
    }

    final List<dynamic> donnees = jsonDecode(contenu);

    return donnees.map((element) {
      return Livre.fromJson(
        element as Map<String, dynamic>,
      );
    }).toList();
  }

  // Q7.7 : sauvegarder les livres
  Future<void> sauvegarderLivres(
    List<Livre> livres,
  ) async {
    final fichier = await _obtenirFichierLocal();

    final contenu = jsonEncode(
      livres.map((l) => l.toJson()).toList(),
    );

    await fichier.writeAsString(contenu);
  }

  // Q7.10 : supprimer les données locales
  Future<void> reinitialiserBibliotheque() async {
    final fichier = await _obtenirFichierLocal();

    if (await fichier.exists()) {
      await fichier.delete();
    }
  }
}
