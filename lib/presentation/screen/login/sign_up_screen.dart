import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_home/data/repository/login_impl.dart';
import 'package:smart_home/domain/model/account.dart';
import 'package:smart_home/presentation/screen/background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/presentation/screen/login/widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.controller});

  final PageController controller;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var username = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var secondPassword = TextEditingController();
  var phoneNumber = TextEditingController();
  var countrySelected = "+359";

  var scrollController = ScrollController();
  LoginRepositoryImpl loginImpl = LoginRepositoryImpl();
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
              padding: const EdgeInsets.only(left: 35, right: 35, top: 100),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 43,
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent)),
                        onPressed: () async {
                          await widget.controller.animateToPage(0,
                              duration: const Duration(microseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Image.asset("asset/arrow.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, top: 25),
                      child: Text(
                        "SIGN UP",
                        style: GoogleFonts.signika(
                            color: Colors.white, fontSize: 30),
                      ),
                    ),
                    InputField(
                      controller: firstName,
                      label: "First name",
                      icon: Icons.person_outline,
                    ),
                    InputField(
                      controller: lastName,
                      label: "Last name",
                      icon: Icons.person_outline,
                    ),
                    InputField(
                      controller: username,
                      label: "Username",
                      icon: Icons.person_outline,
                    ),
                    InputField(
                      controller: email,
                      label: "Email",
                      icon: Icons.person_outline,
                      isPassword: false,
                    ),
                    InputField(
                      controller: password,
                      label: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    InputField(
                      controller: secondPassword,
                      label: "Confirm Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    InternationalPhoneNumberInput(
                      onSaved: (value) {
                        countrySelected = value.isoCode.toString();
                      },
                      textFieldController: phoneNumber,
                      inputDecoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255))),
                          hintText: "Phone number",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      initialValue: PhoneNumber(isoCode: "BG"),
                      onInputChanged: (value) {},
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: const TextStyle(color: Colors.white),
                      inputBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      selectorTextStyle: const TextStyle(color: Colors.white),
                    ),
                    const Padding(padding: EdgeInsets.all(40)),
                    TextButton(
                        style: ButtonStyle(
                            surfaceTintColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent)),
                        onPressed: () async {
                          if (username.text.isNotEmpty) {
                            if (await loginImpl.CheckIfAccountExist(
                                username.text)) {
                              await Fluttertoast.showToast(
                                  msg: "Username is not available");
                            } else {
                              if (password.text != secondPassword.text &&
                                  (password.text.isNotEmpty ||
                                      secondPassword.text.isNotEmpty)) {
                                await Fluttertoast.showToast(
                                    msg: "Passwords do not match");
                              } else {
                                Account account = Account();
                                account.firstName = firstName.text;
                                account.lastName = lastName.text;
                                account.username = username.text;
                                account.password = password.text;
                                if (phoneNumber.text.isNotEmpty) {
                                  account.phoneNumber = phoneNumber.text;
                                }
                                loginImpl.SignUp(account);
                              }
                            }
                          } else {
                            await Fluttertoast.showToast(msg: "Enter username");
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
                            "Sign Up",
                            style: GoogleFonts.questrial(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
