import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/model/password_model.dart';

class PasswordViewer extends StatefulWidget {
  final String title;
  final String username;
  final String password;
  final int index;
  final Function refresh;

  PasswordViewer(
      {required this.title, required this.username, required this.password, required this.index, required this.refresh});

  @override
  _PasswordViewerState createState() => _PasswordViewerState();
}

class _PasswordViewerState extends State<PasswordViewer> {


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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                PasswordDatabase.instance.delete(passwords[widget.index].id!);
                widget.refresh();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Sevice Name :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Text(
                  'Username :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: widget.username)),
                  icon: Icon(Icons.copy_rounded),
                  tooltip: 'Copy',
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              widget.username,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Text(
                  'Password :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: widget.password)),
                  icon: Icon(Icons.copy_rounded),
                  tooltip: 'Copy',
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              widget.password,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
