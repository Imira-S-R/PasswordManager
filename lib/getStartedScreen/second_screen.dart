import 'package:flutter/material.dart';
import 'package:password_manager/db/user_database.dart';
import 'package:password_manager/model/user_info_model.dart';
import 'package:password_manager/screens/home_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final String message =
      "This is the password you have to remember to access this app. You will be asked to enter this password each time you open the app. But, if you don't like it you can disable it";
  bool requiredLogin = true;
  TextEditingController masterPassword = TextEditingController();

  String getText() {
    if (requiredLogin == true) {
      return 'Yes';
    } else {
      return 'No';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Enter Master Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                maxLength: 60,
                controller: masterPassword,
                onSubmitted: (value) {
                  masterPassword.text = value;
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Enter Master Password'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                message,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Require Master Password Every Time You Open The App? ${getText().toString()}',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        requiredLogin = true;
                      });
                    },
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(70.0)),
                      child: Center(
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        requiredLogin = false;
                      });
                    },
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(70.0)),
                      child: Center(
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      var user = User(loginRequired: requiredLogin, masterpswd: masterPassword.text);
                      UserDatabase.instance.create(user);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    child: Container(
                      height: 60.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(80.0)),
                      child: Center(
                        child: Text(
                          'Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
