import "package:flutter/Material.dart";
import 'package:provider/provider.dart';
import 'package:world_time/services/location_provider.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
    
  Map data = {};    //Avoids Null error

  @override
  Widget build(BuildContext context){

    //Receive data from loading or location page
    //data = {'location': "Berlin", 'flag': "berlin.png", 'url': "Europe/Berlin", 'time': "10:41 AM", 'isDayTime': true};  //default value
    data = context.watch<LocationProvider>().selectedLocation;

    //set Background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo; 

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/${bgImage}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/location');
                  setState(() {
                    //No need to put statement, it is always executed during onPressed event
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey[300],),
                label: Text(
                  "Edit Location",
                  style: TextStyle(
                    color: Colors.grey[300],),),
                  ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                data['time'],
                style: const TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              ),
            ],),
          ),
        ),
      );
  }
}