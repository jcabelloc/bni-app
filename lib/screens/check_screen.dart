import 'package:bniapp/screens/login/login_screen.dart';
import 'package:bniapp/screens/main/main_screen.dart';
import 'package:bniapp/services/auth_service.dart';
import 'package:bniapp/utils/miembro_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CheckScreen extends StatefulWidget {
  static const String id = 'check_screen';

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final _authService = AuthService();
  bool showSpinner = true;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    FirebaseUser user = await _authService.getCurrentUser();
    if (user != null) {
      await Provider.of<MiembroState>(context, listen: false).loadMiembro();
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
    setState(() => showSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(),
    );
  }
}
