
import 'package:flutter/material.dart';
import '../models/livre.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({
    super.key,
    required this.livre,
    this.onTap,
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
          const SizedBox(width: 4),
          Text(livre.note.toString()),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      surfaceTintColor: Colors.blue,
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: livreTile(),
      ),
    );
  }
}
