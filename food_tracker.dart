import 'package:flutter/cupertino.dart';
import 'reuseable.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('insidethemind'),
      ),
      child: Center(
        child: Column(

        ),
      ),

    );
  }
}
