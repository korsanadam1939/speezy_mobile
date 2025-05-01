import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/models/user.dart';

import '../services/auth_service.dart';
import '../services/storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final StorageService _storageService;
  final AuthService _authService;



  AuthViewModel(this._storageService, this._authService)  {
    init();
  }
  Future<void> init() async{

    List<String?> token =await _storageService.getToken();
    if(token[0] != null && token.isNotEmpty && token[1] != null){
      _isLoggedIn = true;
      notifyListeners();
    }

  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<String?> login({required context ,required String email, required String password}) async{


    Map<String?, String?>? informations = await _authService.login(email: email, password: password);

    String? accesstoken =informations?["accestoken"];
    String? refreshtoken =informations?["refresstoken"];
    String? username =informations?["username"];
    String? email2 =informations?["username"];


    _isLoggedIn = true;
    if(refreshtoken!= null && accesstoken!= null){

      _storageService.saveToken(accestoken: accesstoken, refreshtoken: refreshtoken);

      Provider.of<UserProvider>(context, listen: false)
          .saveUser(username ?? 'veri yok', email);


      return accesstoken;

    }


    return null;


    notifyListeners();
  }

  Future<Map<String?, dynamic>?> register({required String username,required String email, required String password}) async{

    Map<String?, dynamic>? yanit =await _authService.register(email: email,username: username, password: password);


    return yanit;

    notifyListeners();

  }

  Future<bool> sendcode({required String email}) async{

    bool yanit =await _authService.sendcode(email: email);


    return yanit;


  }
  Future<Map<String?, dynamic>?> changethepassword({required String email,required String code, required String password}) async{

    Map<String?, dynamic>? yanit =await _authService.changethepassword(email: email, code: code, password: password);


    return yanit;



  }
  void logout() {
    _isLoggedIn = false;
    _storageService.clearToken();
    notifyListeners();
  }



}
