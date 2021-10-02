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
              icon: Icon(Icons.edit, color: Colors.black)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: new Text("Are you sure ?"),
                      content: new Text("Do you want to delete this password?"),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("Yes"),
                          onPressed: () {
                            PasswordDatabase.instance
                                .delete(passwords[widget.index].id!);
                            widget.refresh();
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        ),
                        new TextButton(
                          child: new Text("No"),
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
                color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 24.0,
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
              widget.username == '' ? 'No Username' : widget.username,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 22.0,
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
                IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(isVisible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded),
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
                    color: Colors.red,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              isVisible ? '' : '*' * widget.password.length,
              style: TextStyle(
                color: Colors.red,
                fontSize: 28.0,
              ),
            ),
            // Container(
            //   height: 60.0,
            //   width: MediaQuery.of(context).size.width - 50.0,
            //   decoration: BoxDecoration(
            //       color: Colors.grey[100],
            //       borderRadius: BorderRadius.circular(8.0)),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           'Password Strength',
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 20.0,
            //               fontWeight: FontWeight.w800),
            //         ),
            //         Container(
            //           height: 50.0,
            //           width: MediaQuery.of(context).size.width - 270.0,
            //           decoration: BoxDecoration(
            //               color: widget.password.length < 8 ? Colors.red : Colors.green,
            //               borderRadius: BorderRadius.circular(8.0)),
            //           child: Center(
            //               child: Text(
            //             widget.password.length < 8 ? 'Weak' : 'Strong',
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 20.0,
            //                 fontWeight: FontWeight.w600),
            //           )),
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
