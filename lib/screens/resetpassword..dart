import 'package:flutter/material.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/utils/colors.dart';
import 'package:we_work/utils/responsive.dart';
import 'package:we_work/widgets/input_decoration.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final Auth auth = Auth();

  final TextEditingController _emailcontroller = TextEditingController();

  String get _email => _emailcontroller.text;

  Future<void> reset() async {
    try {
      await auth.resetPassword(_email);
      _emailcontroller.clear();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Link Sent'),
            content: Text(
              'Password reset link sent',
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  child: Text('OK'))
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sending password reset link failed'),
            content: Text(
              'Failed to send password reet link',
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        },
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 200.0, horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: UiColors.color1,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.grey[500]),
                    decoration: textInputDecoration(labelText: 'Your Email'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth(context, 1),
                  height: screenHeight(context, 0.1),
                  child: RaisedButton(
                    onPressed: reset,
                    child: Text('Reset password'),
                    color: UiColors.color2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
