import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_home/presentation/screen/login/login_screen.dart';
import 'package:smart_home/presentation/screen/login/sign_up_screen.dart';

Future<void> main() async {
  PageController loginController = PageController(
    initialPage: 0,
  );
  await dotenv.load();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageView(
        controller: loginController,
        scrollDirection: Axis.horizontal,
        children: [
          LoginPage(controller: loginController),
          SignUpPage(controller: loginController)
        ],
      )));
}
