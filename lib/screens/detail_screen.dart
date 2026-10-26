
import 'package:flutter/material.dart';
import '../models/livre.dart';

class DetailScreen extends StatelessWidget {
  final Livre livre;

  const DetailScreen({
    super.key,
    required this.livre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du livre'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // En-tête coloré de 200 pixels
              Container(
                height: 200,
                color: livre.couleur,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Auteur
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Auteur'),
                subtitle: Text(livre.auteur),
              ),

              // Année de publication
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Année'),
                subtitle: Text(livre.annee.toString()),
              ),

              // Genre
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Genre'),
                subtitle: Text(livre.genre),
              ),

              // Boutons d'action
              Padding(
                padding: const EdgeInsets.all(12),
                child: OverflowBar(
                  alignment: MainAxisAlignment.end,
                  spacing: 8,
                  overflowSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Livre ajouté aux favoris',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                      label: const Text(
                        'Ajouter aux favoris',
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Livre marqué comme lu',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text(
                        'Marquer comme lu',
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
