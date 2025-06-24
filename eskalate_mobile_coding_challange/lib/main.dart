import 'package:eskalate_mobile_coding_challange/model/country_model.dart';
import 'package:eskalate_mobile_coding_challange/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyApp._fetchInitialCountryData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static List<Country> allCountriesData = [];

  static Future<void> _fetchInitialCountryData() async {
    final String apiUrl =
        "https://restcountries.com/v3.1/independent?status=true&fields=name,population,flag,area,region,subregion,timezones";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        allCountriesData =
            jsonList.map((json) => Country.fromJson(json)).toList();
        print(
          'Successfully fetched ${allCountriesData.length} countries from API.',
        );
      } else {
        print('Failed to load countries from API: ${response.statusCode}');
        allCountriesData = [];
      }
    } catch (e) {
      print('Error fetching countries: $e');
      allCountriesData = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue[600]!, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: EdgeInsets.zero,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
