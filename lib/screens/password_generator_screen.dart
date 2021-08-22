import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class PasswordGeneratoe extends StatefulWidget {
  const PasswordGeneratoe({Key? key}) : super(key: key);

  @override
  _PasswordGeneratoeState createState() => _PasswordGeneratoeState();
}

class _PasswordGeneratoeState extends State<PasswordGeneratoe> {
  String _password = '';
  double length = 0;

  String _randomString(double length) {
    int _length = length.toInt();
    var rand = new Random();
    var codeUnits = new List.generate(_length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Password Generator',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80.0,
                width: 250.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    color: Colors.grey),
                child: Center(
                    child: Text(
                  _password,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
              ),
            ],
          ),
          Slider(
            value: length,
            onChanged: (newLength) {
              setState(() {
                length = newLength;
              });
            },
            divisions: 20,
            label: '$length',
            activeColor: Colors.red,
            inactiveColor: Colors.red,
            min: 0.0,
            max: 20.0,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _password = _randomString(length);
              });
            },
            child: Container(
              height: 50.0,
              width: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: Colors.red),
              child: Center(
                child: Text(
                  'Generate',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: _password));
            },
            child: Container(
              height: 50.0,
              width: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: Colors.red),
              child: Center(
                child: Text(
                  'Copy',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
