import 'package:flutter/widgets.dart';

double screenHeight(context, double percentage) =>
    MediaQuery.of(context).size.height * percentage;

double screenWidth(context, double percentage) =>
    MediaQuery.of(context).size.width * percentage;
