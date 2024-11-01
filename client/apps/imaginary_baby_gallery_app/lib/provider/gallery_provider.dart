import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/services/NetworkService.dart';

import '../models/gallery_model.dart';

class GalleryProvider with ChangeNotifier{
  final NetworkService _networkService = NetworkService();

  List<GalleryModel> _gallery = [];
  List<GalleryModel> get gallery => _gallery;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchGallery() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      _gallery = await _networkService.fetchGallery();
      _isLoading = false;
    }catch(e){
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }


}