
// add to main
// WidgetsFlutterBinding.ensureInitialized();

//  await CachHelper.initial();

import 'package:shared_preferences/shared_preferences.dart';

class CachHelper{

 static late SharedPreferences sharePreference;
 static initial() async {
   sharePreference = await SharedPreferences.getInstance();
 }

 static dynamic  getData({
   required String key,

 }){
   return sharePreference.get(key);
 }

 static Future<bool> saveData({
   required String key,
   required dynamic value
}) async {
   if(value is String) return await sharePreference.setString(key, value);
   if(value is int) return await sharePreference.setInt(key, value);
   if(value is double) return await sharePreference.setDouble(key, value);
    return await sharePreference.setBool(key, value);
 }

 static Future<bool>  removeData({
   required String key,

 }){
   return sharePreference.remove(key);
 }


}