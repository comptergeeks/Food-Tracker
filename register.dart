import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reuseable.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Sign Up'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            textFieldHeader('Email Address:', 16),
            const SizedBox(height: 10),
            textInput('ex: yourname@example.com', CupertinoIcons.person, false,
                emailController),
            const SizedBox(height: 30),
            textFieldHeader('Password:', 16),
            const SizedBox(height: 10),
            textInput('Enter A Secure Password', CupertinoIcons.lock_open, true,
                passwordController),
            const SizedBox(height: 30),
            textFieldHeader('Re-Enter Password:', 16),
            const SizedBox(height: 10),
            textInput('Confirm Password', CupertinoIcons.padlock, true,
                confirmPassController),
            SizedBox(
              height: 100,
            ),
            CupertinoButton.filled(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (confirmPassController.text == passwordController.text) {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  )
                      .then((value) {
                        context.read<UserToSave>().setUser(emailController.text);
                        print(context.read<UserToSave>().user);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(emailController.text)
                        .set({});
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(emailController.text)
                        .collection('foodData')
                        .add({});
                    //print(context.read<UserToSave>().user);
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
                        });
                  });
                } else {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Error'),
                          content: Text('Passwords must match'),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
