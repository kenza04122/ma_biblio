
import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> parametres = [
      
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mon profil'),
        subtitle: const Text('Nom, e-mail, mot de passe'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profil sélectionné'),
            ),
          );
        },
      ),

      
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text('Notifications'),
        trailing: const Icon(Icons.chevron_right),
        tileColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        textColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notifications sélectionnées'),
            ),
          );
        },
      ),

      
      ListTile(
        leading: const Icon(Icons.language),
        title: const Text('Langue'),
        subtitle: const Text('Français'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Langue sélectionnée'),
            ),
          );
        },
      ),

      
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text('À propos'),
        subtitle: const Text(
          'Version de l’application\nInformations générales',
        ),
        trailing: const Icon(Icons.chevron_right),
        dense: true,
        isThreeLine: true,
        enabled: false,
      ),

      
      ListTile(
        leading: const Icon(Icons.palette),
        title: const Text('Apparence'),
        trailing: const Icon(Icons.chevron_right),
      ),

      
      ListTile(
        leading: const Icon(Icons.storage),
        title: const Text('Stockage'),
        trailing: const Icon(Icons.chevron_right),
      ),

   
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Aide'),
        trailing: const Icon(Icons.chevron_right),
      ),

    
      ListTile(
        leading: const Icon(Icons.privacy_tip),
        title: const Text('Confidentialité'),
        trailing: const Icon(Icons.chevron_right),
      ),

      
      ListTile(
        leading: const Icon(Icons.public),
        title: const Text('Région'),
        trailing: const Icon(Icons.chevron_right),
      ),

 
      ListTile(
        leading: const Icon(Icons.update),
        title: const Text('Mises à jour'),
        trailing: const Icon(Icons.chevron_right),
      ),

      ListTile(
        leading: const Icon(Icons.contact_support),
        title: const Text('Nous contacter'),
        trailing: const Icon(Icons.chevron_right),
      ),

  
      ListTile(
        leading: const Icon(Icons.star_rate),
        title: const Text('Noter l’application'),
        trailing: const Icon(Icons.chevron_right),
      ),

    
      ListTile(
        leading: const Icon(Icons.share),
        title: const Text('Partager'),
        trailing: const Icon(Icons.chevron_right),
      ),

     
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Déconnexion'),
        trailing: const Icon(Icons.chevron_right),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView.separated(
        itemCount: parametres.length,

       
        itemBuilder: (context, index) {
          return parametres[index];
        },

      
        separatorBuilder: (context, index) {
          return const Divider(
            indent: 72,
          );
        },
      ),
    );
  }
}
