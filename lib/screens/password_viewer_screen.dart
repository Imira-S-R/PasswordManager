import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/db/password_database.dart';
import 'package:password_manager/model/password_model.dart';
import 'package:password_manager/screens/edit_password_screen.dart';

class PasswordViewer extends StatefulWidget {
  final String title;
  final String username;
  final String password;
  final int index;
  final Function refresh;
  final int id;

  PasswordViewer(
      {required this.title,
      required this.username,
      required this.password,
      required this.index,
      required this.id,
      required this.refresh});

  @override
  _PasswordViewerState createState() => _PasswordViewerState();
}

class _PasswordViewerState extends State<PasswordViewer> {
  late List<Password> passwords = [];
  bool isLoading = false;
  bool isVisible = false;

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
        backgroundColor: Color(0xff151922),
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              tooltip: 'Edit',
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditTask(
                          title: widget.title,
                          username: widget.username,
                          password: widget.password,
                          id: widget.id,
                          refresh: widget.refresh))),
              icon: Icon(Icons.edit, color: Colors.white)),
          IconButton(
              onPressed: () {
                print(passwords[0].password);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color(0xff2E3647),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: new Text("Are you sure ?", style: TextStyle(color: Colors.white),),
                      content: new Text("Do you want to delete this password?", style: TextStyle(color: Colors.white),),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("Yes", style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            PasswordDatabase.instance
                                .delete(passwords[widget.index].id!);
                            widget.refresh();
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        ),
                        new TextButton(
                          child: new Text("No", style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Delete',
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.white,
              )),
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
                  'Website Name :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
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
                      color: Colors.white70,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: widget.username)),
                  icon: Icon(Icons.copy_rounded, color: Colors.white,),
                  tooltip: 'Copy',
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              widget.username == '' ? 'No Username' : widget.username,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
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
                      color: Colors.white70,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: widget.password)),
                  icon: Icon(Icons.copy_rounded, color: Colors.white,),
                  tooltip: 'Copy',
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(isVisible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded, color: Colors.white,),
                  tooltip: isVisible ? 'Hide' : 'Show',
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: isVisible,
              child: Text(
                widget.password,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              isVisible ? '' : '*' * widget.password.length,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
