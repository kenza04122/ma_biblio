
import 'package:flutter/material.dart';
import '../services/livre_service.dart';

class ParametresScreen extends StatelessWidget {
  final VoidCallback onReinitialiser;

  const ParametresScreen({
    super.key,
    required this.onReinitialiser,
  });

  Future<void> _confirmerReinitialisation(
    BuildContext context,
  ) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Réinitialiser ma bibliothèque ?',
          ),
          content: const Text(
            'Les livres lus et les favoris sauvegardés '
            'seront supprimés. Les données d’origine '
            'seront rechargées.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Réinitialiser'),
            ),
          ],
        );
      },
    );

    if (confirmation != true) return;

    try {
      await LivreService().reinitialiserBibliotheque();

      if (!context.mounted) return;

      onReinitialiser();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bibliothèque réinitialisée avec succès',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erreur de réinitialisation : $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Mon profil'),
            subtitle: Text('Nom, e-mail, mot de passe'),
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.restart_alt,
              color: Colors.red,
            ),
            title: const Text(
              'Réinitialiser ma bibliothèque',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text(
              'Effacer les favoris et les livres lus sauvegardés',
            ),
            onTap: () => _confirmerReinitialisation(
              context,
            ),
          ),
        ],
      ),
    );
  }
}
