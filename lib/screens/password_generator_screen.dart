import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  bool numbersRequired = true;
  bool symbolsRequired = true;

  String _randomString(double length) {
    int _length = length.toInt();
    var rand = new Random();
    var codeUnits = new List.generate(_length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  String generateRandomString(double len) {
    int _length = length.toInt();
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    const _charsWithSymbols =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#%^&*()';
    const _charsWithNumbers =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    const _charsWithEvery =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#%^&*()1234567890';

    return List.generate(
        _length,
        (index) => symbolsRequired == true && numbersRequired == false
            ? _charsWithSymbols[r.nextInt(_charsWithSymbols.length)]
            : numbersRequired == true && symbolsRequired == false
                ? _charsWithNumbers[r.nextInt(_charsWithNumbers.length)]
                : numbersRequired == true && symbolsRequired == true
                    ? _charsWithEvery[r.nextInt(_charsWithEvery.length)]
                    : _chars[r.nextInt(_chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151922),
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0xff151922),
        title: Text(
          'Password Generator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 10.0, 0.0),
            child: Text(
              'Generated Password',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    color: Color(0xff2E3647)),
                child: Center(
                    child: Text(
                  _password,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 10.0, 0.0),
            child: Text(
              'LENGTH: $length',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
            child: Slider(
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
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(23.0, 0.0, 23.0, 0.0),
            child: Text(
              'SETTINGS',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 50.0,
                decoration: BoxDecoration(
                    color: Color(0xff2E3647),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Include Symbols',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Switch(
                        value: symbolsRequired,
                        onChanged: (value) {
                          setState(() {
                            symbolsRequired = value;
                          });
                        },
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 50.0,
                decoration: BoxDecoration(
                    color: Color(0xff2E3647),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Include Numbers',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Switch(
                        value: numbersRequired,
                        onChanged: (value) {
                          setState(() {
                            numbersRequired = value;
                          });
                        },
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _password = generateRandomString(length);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width - 50.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff024DE2), Color(0xff001F5C)]),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: Text(
                      'Generate Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: _password));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width - 50.0,
                  decoration: BoxDecoration(
                      color: Color(0xff344055),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: Text(
                      'Copy To Clipboard',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
