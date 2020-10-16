import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/home_page.dart';


class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg'),
                fit: BoxFit.cover 
                )
            ),
            ),
            ListTile(
              leading: Icon(Icons.pages,color: Colors.blue),
              title: Text('Home'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.party_mode,color: Colors.blue),
              title: Text('Party mode'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.people,color: Colors.blue),
              title: Text('People'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.settings,color: Colors.blue),
              title: Text('Seetings'),
              onTap: (){
                // Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, SettingsPage.routeName);
              } 
            ),
        ],
      ),
    );
  }
}