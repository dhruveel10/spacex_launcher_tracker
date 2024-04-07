import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launcher_tracker/screens/home_screen.dart';
import 'package:spacex_launcher_tracker/screens/login_screen.dart';
import 'package:spacex_launcher_tracker/screens/register_screen.dart';
import 'package:spacex_launcher_tracker/services/spacex_api_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpaceXApiService(),
      child: MaterialApp(
        title: 'SpaceX Launches',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitialScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/space_x_logo.jpeg',
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  textStyle: TextStyle(fontSize: 18),
                  primary: Colors.white24,
                  onPrimary: Colors.black.withOpacity(0.1),
                  foregroundColor: Colors.white,
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  textStyle: TextStyle(fontSize: 18),
                  primary: Colors.white24,
                  onPrimary: Colors.black.withOpacity(0.1),
                  foregroundColor: Colors.white,
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

