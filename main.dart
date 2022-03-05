import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homeBase.dart';

  void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomeView(),
        theme:CupertinoThemeData(brightness: Brightness.dark, primaryColor: CupertinoColors.systemBlue,),
      routes: {
        '/HomeView': (_) => HomeView(),
        'LogInScreen': (_) => LogIn(),
        'SignUpScreen': (_) => SignIn(),
      },
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(
    middle: Text(''),
    ),
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
          CupertinoButton.filled(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 110),
            child: const Text('Log In', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pushNamed('LogInScreen');
            },
          ),
          const SizedBox(height: 50),
          CupertinoButton.filled(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            onPressed: () {
              Navigator.of(context).pushNamed('SignUpScreen');
            },
            child: const Text('Sign Up', style: TextStyle(color: Colors.white,)),
          ),
        ],
      ),
      ),
    );
  }
}
//move to separate page, to separate by screens
class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

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
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Email:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            CupertinoTextField (
              placeholder: 'Email Address',
              prefix: Icon(CupertinoIcons.person_2),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Password:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            CupertinoTextField (
              placeholder: 'Password',
              prefix: Icon(CupertinoIcons.lock),
              obscureText: true,
            ),
            const SizedBox(height: 200),
           CupertinoButton.filled (
                onPressed: () {
                  Navigator.of(context).pop('/HomeView');
                },
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
          middle: Text('Sign Up'),
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Enter Your Email:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
            ),
            ),
          ),
          const SizedBox(height: 10),
          CupertinoTextField (
            placeholder: 'epicgamer123@example.com',
            prefix: Icon(CupertinoIcons.person_2),
          ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Enter Password:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
              ),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoTextField (
              obscureText: true,
              placeholder: 'Enter a secure password',
              prefix: Icon(CupertinoIcons.lock_open),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Re-Enter Password:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
              ),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoTextField (
              obscureText: true,
              placeholder: 'Re-Enter Password',
              prefix: Icon(CupertinoIcons.padlock),
            ),
            
            SizedBox(height: 100,),
            CupertinoButton.filled (
              onPressed: () {
                Navigator.of(context).pop('/HomeView');
              },
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
            ),
        ],
        ),
      ),
    );
  }
}



