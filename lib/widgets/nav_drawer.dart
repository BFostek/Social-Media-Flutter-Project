import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: DrawerHeader(
              child: Text('Olá ${context.read<AuthService>().usuario?.email}!', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Colors.black),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async => {await context.read<AuthService>().logOut()},
          ),
        ],
      ),
    );
  }
}
