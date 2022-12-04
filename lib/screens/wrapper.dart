import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_work/screens/signin_screen.dart';
import 'package:we_work/screens/dashboard.dart';
import 'package:we_work/services/auth.dart';

class Wrapper extends StatelessWidget {
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user != null ? Dashboard() : SignIn();
  }
}
