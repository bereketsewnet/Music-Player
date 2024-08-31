import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              onTap: () => Navigator.pop,
              leading: const Icon(Icons.home),
              title: const Text('H O M E'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              leading: const Icon(Icons.settings),
              title: const Text('S E T T I N G'),
            ),
          ),
        ],
      ),
    );
  }
}
