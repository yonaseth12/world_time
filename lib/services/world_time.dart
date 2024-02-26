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
    // print("Your are on our watch./n Your IP: ${data["client_ip"]}");
    String datetime = data["datetime"];
    String offset = data["utc_offset"];

    //Create a DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset.substring(1,3))));

    // time = now.toString();     //Better formating is provided below using intl package
    time = DateFormat.jm().format(now);
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    }
    catch (e){
      time = "Network Problem, try Again!";
      print('Data could not be fetched');
    }
  }
}