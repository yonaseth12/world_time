import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier{
  
  Map<String, dynamic> selectedLocation = {};

  LocationProvider(){
    selectedLocation['location'] = '';
    selectedLocation['flag'] = '';
    selectedLocation['time'] = '';
    selectedLocation['isDayTime'] = true;
  }
  
  void changeLocation({required String location, required String flag, required String time, required bool isDayTime})
    {
    this.selectedLocation['location'] = location;
    this.selectedLocation['flag'] = flag;
    this.selectedLocation['time'] = time;
    this.selectedLocation['isDayTime'] = isDayTime;
    notifyListeners();
  }
}