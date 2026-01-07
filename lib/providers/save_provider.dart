import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';

class SaveProvider extends ChangeNotifier {
  final ApiClient api;

  bool isLoading = false;

  SaveProvider({required this.api});

  Future<void> createCocktail(Map<String, dynamic> payload) async {
    isLoading = true;
    notifyListeners();

    try {
      await api.dio.post('/api/cocktails', data: payload);

    } catch(e) {
      print("------------ $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}


