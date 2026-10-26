
import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../services/livre_service.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;
  final List<Livre> tousLesLivres;

  const DetailScreen({
    super.key,
    required this.livre,
    required this.tousLesLivres,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final LivreService _service = LivreService();

  Future<void> _sauvegarder() async {
    await _service.sauvegarderLivres(
      widget.tousLesLivres,
    );
  }

  Future<void> _basculerFavori() async {
    setState(() {
      widget.livre.favori = !widget.livre.favori;
    });

    try {
      await _sauvegarder();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.livre.favori
                ? 'Livre ajouté aux favoris'
                : 'Livre retiré des favoris',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de sauvegarde : $e'),
        ),
      );
    }
  }

  Future<void> _basculerLu() async {
    setState(() {
      widget.livre.lu = !widget.livre.lu;
    });

    try {
      await _sauvegarder();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.livre.lu
                ? 'Livre marqué comme lu'
                : 'Livre marqué comme non lu',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de sauvegarde : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du livre'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                color: livre.couleur,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Auteur'),
                subtitle: Text(livre.auteur),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Année'),
                subtitle: Text('${livre.annee}'),
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Genre'),
                subtitle: Text(livre.genre),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: OverflowBar(
                  spacing: 8,
                  overflowSpacing: 8,
                  alignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _basculerFavori,
                      icon: Icon(
                        livre.favori
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        livre.favori
                            ? 'Retirer des favoris'
                            : 'Ajouter aux favoris',
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _basculerLu,
                      icon: Icon(
                        livre.lu
                            ? Icons.check_circle
                            : Icons.check,
                      ),
                      label: Text(
                        livre.lu
                            ? 'Marquer non lu'
                            : 'Marquer comme lu',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
