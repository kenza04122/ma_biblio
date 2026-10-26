
import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../services/livre_service.dart';
import 'catalogue_screen.dart';
import 'galerie_screen.dart';
import 'ma_liste_screen.dart';
import 'parametres_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LivreService _service = LivreService();

  late Future<List<Livre>> _futurLivres;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _futurLivres = _service.chargerLivres();
  }

  void _rechargerLivres() {
    setState(() {
      _futurLivres = _service.chargerLivres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _futurLivres,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('MaBiblio')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Erreur : ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        final List<Livre>? livres = snapshot.data;

        if (livres == null) {
          return const Scaffold(
            body: Center(
              child: Text('Aucun livre disponible.'),
            ),
          );
        }

        // Les trois écrans partagent la même liste.
        final List<Widget> ecrans = [
          CatalogueScreen(livres: livres),
          GalerieScreen(livres: livres),
          MaListeScreen(livres: livres),
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text('MaBiblio'),
            actions: [
              IconButton(
                tooltip: 'Paramètres',
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParametresScreen(
                        onReinitialiser: _rechargerLivres,
                      ),
                    ),
                  );

                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ],
          ),

          // Q8.2 : écran associé à l'onglet actif
          body: IndexedStack(
            index: _index,
            children: ecrans,
          ),

          // Q8.1 : navigation du bas
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Catalogue',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_on),
                label: 'Galerie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist),
                label: 'Ma liste',
              ),
            ],
          ),
        );
      },
    );
  }
}
