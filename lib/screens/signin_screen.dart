import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:we_work/screens/signup_screen.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/utils/colors.dart';
import 'package:we_work/utils/responsive.dart';
import 'package:we_work/widgets/input_decoration.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loading = false;
  bool _isPasswordMasked = true;
  final Auth auth = Auth();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String get _email => _emailcontroller.text;
  String get _pass => _passwordcontroller.text;

  Widget snackBar(message) => SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      );

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _loading = true;
      });
      print(_email);
      print(_pass);
      dynamic user = await auth.signinwithemail(_email.trim(), _pass);

      if (user.runtimeType != User) {
        print(user);
        setState(() {
          _loading = false;
          switch (user) {
            case "ERROR_USER_NOT_FOUND":
              _scaffoldKey.currentState
                  .showSnackBar(snackBar("This user does not exist"));
              break;
            case "ERROR_WRONG_PASSWORD":
              _scaffoldKey.currentState
                  .showSnackBar(snackBar("Email or password is incorrect"));
              break;
            default:
              _scaffoldKey.currentState.showSnackBar(
                  snackBar("An unknown error occured, please try again"));
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: UiColors.bg,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 60.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.07),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: UiColors.color1,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextFormField(
                          controller: _emailcontroller,
                          validator: (_email) {
                            if ((_email.isEmpty)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.grey[500]),
                          decoration:
                              textInputDecoration(labelText: 'Your Email'),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.03),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: UiColors.color1,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          controller: _passwordcontroller,
                          validator: (_pass) {
                            if ((_pass.isEmpty)) {
                              return 'Enter password';
                            }
                            return null;
                          },
                          obscureText: _isPasswordMasked,
                          style: TextStyle(color: Colors.grey[500]),
                          decoration: textInputDecoration(
                              labelText: 'Password',
                              sicon: IconButton(
                                  icon: Icon(
                                    _isPasswordMasked
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black38,
                                    size: 23.0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordMasked = !_isPasswordMasked;
                                    });
                                  })),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.03),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/reset'),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text('Forgot password?'),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.05),
                      ),
                      Container(
                        width: screenWidth(context, 1),
                        height: screenHeight(context, 0.1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: UiColors.color2, width: 2),
                        ),
                        child: RaisedButton(
                          onPressed: signIn,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: UiColors.color2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: UiColors.bg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.02),
                      ),
                      Text(
                        'OR',
                        style: TextStyle(color: UiColors.color5),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.02),
                      ),
                      Container(
                        width: screenWidth(context, 1),
                        height: screenHeight(context, 0.1),
                        child: RaisedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/signup');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            'Create account',
                            style: TextStyle(
                              color: UiColors.color1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: UiColors.color2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
