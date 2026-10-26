
import 'package:flutter/material.dart';
import '../models/livre.dart';

class GalerieScreen extends StatelessWidget {
  final List<Livre> livres;

  const GalerieScreen({
    super.key,
    required this.livres,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie des livres'),
        centerTitle: true,
      ),
      body: GridView.count(
        // Q5.1 : nombre de colonnes
        crossAxisCount: 2,

        // Q5.2 : espaces entre les cases
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),

        // Q5.3 : ratio largeur / hauteur
        childAspectRatio: 0.7,

        // Q5.4 : grille verticale
        scrollDirection: Axis.vertical,

        // Q5.5 : générer les cartes à partir des livres
        children: livres.map((l) {
          return Card(
            color: l.couleur,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 45,
                  ),
                  const SizedBox(height: 10),

                  Text(
                    l.titre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    l.auteur,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
