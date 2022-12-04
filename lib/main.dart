import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_work/providers/jobs_provider.dart';
import 'package:we_work/screens/all_jobs.dart';
import 'package:we_work/screens/resetpassword..dart';
import 'package:we_work/screens/signin_screen.dart';
import 'package:we_work/screens/signup_screen.dart';
import 'package:we_work/screens/splash_screen.dart';
// import 'package:we_work/screens/wrapper.dart';
import 'package:we_work/screens/dashboard.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: Auth().onAuthStateChanged),
        ChangeNotifierProvider<JobsProvider>(
          create: (context) => JobsProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'weW',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(color: UiColors.bg),
        ),
        home: Splash(),
        routes: {
          '/alljobs': (context) => AllJobs(),
          '/dashboard': (context) => Dashboard(),
          '/signin': (context) => SignIn(),
          '/reset': (context) => ResetPassword(),
          '/signup': (context) => SignUp(),
          // '/profile': (context) => Profile(),
        },
      ),
    );
  }
}
