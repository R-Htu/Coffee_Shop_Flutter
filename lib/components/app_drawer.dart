import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.local_cafe,
              size: 65,
              color: Colors.brown,
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_cafe),
            title: Text('M E N U'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/MenuPage');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('H O M E'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/HomePage');
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('R E C O M M E N D'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/RecommendPage');
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('R E V I E W'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/ReviewPage');
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('L O G O U T'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/LogoutPage');
            },
          ),
        ],
      ),
    );
  }
}
