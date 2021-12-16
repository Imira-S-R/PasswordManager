import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/encrypt/encrypter.dart';
import 'package:password_manager/model/password_model.dart';
import 'package:password_manager/screens/add_task_screen.dart';
import 'package:password_manager/screens/password_generator_screen.dart';
import 'package:password_manager/screens/password_viewer_screen.dart';
import 'package:password_manager/screens/settings_screen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Password> passwords = [];
  late int selectedIndex = -1;
  bool showMenu = false;
  bool isLoading = false;
  int weakPasswordCount = 0;
  int strongPasswordCount = 0;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.passwords = await PasswordDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  String weakPasswordCounter() {
    for (var password in passwords) {
      if (password.password.length < 8) {
        weakPasswordCount++;
      } else {}
    }
    return '$weakPasswordCount';
  }

  String strongPasswordCounter() {
    for (var password in passwords) {
      if (password.password.length >= 8) {
        strongPasswordCount++;
      } else {}
    }
    return '$strongPasswordCount';
  }

  Widget noPasswordsFound() {
    return Container(
      height: MediaQuery.of(context).size.height - 200.0,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Icon(
              Icons.password_rounded,
              size: 50.0,
              color: Colors.white,
            ),
            Text(
              'No Passwords Added',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF'),
            ),
            Text(
              "Click on the '+' icon to add",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new password',
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 35,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff0F4DF3)),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddTask(
                      refershPasswords: refreshNotes,
                    ))),
      ),
      backgroundColor: Color(0xff151922),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            brightness: Brightness.dark,
            backgroundColor: Color(0xff151922),
            title: Text('ManageMyPasswords',
                style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PasswordGeneratoe())),
                  icon: Icon(Icons.security, color: Colors.white)),
              IconButton(
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Settings())),
                  icon: Icon(Icons.settings, color: Colors.white)),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 14.0),
            sliver: SliverToBoxAdapter(
                child: Text('Your Passwords(${passwords.length})',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.0)),
          passwords.length == 0
              ? SliverToBoxAdapter(
                  child: noPasswordsFound(),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((buildContext, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(Encrypt.instance.encryptOrDecryptText(passwords[index].title, false),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          passwords[index].username == ''
                              ? 'No Username'
                              : Encrypt.instance.encryptOrDecryptText(passwords[index].username, false),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PasswordViewer(
                                    title: Encrypt.instance.encryptOrDecryptText(passwords[index].title, false),
                                    username: Encrypt.instance.encryptOrDecryptText(passwords[index].username, false),
                                    password: Encrypt.instance.encryptOrDecryptText(passwords[index].password, false),
                                    index: index,
                                    id: passwords[index].id!,
                                    refresh: refreshNotes))),
                      ),
                    ],
                  );
                }, childCount: passwords.length))
        ],
      ),
    );
  }
}

// class Menu extends StatefulWidget {
//   late int index;
//   late List<Password> passwords;
//   late String password;
//   late String username;

//   Menu(
//       {required this.index,
//       required this.passwords,
//       required this.username,
//       required this.password});

//   @override
//   _MenuState createState() => _MenuState();
// }

// class _MenuState extends State<Menu> {
//   bool isVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 100.0,
//       width: MediaQuery.of(context).size.width - 20.0,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 25.0,
//               offset: Offset(0.0, 0.9),
//             )
//           ],
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           )),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 12.0, right: 5.0, top: 8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Username',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16.0),
//                     ),
//                     Text(
//                       widget.passwords[widget.index].username,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 22.0),
//                     )
//                   ],
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       Clipboard.setData(ClipboardData(text: widget.username));
//                     },
//                     icon: Icon(Icons.copy))
//               ],
//             ),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Password',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16.0),
//                     ),
//                     Visibility(
//                       visible: isVisible,
//                       child: Text(
//                         widget.passwords[widget.index].password,
//                         style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 22.0,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     !isVisible
//                         ? Text(
//                             isVisible
//                                 ? ''
//                                 : '*' *
//                                     widget.passwords[widget.index].password
//                                         .length,
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontSize: 28.0,
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                   ],
//                 ),
//                 Spacer(),
//                 IconButton(
//                     onPressed: () {
//                       Clipboard.setData(ClipboardData(text: widget.password));
//                     },
//                     icon: Icon(Icons.copy)),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isVisible = !isVisible;
//                     });
//                   },
//                   icon: Icon(isVisible
//                       ? Icons.visibility_off_rounded
//                       : Icons.visibility_rounded),
//                   tooltip: isVisible ? 'Hide' : 'Show',
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 5.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
