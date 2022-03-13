import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reuseable.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Log In'),
      ),
      child: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            textFieldHeader('Email Address:', 16),
            const SizedBox(height: 10),
            textInput('Email Address', CupertinoIcons.person_2, false, emailController),
            const SizedBox(height: 30),
            textFieldHeader('Password:', 16),
            const SizedBox(height: 10),
            textInput('Password', CupertinoIcons.padlock, true, passwordController),
            const SizedBox(height: 200),
            CupertinoButton.filled (
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Text('Log In', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  ).then((value) {
                    Navigator.of(context).pushNamed('HomeView');
                  }).onError((error, stackTrace) {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Error'),
                            content: Text(error!.toString()),
                            actions: <CupertinoDialogAction>[
                              CupertinoDialogAction(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }
                    );
                  }
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}