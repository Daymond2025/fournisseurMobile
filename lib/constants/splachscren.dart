import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/LoginController.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController _authController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus(); // Appel pour vérifier l'état de connexion
  }

  Future<void> _checkAuthStatus() async {
    await _authController.checkLoginStatus(); // Vérification de l'état du token
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Affichage d'un loader pendant la vérification
      ),
    );
  }
}