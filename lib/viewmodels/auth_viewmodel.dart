import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/models/eror_model.dart';


import '../models/user-model.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final StorageService _storageService;
  final AuthService _authService;
  bool isLoading = false;



  AuthViewModel(this._storageService, this._authService)  {
    init();
  }
  Future<void> init() async{

    String? token =await _storageService.getToken();
    if(token != null){
      _isLoggedIn = true;
      notifyListeners();
    }

  }

  bool _isLoggedIn = false;
  User? _user;
  String? errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  Future<bool> login({required context, required String email, required String password}) async {
    isLoading = true;
    notifyListeners();

    User? result = await _authService.login(email, password);

    isLoading = false;

    if (result != null) {
      _user =result;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }

  }



  Future<ErrorModel?> register({required String username,required String email, required String password}) async{
    isLoading =true;
    notifyListeners();
    var message =await _authService.register(email: email,username: username, password: password);


    isLoading =false;
    notifyListeners();

    return message;



  }

  Future<bool> sendcode({required String email}) async{
    isLoading = true;
    notifyListeners();

    bool isSend =await _authService.sendcode(email: email);

    isLoading =false;
    notifyListeners();

    return isSend;


  }
  Future<bool> changethepassword({required String email,required String code, required String password}) async{
    isLoading =true;
    notifyListeners();

    bool isChange =await _authService.changethepassword(email: email, code: code, password: password);


    isLoading =false;
    notifyListeners();

    return isChange;



  }
  void logout() {
    _isLoggedIn = false;
    _storageService.clearToken();
    notifyListeners();
  }

  Future<void> loadUser() async{
    _user =await _storageService.loadUser();
    notifyListeners();



}



}
