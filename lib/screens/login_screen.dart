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
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            'ManageMyPasswords',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                color: Colors.red,
                size: 100.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Welcome back!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0),
          ),
          Text(
            'Log in to continue.',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width - 50.0,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              maxLength: 60,
              controller: masterPassword,
              onFieldSubmitted: (value) {
                masterPassword.text = value;
              },
              decoration: InputDecoration(
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
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              if (masterPassword.text == users[0].masterpswd) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              } else {
                setState(() {
                  status = 'Incorrect Password';
                });
              }
            },
            child: Container(
              height: 55.0,
              width: MediaQuery.of(context).size.width - 50.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffD80320), Color(0xffFF0022)]),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                  child: Text(
                'Log In',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
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
      )),
    );
  }
}
