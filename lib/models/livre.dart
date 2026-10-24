
import 'package:flutter/material.dart';
import '../models/livre.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  static const List<Livre> livres = [
    Livre(
      titre: 'Le Petit Prince',
      auteur: 'Antoine de Saint-Exupéry',
      annee: 1943,
      note: 4.8,
      couleur: Colors.blue,
    ),
    Livre(
      titre: 'Les Misérables',
      auteur: 'Victor Hugo',
      annee: 1862,
      note: 4.7,
      couleur: Colors.green,
    ),
    Livre(
      titre: 'L’Étranger',
      auteur: 'Albert Camus',
      annee: 1942,
      note: 4.5,
      couleur: Colors.orange,
    ),
    Livre(
      titre: 'Le Comte de Monte-Cristo',
      auteur: 'Alexandre Dumas',
      annee: 1844,
      note: 4.9,
      couleur: Colors.purple,
    ),
    Livre(
      titre: 'Madame Bovary',
      auteur: 'Gustave Flaubert',
      annee: 1857,
      note: 4.3,
      couleur: Colors.red,
    ),
  ];

  
  Widget livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre.isNotEmpty
              ? livre.titre[0].toUpperCase()
              : '?',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(livre.titre),
      subtitle: Text('${livre.auteur} – ${livre.annee}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(livre.note.toString()),
          const Icon(Icons.star, color: Colors.amber),
        ],
      ),
    );
  }


  Widget livreCard(Livre livre) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: livre.couleur,
                child: Text(
                  livre.titre[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                livre.titre,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text('${livre.note} ★'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio - Catalogue'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

         
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: livres.length,
              itemBuilder: (context, index) {
                return livreCard(livres[index]);
              },
            ),
          ),

         
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

         
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: livres.length,
            itemBuilder: (context, index) {
              return livreTile(livres[index]);
            },
          ),
        ],
      ),
    );
  }
}
