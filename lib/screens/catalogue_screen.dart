
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatelessWidget {
  final List<Livre> livres;

  const CatalogueScreen({
    super.key,
    required this.livres,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tout le catalogue'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: livres.length,
        itemBuilder: (context, index) {
          final livre = livres[index];

          return LivreCard(
            livre: livre,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    livre: livre,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
