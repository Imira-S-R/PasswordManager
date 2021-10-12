import 'package:flutter/material.dart';
import 'package:password_manager/db/user_database.dart';
import 'package:password_manager/model/user_info_model.dart';
import 'package:password_manager/screens/master_password_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  late List<User> users = [];
  bool isLoading = false;
  String status = '';
  String _message =
      'When enabled, it will ask you to enter the master password every time you open the app.';

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
  void dispose() {
    UserDatabase.instance.close();

    super.dispose();
  }

  String getText() {
    if (users[0].loginRequired == true) {
      return 'Yes';
    } else {
      return 'No';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151922),
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0xff151922),
        centerTitle: true,
        title: Text(
          'Security',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width - 10.0,
              decoration: BoxDecoration(
                  color: Color(0xff2E3647),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Require Login At Startup',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                    Switch(
                      value: users[0].loginRequired,
                      onChanged: (value) {
                        setState(() {
                          UserDatabase.instance.update(User(
                              loginRequired: value,
                              masterpswd: users[0].masterpswd,
                              id: users[0].id));
                          refreshNotes();
                        });
                      },
                      activeTrackColor: Colors.green[500],
                      activeColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(child: Text(_message, maxLines: 3, style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              height: 10.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MasterPasswordScreen())),
              child: Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width - 10.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Color(0xff2E3647),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 10.0),
                  child: Text(
                    'Master Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
