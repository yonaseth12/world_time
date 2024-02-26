import "package:http/http.dart";
import "dart:convert";
import "package:intl/intl.dart";

class WorldTime {
  String location = '';
  String time = '';
  String flag = '';
  String url = '';
  bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try{
    Response response = await get(Uri.http("worldtimeapi.org", "/api/timezone/$url"));
    Map data = jsonDecode(response.body);
    String datetime = data["datetime"];
    String offset = data["utc_offset"];

    //Create a DateTime object
    DateTime now = DateTime.parse(datetime);

    //Offset is causing error, it is only considering the hour digit. TO BE FIXED IN FUTURE UPDATES
    //However, the following line works well in returning to 24 when hours becomes negative in the offset adjustment. (Eg. if GMT = 5 and offset = -7, it returns 22, not -2) 
    now = now.add(Duration(hours: int.parse(offset.substring(0,3))));
    
    // time = now.toString();     //Better formating is provided below using intl package
    time = DateFormat.jm().format(now);
    isDayTime = (now.hour > 6 && now.hour < 18) ? true : false;
    }
    catch (e){
      time = "Network Problem, try Again!";
    }
  }
}