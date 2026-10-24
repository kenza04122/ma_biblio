
import 'package:flutter/material.dart';
import '../models/livre.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;

  const LivreCard({
    super.key,
    required this.livre,
  });

  Widget livreTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: const Icon(
          Icons.menu_book,
          color: Colors.white,
        ),
      ),
      title: Text(
        livre.titre,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '${livre.auteur} • ${livre.annee}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Text(livre.note.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: livreTile(),
    );
  }
}
