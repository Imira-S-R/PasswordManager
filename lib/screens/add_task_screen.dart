import 'package:flutter/material.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/model/password_model.dart';

class AddTask extends StatefulWidget {
  late Function refershPasswords;
  AddTask({required this.refershPasswords});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController title = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late List<Password> passwords;
  bool isLoading = false;
  String status = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Add New Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              maxLength: 60,
              controller: title,
              onSubmitted: (value) {
                title.text = value;
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Title'),
            ),
            TextField(
              maxLength: 70,
              controller: username,
              onSubmitted: (value) {
                username.text = value;
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Username or e-mail'),
            ),
            TextField(
              maxLength: 80,
              controller: password,
              onSubmitted: (value) {
                password.text = value;
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Password'),
            ),
            Text(
              status,
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (title.text == '' &&
                          username.text == '' &&
                          password.text == '') {
                        setState(() {
                          status = "All Fields Can't Be Empty";
                        });
                      } else if (title.text == '' || password.text == '') {
                        setState(() {
                          status = "Title And Password Are Compulsory";
                        });
                      } else {
                        var passwordss = Password(
                            title: title.text,
                            username: username.text,
                            password: password.text);
                        PasswordDatabase.instance.create(passwordss);
                        widget.refershPasswords();
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                          child: Text(
                        'Done',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                          child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
