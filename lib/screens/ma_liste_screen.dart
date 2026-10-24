
import 'package:flutter/material.dart';
import '../models/livre.dart';

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
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Roman': true,
    'Science-fiction': true,
    'Policier': true,
    'Fantastique': true,
    'Biographie': true,
    'Informatique': true,
  };

  final Map<String, IconData> _iconesGenres = {
    'Roman': Icons.menu_book,
    'Science-fiction': Icons.science,
    'Policier': Icons.search,
    'Fantastique': Icons.auto_awesome,
    'Biographie': Icons.person,
    'Informatique': Icons.computer,
  };

  final Map<String, Color> _couleursGenres = {
    'Roman': Colors.blue,
    'Science-fiction': Colors.deepPurple,
    'Policier': Colors.red,
    'Fantastique': Colors.orange,
    'Biographie': Colors.teal,
    'Informatique': Colors.green,
  };

  bool get _tousCoches =>
      _genres.values.every((coche) => coche);

  bool get _aucunCoche =>
      _genres.values.every((coche) => !coche);

  bool? get _etatTousLesGenres {
    if (_tousCoches) return true;
    if (_aucunCoche) return false;
    return null;
  }

  // Livres correspondant aux genres sélectionnés
  List<Livre> get _livresFiltres {
    return widget.livres.where((livre) {
      return _genres[livre.genre] == true;
    }).toList();
  }

  // Sélectionner ou désélectionner tous les genres
  void _changerTousLesGenres(bool? valeur) {
    final bool cocher = !_tousCoches;

    setState(() {
      for (final genre in _genres.keys.toList()) {
        _genres[genre] = cocher;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Livre> livresAffiches = _livresFiltres;

    final int nombreLus =
        livresAffiches.where((livre) => livre.lu).length;

    final int nombreAffiches = livresAffiches.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / $nombreAffiches'),
      ),

      body: Column(
        children: [
          // Filtre des nouveautés
          CheckboxListTile(
            title: const Text(
              'Afficher uniquement les nouveautés',
            ),
            value: _nouveautesSeulement,
            activeColor: Colors.blue,
            secondary: const Icon(Icons.new_releases),
            onChanged: (bool? valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Genres préférés',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Filtre Tous les genres
          CheckboxListTile(
            title: const Text(
              'Tous les genres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Sélectionner ou désélectionner tous',
            ),
            secondary: const Icon(Icons.library_books),
            tristate: true,
            value: _etatTousLesGenres,
            activeColor: Colors.indigo,
            onChanged: _changerTousLesGenres,
          ),

          const Divider(),

          // Filtres individuels par genre
          SizedBox(
            height: 220,
            child: ListView(
              children: _genres.keys.map((genre) {
                final int nombreLivres = widget.livres
                    .where((livre) => livre.genre == genre)
                    .length;

                return CheckboxListTile(
                  title: Text(genre),
                  subtitle: Text(
                    '$nombreLivres livre${nombreLivres > 1 ? 's' : ''}',
                  ),
                  secondary: Icon(
                    _iconesGenres[genre] ?? Icons.book,
                    color: _couleursGenres[genre] ?? Colors.blue,
                  ),
                  value: _genres[genre],
                  activeColor: _couleursGenres[genre],
                  onChanged: (bool? valeur) {
                    setState(() {
                      _genres[genre] = valeur ?? false;
                    });
                  },
                );
              }).toList(),
            ),
          ),

          const Divider(),

          // Liste des livres filtrés
          Expanded(
            child: ListView.separated(
              itemCount: livresAffiches.length,

              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 16,
                  endIndent: 16,
                );
              },

              itemBuilder: (context, index) {
                final Livre livre = livresAffiches[index];

                return CheckboxListTile(
                  value: livre.lu,

                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

                  subtitle: Text(
                    '${livre.auteur} • ${livre.genre}',
                  ),

                  secondary: const Icon(Icons.menu_book),

                  activeColor: Colors.green,

                  onChanged: (bool? valeur) {
                    setState(() {
                      livre.lu = valeur ?? false;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
