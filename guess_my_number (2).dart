import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController controller = TextEditingController();
  String message;
  int randomNumber = Random().nextInt(100);
  bool ceva = false;

  void _showDialog(int value) {
    // flutter defined function
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text('You guessed right'),
          content: Text('It was $value'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              children: <Widget>[
                FlatButton(
                  child: const Text('Try again'),
                  onPressed: () {
                    randomNumber = Random().nextInt(100);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                'I\'m thinking of a number between 1 and 100',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'It\'s your turn to guess my number!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            Card(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Try a number!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller,
                      keyboardType: const TextInputType.numberWithOptions(),
                      validator: (String value) {
                        final double amount = double.tryParse(value);
                        if (amount == null) {
                          return 'Please enter a number';
                        }
                        return null;
                      },
                    ),
                  ),
                  RaisedButton(
                    child: const Text('Guess'),
                    onPressed: () {
                      ceva = true;
                      if (!_form.currentState.validate()) {
                        setState(
                          () {
                            message = null;
                          },
                        );
                        return;
                      }

                      final double value = double.parse(controller.text.trim());

                      setState(
                        () {
                          if (value == randomNumber) {
                            message = 'You tried ${value.toStringAsFixed(0)} \n'
                                'You guessed right.';
                            _showDialog(value.toInt());
                          } else if (value < randomNumber)
                            message = 'You tried ${value.toStringAsFixed(0)} \n'
                                'Try higher';
                          else if (value > randomNumber) {
                            message = 'You tried ${value.toStringAsFixed(0)} \n'
                                'Try lower';
                          }
                          controller.clear();
                          return null;
                        },
                      );
                    },
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
