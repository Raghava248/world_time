import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;//location name for the UI
  String time; //the time in that location
  String flag;// to an asset flag icon
  String url; //location url for api endpoint
  bool isDaytime;// true or false if daytime or not
  WorldTime({this.location,this.flag,this.url});
  Future<void> getTime() async{
    try{
      http.Response response = await  http.get(Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));
      Map data =  jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'];


      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse( offset.substring(1,3))));

      //set the time property

      isDaytime = now.hour > 6 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now);
    }catch(e){
      print('error caught- $e');
      time = 'could not get time data';
    }

  }
}

