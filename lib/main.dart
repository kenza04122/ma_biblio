
import 'package:flutter/material.dart';
import 'models/livre.dart';
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Liste temporaire de livres pour tester l'affichage.
  final List<Livre> livres = const [
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
  ];

  // Widget représentant un livre.
  Widget livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre.isNotEmpty
              ? livre.titre[0].toUpperCase()
              : '?',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(livre.titre),
      subtitle: Text('${livre.auteur} – ${livre.annee}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(livre.note.toString()),
          const SizedBox(width: 4),
          const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: livres.take(3).map(livreTile).toList(),
      ),
    );
  }
}
