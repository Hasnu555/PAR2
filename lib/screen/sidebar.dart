import 'package:derviza_app/model/cart.dart';
import 'package:derviza_app/screen/article_list.dart';
import 'package:derviza_app/screen/edit_user_screen.dart';
import 'package:derviza_app/screen/product_list.dart';
import 'package:derviza_app/screen/expert_list.dart';
import 'package:derviza_app/screen/login_screen.dart';
import 'package:derviza_app/screen/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  User? user = FirebaseAuth.instance.currentUser;

  void updateUser() {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF416422),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Stack(
                children: [
                  Text(
                  user?.displayName ?? 'Guest',
                  style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // foreground: Paint()
                    //   ..style = PaintingStyle.stroke
                    //   ..strokeWidth = 6
                    //   ..color = Colors.black,
                  )
                  ,
                ),
                Text(
                  user?.displayName ?? 'Guest',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    
                    color: Colors.white,
                  )
                  ,
                ),
                ]
              ),
              accountEmail: Stack(
                children: [
                  Text(user?.email ?? 'guest@example.com',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // foreground: Paint()
                    //   ..style = PaintingStyle.stroke
                    //   ..strokeWidth = 4
                    //   ..color = Colors.black,
                  )
                  ),
                   Text(user?.email ?? 'guest@example.com',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    
                    color: Colors.white,
                  )
                  ),
                ]
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: user?.photoURL != null
                      ? Image.network(
                          user!.photoURL!,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        )
                      : Image.network("https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"),
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF416422),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      AssetImage('assets/images/PAR new.jpg'),
                ),
              ),
            ),
            // const SizedBox(height: 20,),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.money,
                  color: Colors.white,
                ),
              ),
              title: const Text('Wallet',
              style: TextStyle(
                color: Color(0xFFE8F4F2)
              ),),
              onTap: () => {
                Navigator.pushNamed(context, "/wallet")
              },
            ),
            Divider(),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.article,
                  color: Colors.white),
              ),
              title: const Text('Articles',
              style: TextStyle(
                color: Color(0xFFE8F4F2)
              ),),
              onTap: () => {
               Navigator.pushNamed(context, "/articles")
              },
            ),
            Divider(),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.edit,
                  color: Colors.white),
              ),
              title: const Text('Edit Profile',
              style: TextStyle(
                color: Color(0xFFE8F4F2)
              ),),
              onTap: () async => {
                await Navigator.pushNamed(context, "/editProfile"),
                updateUser(),
              },
            ),
            Divider(),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.person_3,
                  color: Colors.white),
              ),
              title: const Text('Experts',
              style: TextStyle(
                color: Color(0xFFE8F4F2)
              ),),
              onTap: () => {
                Navigator.pushNamed(context, "/experts")
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Log out',
              style: TextStyle(
                color: Color(0xFFE8F4F2)
              ),),
              
              leading: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.logout,
                  color: Colors.white),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
