import 'package:flutter/material.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/model/password_model.dart';
import 'package:password_manager/screens/add_task_screen.dart';
import 'package:password_manager/screens/edit_password_screen.dart';
import 'package:password_manager/screens/password_generator_screen.dart';
import 'package:password_manager/screens/password_viewer_screen.dart';
import 'package:password_manager/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Password> passwords = [];
  bool isLoading = false;

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

  Widget noPasswordsFound() {
    return Container(
      height: MediaQuery.of(context).size.height - 200.0,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Icon(Icons.password_rounded, size: 50.0,),
            Text(
              'No Passwords Added',
              style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'SF'),
            ),
            Text(
              "Click on the '+' icon to add",
              style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),
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
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddTask(
                      refershPasswords: refreshNotes,
                    ))),
        backgroundColor: Colors.red,
        splashColor: Colors.red[900],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'Add New Password',
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'ManageMyPasswords',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => PasswordGeneratoe())),
            icon: Icon(Icons.security, color: Colors.black),
            tooltip: 'Secure Password Generator',
          ),
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Settings())),
            icon: Icon(Icons.settings, color: Colors.black),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(13.0, 10.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Passwords (${passwords.length})',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: passwords.length == 0 ? 1 : passwords.length,
                itemBuilder: (context, int index) {
                  return passwords.length == 0
                      ? noPasswordsFound()
                      : Dismissible(
                          key: UniqueKey(),
                          onDismissed: (d) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Removed ${passwords[index].title}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.red,
                            ));
                            setState(() {
                              PasswordDatabase.instance
                                  .delete(passwords[index].id!);
                              passwords.removeAt(index);
                              refreshNotes();
                            });
                          },
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PasswordViewer(
                                          title: passwords[index].title,
                                          username: passwords[index].username,
                                          password: passwords[index].password,
                                          index: index,
                                          refresh: refreshNotes,
                                        ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 60.0,
                                  width:
                                      MediaQuery.of(context).size.width - 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          passwords[index].title,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        IconButton(
                                          onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => EditTask(
                                                        title: passwords[index]
                                                            .title,
                                                        username:
                                                            passwords[index]
                                                                .username,
                                                        password:
                                                            passwords[index]
                                                                .password,
                                                        id: passwords[index]
                                                            .id!,
                                                        refresh: refreshNotes,
                                                      ))),
                                          icon: Icon(Icons.edit),
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0)
                              ],
                            ),
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
