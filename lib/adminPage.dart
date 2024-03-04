import 'package:flutter/material.dart';

class adminPage extends StatelessWidget {

  const adminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController (
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test Lab 3'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sales Reports',),
              Tab(text: 'Product',),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget> [

          ],
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {

  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.network('https://pbs.twimg.com/profile_images/1239591624843247619/aQ5sdgwH_400x400.jpg',
              fit: BoxFit.cover,),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
