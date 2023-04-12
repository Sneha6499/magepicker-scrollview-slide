import 'dart:convert';

import 'package:apilogin/logout.dart';
import 'package:apilogin/scrollview.dart';
import 'package:apilogin/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'cupertinotabbar.dart';
import 'imagepicker.dart';



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/h.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Text('Side Menu Tutorial'),
        ),
      ),
    );
  }
}

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  void initState() {
    super.initState();
    fetchUsers();

    _loadUserEmailPassword();
  }

  String email1 = "";
  List<dynamic> users = [];
  List<dynamic> users1 = [];

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";

      setState(() {
        email1 = _email;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/back"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            for (var value in users)
              if (value['email'] == email1)
                ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(value['avatar'])),
                    title:
                        Text(value['first_name'] + " " + value['last_name'])),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.input),
                    title: const Text('Welcome'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: const Text('List Of User'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LogOut()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('ScrollView'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Scroll()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.border_color),
                    title: const Text('CupertinoTabBar'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CupertinoTabBarApp()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: const Text('upload image'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                  ),
                  ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Logout'),
                      onTap: () => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const SignupScreen();
                                },
                              ),
                              (raute) => false,
                            )
                          }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUsers() async {
    print("fetchUsers called");
    const url1 = "https://reqres.in/api/users?page=1";
    final uri1 = Uri.parse(url1);
    final response = await http.get(uri1);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
    const url2 = "https://reqres.in/api/users?page=2";
    final uri2 = Uri.parse(url2);
    final response1 = await http.get(uri2);

    final body1 = response1.body;
    final json1 = jsonDecode(body1);
    setState(() {
      users1 = json1['data'];
      users += users1;
    });

    print("fatchUsers Complete");
  }
}

// import 'package:apilogin/logout.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: NavDrawer(),
//       appBar: AppBar(
//         title: Text('Side menu'),
//       ),
//       body: Center(
//         child: Text('Side Menu Tutorial'),
//
//       ),
//     );
//   }
// }
//
//
// class NavDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Text(
//               'Side menu',
//               style: TextStyle(color: Colors.white, fontSize: 25),
//             ),
//             decoration: BoxDecoration(
//                 color: Colors.green,
//                 image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage('assets/images/cover.jpg'))),
//           ),
//           ListTile(
//             leading: Icon(Icons.input),
//             title: Text('List'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LogOut()),
//               );
//
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.verified_user),
//             title: Text('Profile'),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Profile()),
//               // );
//               //forgot password screen
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Bottom()),
//               // );
//               //forgot password screen
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.border_color),
//             title: Text('Feedback'),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const FeedBack()),
//               // );
//               //forgot password screen
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: Text('Logout'),
//             onTap: ()
//            {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => const Logout()),
//             //   );
//             //   //forgot password screen
//            },
//           ),
//         ],
//       ),
//     );
//   }
// }
