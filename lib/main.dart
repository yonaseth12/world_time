import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/services/location_provider.dart';

void main() {
  runApp(WorldTimeApp());
}

class WorldTimeApp extends StatelessWidget {
  const WorldTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoadingScreen(),
          '/home': (context) => Home(),
          '/location': (context) => ChooseLocation(),
        },
      )
    );
  }
}
