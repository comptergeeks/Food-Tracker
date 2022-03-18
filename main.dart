import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'log_in.dart';
import 'register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'food_tracker.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'providers/index_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserToSave()),
        ChangeNotifierProvider(create: (_) => IndexToSave())
      ],
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomeView(),
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemBlue,
      ),
      routes: {
        'HomeView': (_) => MainPage(),
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
              child:
                  const Text('Log In', style: TextStyle(color: Colors.white)),
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
              child: const Text('Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
//move to separate page, to separate by screens
