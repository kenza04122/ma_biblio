import 'package:flutter/material.dart';
import 'screens/parametres_screen.dart';
appBar: AppBar(
  title: const Text('Accueil'),
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