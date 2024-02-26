import "package:flutter/Material.dart";

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
    
//LINE 14 - 33 is not used. But its implementation is correct
    //A function that converts a String of Map to Map
    Map<String, String> stringToMap(String input) {
      Map<String, String> resultMap = {};
      input = input.substring(1, input.length-1);
      input = input.trim();
      List<String> keyValuePairs = input.split(',');
      for (String pair in keyValuePairs) {
        for (int i = 0; i < pair.length; i++) {
          // Access the character at index i
          String currentChar = pair[i];
          // Compare the current character with the character to compare
          if (currentChar == ':') {
              String key = input.substring(0, i);
              String value = input.substring(i + 1);
              resultMap[key] = value;
            break;
          }
        }
      }
      return resultMap;
    }


//BRIEFING: The problem roots from the ModalRoute.of(context).settings.arguments which is expected to receive Map data from the loading page but instead
//          receives IdentityMap type (Custom type) and sometimes Null type for, trust me, unknown reasons. Every step is taken to tackle it but it 
//          could not function as intended. Here are the modified parts which are to be restored if things work in the future tests, if any.
//              Uncomment Line 57       and remove the Lines 47 - 56
//              Line 61 and 62 change the value of bgColor and bgImage to the value in the comment

  Map data = {};

  @override
  Widget build(BuildContext context){

    //Receive data from loading or location page
    if (ModalRoute.of(context)?.settings.arguments == null){
      data = {'location': "Berlin", 'flag': "berlin.png", 'url': "Europe/Berlin", 'time': "10:41 AM", 'isDayTime': true};  //default value
    }
    else {
      print(ModalRoute.of(context)!.settings.arguments.toString());
      // String dataReturned = ModalRoute.of(context)!.settings.arguments.toString();        //Using print statements, it is known that it has the type: IdentityMap<String, Object>
      // data = stringToMap(dataReturned);
      data = {'location': "Berlin", 'flag': "berlin.png", 'url': "Europe/Berlin", 'time': "10:41 AM", 'isDayTime': true};  //default value
    }
    print(ModalRoute.of(context)?.settings.arguments.runtimeType); // this is either Null, IdentityMap or LinkedMap
    // data = (data.isNotEmpty) ? data : ModalRoute.of(context)?.settings.arguments;

    //set Background
    String bgImage = 'night.png';//data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = Colors.blue;//data['isDayTime'] ? Colors.blue : Colors.indigo; 

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
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDayTime': result['isDayTime'],
                      'flag': result['flag'],
                    };
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