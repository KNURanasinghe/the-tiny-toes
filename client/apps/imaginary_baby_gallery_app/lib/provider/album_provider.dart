import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/services/NetworkService.dart';

import '../models/albumModel.dart';

class AlbumProvider with ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  List<Album> _albums = [];
  List<Album> get albums => _albums;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAlbums() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      _albums = await _networkService.fetchAlbums();
      _isLoading = false;
    }catch(e){
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }
}
