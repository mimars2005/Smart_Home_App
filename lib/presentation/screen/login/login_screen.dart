import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:smart_home/data/repository/login_impl.dart';
import 'package:smart_home/presentation/screen/background.dart';
import 'package:smart_home/presentation/screen/dashboard/Dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.controller});

  final PageController controller;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  LoginRepositoryImpl login=LoginRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 236, 244),
      body: Stack(
        children: [
          const Background(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "LOG IN",
                      style: GoogleFonts.signika(
                          color: Colors.white, fontSize: 30),
                    ),
                  ),
                  TextField(
                    controller: username,
                    enableInteractiveSelection: false,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Username",
                      icon: Icon(
                        Icons.person_outline,
                      ),
                      iconColor: Color.fromARGB(255, 255, 255, 255),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13),
                    ),
                  ),
                  TextField(
                    controller: password,
                    enableInteractiveSelection: false,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock_outline,
                      ),
                      iconColor: Color.fromARGB(255, 255, 255, 255),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: const Text(
                        "Or",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                  TextButton(
                      style: ButtonStyle(
                          surfaceTintColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent)),
                      onPressed: () async {
                        if(await login.Login(username.text, password.text))
                        {
                          Fluttertoast.showToast(msg: "Logged in succesfully");
                          Navigator.push(context, MaterialPageRoute(builder:(context) =>const Dashboard(),));
                        }
                        else
                        {
                          Fluttertoast.showToast(msg: "Username or password wrong");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            border: GradientBoxBorder(
                                width: 2,
                                gradient: LinearGradient(
                                    transform: GradientRotation(8),
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(0, 120, 120, 120)
                                    ])),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.elliptical(16, 14),
                                bottom: Radius.elliptical(16, 14)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(122, 24, 111, 183),
                              Color.fromARGB(207, 59, 101, 174)
                            ])),
                        child: Text(
                          "Log In",
                          style: GoogleFonts.questrial(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an account?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 131, 131, 131)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent)),
                        onPressed: () async {
                          await widget.controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceInOut);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
