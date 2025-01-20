import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../model/CountryModel.dart';
import '../model/WorldCovidModel.dart';

class ApiServices{
  
  Future<WorldCovidModel> worldCovid()async{
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if(response.statusCode==200){
      final data= jsonDecode(response.body);
      return WorldCovidModel.fromJson(data);
    }else{
      return throw Exception('World Covid handle error');
    }
  }
  
  Future<List<CountryModel>> countryCovid()async{
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if(response.statusCode==200){
      return List<CountryModel>.from(json.decode(response.body).map((x)=>CountryModel.fromJson(x)));
    }else{
      throw Exception('');
    }
  }
  
}