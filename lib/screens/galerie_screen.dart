
import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_grid_item.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;

  const GalerieScreen({
    super.key,
    required this.livres,
  });

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  // false = grille ; true = liste
  bool _afficherListe = false;

  void _ouvrirDetail(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          livre: livre,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Q6.4 : adapter le nombre de colonnes à la largeur
    final largeur = MediaQuery.of(context).size.width;

    final int nombreColonnes;

    if (largeur < 600) {
      nombreColonnes = 2;
    } else if (largeur < 900) {
      nombreColonnes = 3;
    } else {
      nombreColonnes = 4;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _afficherListe
              ? 'Liste des livres'
              : 'Galerie des livres',
        ),
        actions: [
          // Q6.6 : basculer entre grille et liste
          IconButton(
            tooltip: _afficherListe
                ? 'Afficher la grille'
                : 'Afficher la liste',
            icon: Icon(
              _afficherListe
                  ? Icons.grid_view
                  : Icons.view_list,
            ),
            onPressed: () {
              setState(() {
                _afficherListe = !_afficherListe;
              });
            },
          ),
        ],
      ),

      // Affichage liste ou grille
      body: _afficherListe
          ? _construireListe()
          : _construireGrille(nombreColonnes),
    );
  }

  // Q6.1 et Q6.4 : grille dynamique et responsive
  Widget _construireGrille(int nombreColonnes) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: widget.livres.length,

      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: nombreColonnes,
        childAspectRatio: 0.7,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),

      itemBuilder: (context, index) {
        final livre = widget.livres[index];

        // Q6.2 et Q6.5
        return LivreGridItem(
          livre: livre,
          onTap: () => _ouvrirDetail(livre),
        );
      },
    );
  }

  // Q6.6 : affichage sous forme de liste
  Widget _construireListe() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: widget.livres.length,

      itemBuilder: (context, index) {
        final livre = widget.livres[index];

        return LivreCard(
          livre: livre,
          onTap: () => _ouvrirDetail(livre),
        );
      },
    );
  }
}
