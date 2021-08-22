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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            'Edit Task',
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
              TextFormField(
                maxLength: 60,
                initialValue: widget.title,
                onChanged: (value) {
                  title.text = value;
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Title'),
              ),
              TextFormField(
                maxLength: 60,
                initialValue: widget.username,
                onChanged: (value) {
                  username.text = value;
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Username'),
              ),
              TextFormField(
                maxLength: 60,
                initialValue: widget.password,
                onChanged: (value) {
                  password.text = value;
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Password'),
              ),
              SizedBox(
                height: 10.0,
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
            ],
          ),
        ));
  }
}
