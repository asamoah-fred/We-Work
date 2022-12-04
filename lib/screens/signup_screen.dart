import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:we_work/constants/constant.dart';
import 'package:we_work/screens/profile.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/services/database.dart';
import 'package:we_work/utils/colors.dart';
import 'package:we_work/utils/responsive.dart';
import 'package:we_work/widgets/input_decoration.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

const List<String> experiences = ['Senior', 'Mid-senior', 'Junior'];

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loading = false;
  bool _isPasswordMasked = true;
  final Auth auth = Auth();
  Queries queries = Queries(); /*  */
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _githubcontroller = TextEditingController();
  final TextEditingController _resumecontroller = TextEditingController();
  // String _uid;

  String get _email => _emailcontroller.text;
  String get _pass => _passwordcontroller.text;
  String get _name => _namecontroller.text;
  String get _phone => _phonecontroller.text;
  String get _github => _githubcontroller.text;
  String get _resume => _resumecontroller.text;

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != steps.length ? goTo(currentStep + 1) : signUp();
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      setState(() => currentStep = step);
      setState(() {
        _loading = false;
      });
    }
  }

  void passwordunmask() {
    setState(() {
      _isPasswordMasked = !_isPasswordMasked;
    });
  }

  // <-- drop downmenu for experience -->
  String _selectedexperience = 'Senior';
  List<DropdownMenuItem> getDRopDownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String experience in experiences) {
      var newItem =
          DropdownMenuItem(child: Text(experience), value: experience);
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  Widget snackBar(message) => SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      );

  //save profile data
  Future<void> _save(String uid) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await queries.createprofile(
            uid, _name, _email, _phone, _selectedexperience, _github, _resume);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      dynamic user = await auth.signupwithemail(_email.trim(), _pass);

      print(user);
      if (user.runtimeType != User) {
        setState(() {
          _loading = false;
          switch (user) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              _scaffoldKey.currentState
                  .showSnackBar(snackBar("User already exists"));
              break;
            default:
              _scaffoldKey.currentState.showSnackBar(
                  snackBar("An unknown error occured, please try again"));
          }
        });
      } else {
        // I am calling this here because, the user has to be saved before the profile is created, if we call it at the top, the profile will be created even if the signup fails
        _save(user.uid); // save userData into profile
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  List<Step> get steps => [
        Step(
          title: Text('Account'),
          isActive: currentStep == 0 ? true : false,
          state: StepState.editing,
          content: Column(
            children: <Widget>[
              Form(
                key: _formKey,
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
                        controller: _namecontroller,
                        validator: (_name) {
                          if ((_name.isEmpty)) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        decoration:
                            textInputDecoration(hintText: 'Your Full Name'),
                      ),
                    ),
                    SizedBox(height: 10),
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
                          if (!regex.hasMatch(_email) ||
                              !EmailValidator.validate(_email)) {
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
                    SizedBox(height: 10),
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
                          if ((_pass.isEmpty) || !(_pass.length > 5)) {
                            // You made it more 6 but but the app was accepting 6
                            return 'Password must be more than 5 characters';
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
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep == 1 ? true : false,
          state: StepState.complete,
          title: const Text('Profile'),
          content: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: UiColors.color1,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phonecontroller,
                    validator: (_phone) {
                      if ((_phone.isEmpty) || !(_phone.length > 9)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    decoration:
                        textInputDecoration(hintText: 'Your Phone Number'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: UiColors.color1,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextFormField(
                    controller: _githubcontroller,
                    validator: (_github) {
                      if ((_github.isEmpty) ||
                          (!Uri.parse(_github).isAbsolute)) {
                        return 'Url should start with http:// or https://';
                      }
                      return null;
                    },
                    decoration: textInputDecoration(
                        hintText: 'Github / LinkedIn / Portfolio Link'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // width: screenWidth(context, 1),
                  decoration: BoxDecoration(
                    color: UiColors.color1,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: DropdownButtonFormField(
                      // underline: SizedBox(),
                      hint: Text('Work Experience'),
                      decoration: textInputDecoration(hintText: 'Experience'),
                      value: _selectedexperience,
                      items: getDRopDownItems(),
                      onChanged: (value) {
                        setState(() {
                          _selectedexperience = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: UiColors.color1,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextFormField(
                    controller: _resumecontroller,
                    validator: (_resume) {
                      if ((_resume.isEmpty) ||
                          (!Uri.parse(_resume).isAbsolute)) {
                        return 'Url should start with http:// or https://';
                      }
                      return null;
                    },
                    decoration: textInputDecoration(hintText: 'Link to Resume'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Stepper(
                    controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: cancel,
                              child: const Text('BACK'),
                            ),
                            SizedBox(width: 20),
                            RaisedButton(
                              onPressed: next,
                              color: UiColors.color2,
                              child: Text(
                                currentStep == 1 ? "SIGN UP" : "NEXT",
                                style: TextStyle(color: UiColors.color1),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    steps: steps,
                    type: StepperType.horizontal,
                    // type: StepperType.horizontal,
                    currentStep: currentStep,
                    // onStepContinue: next,
                    onStepTapped: (step) => goTo(step),
                    // onStepCancel: cancel,
                  ),
                ),

                // Container(
                //   width: screenWidth(context, 1),
                //   height: screenHeight(context, 0.1),
                //   child: RaisedButton(
                //     onPressed: signUp,
                //     child: Text(
                //       'Sign Up',
                //       style: TextStyle(
                //           color: UiColors.color1,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     color: UiColors.color2,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: screenHeight(context, 0.08),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'I haave an account ',
                      style: TextStyle(color: Colors.grey[400]),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                              color: UiColors.color2,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
