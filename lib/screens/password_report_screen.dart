import 'package:flutter/material.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/model/password_model.dart';

class PasswordReportScreen extends StatefulWidget {
  const PasswordReportScreen({Key? key}) : super(key: key);

  @override
  _PasswordReportScreenState createState() => _PasswordReportScreenState();
}

class _PasswordReportScreenState extends State<PasswordReportScreen> {
  late List<Password> passwords = [];
  bool isLoading = false;
  int weakPasswordCount = 0;
  int strongPasswordCount = 0;
  double average = 0;
  int totalPasswordCount = 0;
  late List<Password> weakPassword = [];
  late List<Password> strongPassword = [];

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

  String weakPasswords() {
    for (var password in passwords) {
      if (password.password.length < 8) {
        weakPasswordCount++;
        weakPassword.add(Password(
            title: password.title,
            username: password.username,
            password: password.password));
      } else {
        weakPasswordCount = weakPasswordCount;
      }
    }
    return '$weakPasswordCount';
  }

  String strongPasswords() {
    for (var password in passwords) {
      if (password.password.length >= 8) {
        strongPasswordCount++;
        strongPassword.add(Password(
            title: password.title,
            username: password.username,
            password: password.password));
      }
    }
    return '$strongPasswordCount';
  }

  double averagePasswordLength() {
    for (var password in passwords) {
      totalPasswordCount += password.password.length;
    }
    average = totalPasswordCount / passwords.length;
    average.isNaN;
    return average;
  }

  Widget returnText() {
    if (passwords.length != 0) {
      return Text(
              '${averagePasswordLength().toString()}',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold),
            );
    } else {
      return Text(
              '0',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password Health Report',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 26.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  weakPasswords(),
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  weakPassword.length == 1
                      ? 'Weak Password Found.'
                      : 'Weak Passwords Found',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: ListView.builder(
                itemCount: weakPassword.length == 0 ? 1 : weakPassword.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return weakPassword.length == 0
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'No Weak Passwords Found.',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              height: 100.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  weakPassword[index].title,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            )
                          ],
                        );
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              height: 10.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              strongPasswords(),
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 45.0,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              strongPassword.length == 1
                  ? 'Strong Password Found.'
                  : 'Strong Passwords Found.',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: ListView.builder(
                itemCount:
                    strongPassword.length == 0 ? 1 : strongPassword.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return strongPassword.length == 0
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'No Strong Passwords Found.',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              height: 120.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Text(
                                  strongPassword[index].title,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            )
                          ],
                        );
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              height: 10.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 5.0,
            ),
            returnText(),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Is The Average Password Length.',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              height: 10.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(weakPassword.length != 0
                ? 'Please Change Your Weak Password To Make Your Online Accounts More Secure.'
                : '', style: TextStyle(color: Colors.red, fontSize: 20.0),)
          ],
        ),
      ),
    );
  }
}
