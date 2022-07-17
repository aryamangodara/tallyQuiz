import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
              child: Center(child: Text('The Ultimate Quiz App'))),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.of(context).pushNamed('about-us');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create Quiz'),
            onTap: () {
              Navigator.of(context).pushNamed('create-quiz');
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.favorite),
          //   title: const Text('My Favorites'),
          //   onTap: () {
          //     // Navigator.of(context)
          //     //     .pushReplacementNamed(FavoriteGamesScreen.routeName);
          //   },
          // ),
          const Expanded(child: Text('')),
          const Text('Made with ❤ by Aryaman Godara'),
          SizedBox(height: 1)
        ],
      ),
    );
  }
}
