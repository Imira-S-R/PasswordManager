import 'package:flutter/material.dart';
import 'package:password_manager/db/user_database.dart';
import 'package:password_manager/model/user_info_model.dart';
import 'package:password_manager/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController masterPassword = TextEditingController();

  late List<User> users;
  bool isLoading = false;
  String status = '';

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    UserDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.users = await UserDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff151922),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      'ManageMyPasswords',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width < 800
                              ? 27.0
                              : 32.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width < 800
                              ? 27.0
                              : 32.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Master Password',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    maxLength: 60,
                    controller: masterPassword,
                    onFieldSubmitted: (value) {
                      masterPassword.text = value;
                    },
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.password_rounded,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                      onTap: () {
                        if (masterPassword.text == users[0].masterpswd) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        } else {
                          setState(() {
                            status = 'Incorrect Password';
                          });
                        }
                      },
                      child: Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 20.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xffF12711),
                                  Color(0xffD31400)
                                ])),
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
