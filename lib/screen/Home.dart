
import 'package:derviza_app/model/cart.dart';
import 'package:derviza_app/screen/cart_screen.dart';
import 'package:derviza_app/screen/edit_user_screen.dart';
import 'package:derviza_app/screen/sidebar.dart';
import 'package:derviza_app/screen/product_list.dart';
import 'package:derviza_app/screen/charts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final User? user = FirebaseAuth.instance.currentUser;
  final pages = [ ProductListPage(),ChartDisplay(),CartPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8f4f2),
      drawer: NavBar(),
      // appBar: AppBar(
      //   centerTitle: false,
      //   backgroundColor: Color(0xFF598216),
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         children: [
      //           Text(
      //             'Hi ',
      //             style: TextStyle(
      //               color: Colors.white,
      //             ),
      //           ),
      //           Text(
      //             user?.displayName ?? 'Guest',
      //             style: TextStyle(
      //               color: Colors.white,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Text("Explore your services", style: TextStyle(fontSize: 12.0)),
      //     ],
      //   ),
      //   actions: [
      //     // Padding(
      //     //   padding: const EdgeInsets.only(right: 8.0),
      //     //   child: IconButton.filledTonal(
      //     //     onPressed: () {},
      //     //     icon: badges.Badge(
      //     //       badgeContent: Text('3',
      //     //           style: TextStyle(
      //     //             color: Colors.white,
      //     //             fontSize: 12.0,
      //     //           )),
      //     //       badgeStyle: badges.BadgeStyle(badgeColor: Color(0xFF155751)),
      //     //       position: badges.BadgePosition.topEnd(top: -15, end: -12),
      //     //       child: Icon(
      //     //         Icons.notifications,
      //     //         color: Color(0xFF155751),
      //     //       ),
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          topRight: Radius.circular(60.0),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF598216),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list_outlined, color: Colors.black),
              label: "AgroPicks",
              activeIcon: Icon(Icons.view_list),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined, color: Colors.black),
              label: "AgriGraphs",
              activeIcon: Icon(Icons.add_chart_sharp),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_outlined, color: Colors.black),
              label: "Cart",
              activeIcon: Icon(Icons.shop_rounded),
            ),
            
          ],
        ),
      ),
    );
  }
}
