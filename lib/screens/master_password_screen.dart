import 'package:flutter/material.dart';
import 'package:password_manager/edit_master_password/first_screen.dart';
import 'package:password_manager/getStartedScreen/first_screen.dart';

class MasterPasswordScreen extends StatefulWidget {
  const MasterPasswordScreen({Key? key}) : super(key: key);

  @override
  _MasterPasswordScreenState createState() => _MasterPasswordScreenState();
}

class _MasterPasswordScreenState extends State<MasterPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151922),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff151922),
        title: Text(
          'Master Password Settings',
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
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FirstEditScreen())),
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
                    'Edit Master Password',
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
