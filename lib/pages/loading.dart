import "package:flutter/Material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/location_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  String time = "Time not fetched yet!";
  
  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: "Berlin", flag: "berlin.png", url: "Europe/Berlin");
    await instance.getTime();
    context.read<LocationProvider>().changeLocation(
      location: instance.location,
      flag: instance.flag,
      time: instance.time,
      isDayTime: instance.isDayTime,);
    Navigator.pushNamed(context, '/home');
  }
  @override
  void initState(){
    super.initState();
    setupWorldTime();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey[200],
          size: 60.0,
        ),
      ),
    );
  }
}