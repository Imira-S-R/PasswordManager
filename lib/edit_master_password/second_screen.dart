import 'package:flutter/material.dart';
import 'package:password_manager/db/user_database.dart';
import 'package:password_manager/encrypt/encrypter.dart';
import 'package:password_manager/model/user_info_model.dart';

class SecondEditScreen extends StatefulWidget {
  const SecondEditScreen({Key? key}) : super(key: key);

  @override
  _SecondEditScreenState createState() => _SecondEditScreenState();
}

class _SecondEditScreenState extends State<SecondEditScreen> {
  TextEditingController newMasterPassword = TextEditingController();
  String status = '';

  late List<User> users;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.users = await UserDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2E3647),
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0xff2E3647),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create New Password',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
                'Your new password must be different from previous used passwords.',
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0)),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Enter New Password',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 80.0,
              width: MediaQuery.of(context).size.width - 50.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                maxLength: 60,
                controller: newMasterPassword,
                onSubmitted: (value) {
                  newMasterPassword.text = value;
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white10,
                        width: 2.0,
                      ),
                    ),
                    counterStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: 'Enter New Password',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                if (newMasterPassword.text != '') {
                  var user = User(
                      loginRequired: users[0].loginRequired,
                      masterpswd: Encrypt.instance.encryptOrDecryptText(newMasterPassword.text, true),
                      id: users[0].id);
                  UserDatabase.instance.update(user);
                  Navigator.pop(context);
                } else if (newMasterPassword.text == '') {
                  setState(() {
                    status = "Password Can't Be Empty";
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
                  'Reset Password',
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
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
