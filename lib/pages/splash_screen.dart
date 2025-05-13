import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void splashScreen() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  static const appTitle = 'Splash Screen';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: SplashScreen(title: appTitle),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState() 
  {
    super.initState();
    Future.delayed(Duration(seconds: 3), () 
    {
      if(context.mounted)
      {
        /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Profile Page',)),
              );*/
      }
    });
  } 

  @override Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image.asset(
            //'NAME',
            //width: 200,
            //height: 200,
            //),
            SizedBox(height: 20),
            Text(
              "Proyecto 2",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}