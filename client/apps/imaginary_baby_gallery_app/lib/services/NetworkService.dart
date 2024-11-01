import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imaginary_baby_gallery_app/models/gallery_model.dart';

import '../models/albumModel.dart';
import '../models/userModel.dart';

class NetworkService {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com/";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse("${_baseUrl}users"));
    print("users url: ${_baseUrl}users");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<List<Album>> fetchAlbums() async{
    final response =  await http.get(Uri.parse("${_baseUrl}albums"));
    print("album url: ${_baseUrl}users");

    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    }else{
      throw Exception('Failed to load albums');
    }

  }

  Future <List<GalleryModel>> fetchGallery()async {
    final response = await http.get(Uri.parse("${_baseUrl}photos"));
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((gallery) => GalleryModel.fromJson(gallery)).toList();
    }else{
      throw Exception('Failed to load gallery');
    }
  }
}
