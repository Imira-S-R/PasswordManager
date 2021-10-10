import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/model/password_model.dart';

class EditTask extends StatefulWidget {
  late final String title;
  late final String username;
  late final String password;
  late final int id;
  late final Function refresh;

  EditTask(
      {required this.title,
      required this.username,
      required this.password,
      required this.id,
      required this.refresh});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController title = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff151922),
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: Color(0xff151922),
          centerTitle: false,
          title: Text(
            'Edit Password',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Website Name',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  maxLength: 60,
                  initialValue: widget.title,
                  onChanged: (value) {
                    title.text = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                      size: 24,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Username/Email',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  maxLength: 60,
                  initialValue: widget.username,
                  onChanged: (value) {
                    username.text = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      size: 24,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  maxLength: 60,
                  initialValue: widget.password,
                  onChanged: (value) {
                    password.text = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  if (title.text == '' &&
                      username.text == '' &&
                      password.text == '') {
                    Navigator.pop(context);
                  } else if (title.text == '' && username.text == '') {
                    var p = Password(
                        title: widget.title,
                        username: widget.username,
                        password: password.text,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  } else if (title.text == '' && password.text == '') {
                    var p = Password(
                        title: widget.title,
                        username: username.text,
                        password: widget.password,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  } else if (username.text == '' && password.text == '') {
                    var p = Password(
                        title: title.text,
                        username: widget.username,
                        password: widget.password,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  } else if (username.text == '') {
                    var p = Password(
                        title: title.text,
                        username: widget.username,
                        password: password.text,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  } else if (title.text == '') {
                    var p = Password(
                        title: widget.title,
                        username: username.text,
                        password: password.text,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  } else if (password.text == '') {
                    var p = Password(
                        title: title.text,
                        username: username.text,
                        password: widget.password,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  } else {
                    var p = Password(
                        title: title.text,
                        username: username.text,
                        password: password.text,
                        id: widget.id);
                    PasswordDatabase.instance.update(p);
                    widget.refresh();
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width - 40.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xffFF0021), Color(0xffB8041B)]),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: Text(
                      'Save Password',
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
        ));
  }
}
