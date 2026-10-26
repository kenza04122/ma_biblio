
import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../services/livre_service.dart';

class MaListeScreen extends StatefulWidget {
  final List<Livre> livres;

  const MaListeScreen({
    super.key,
    required this.livres,
  });

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  final LivreService _service = LivreService();

  bool _nouveautesSeulement = false;

  Future<void> _modifierLecture(
    Livre livre,
    bool? valeur,
  ) async {
    final ancienEtat = livre.lu;

    setState(() {
      livre.lu = valeur ?? false;
    });

    try {
      await _service.sauvegarderLivres(widget.livres);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        livre.lu = ancienEtat;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de sauvegarde : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final livresAffiches = widget.livres.where((livre) {
      return !_nouveautesSeulement || livre.nouveaute;
    }).toList();

    final nombreLus =
        livresAffiches.where((livre) => livre.lu).length;

    return Column(
      children: [
        CheckboxListTile(
          title: const Text(
            'Afficher uniquement les nouveautés',
          ),
          value: _nouveautesSeulement,
          onChanged: (valeur) {
            setState(() {
              _nouveautesSeulement = valeur ?? false;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lus : $nombreLus / ${livresAffiches.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: livresAffiches.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1),
            itemBuilder: (context, index) {
              final livre = livresAffiches[index];

              return CheckboxListTile(
                value: livre.lu,
                secondary: CircleAvatar(
                  backgroundColor: livre.couleur,
                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  livre.titre,
                  style: TextStyle(
                    decoration: livre.lu
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  '${livre.auteur} • ${livre.annee}',
                ),
                onChanged: (valeur) {
                  _modifierLecture(livre, valeur);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
