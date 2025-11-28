import 'dart:convert';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel?> currentUser() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('CACHED_USER');

  if (jsonString == null) return null;

  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  return UserModel.fromJson(jsonMap);
}