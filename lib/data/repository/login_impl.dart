import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/data/static/dataContainer.dart';
import 'package:smart_home/domain/model/account.dart';
import 'package:smart_home/domain/repository/login.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class LoginRepositoryImpl implements LoginRepository {
  final String _url = "";

  final Dio dio = Dio();

  @override
  Future<bool> Login(String username, String password) async {
    String url="${_url}log_in.php";

     String jsonToSend = "";
    if (username.isNotEmpty&&password.isNotEmpty) {
      jsonToSend =
          "{\"username\": \"$username\",\"password\": \"${sha256.convert(utf8.encode(password))}\"}";
    }

    var response = await dio.post(url, data: jsonToSend);

    if (response.data.toString().contains("true")) {
      DataContainer.username=username;
      DataContainer.password=password;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> SignUp(Account account) async {
    String url = "${_url}sign_up.php";
    String jsonToSend = "";
    if (account.phoneNumber.isNotEmpty) {
      jsonToSend =
          "{\"first_name\": \"${account.firstName}\",\"last_name\": \"${account.lastName}\",\"username\": \"${account.username}\",\"email\":\"${account.email}\",\"password\":\"${sha256.convert(utf8.encode(account.password))}\",\"phone_number\":\"${account.phoneNumber}\"}";
    } else {
      jsonToSend =
          "{\"first_name\": \"${account.firstName}\",\"last_name\": \"${account.lastName}\",\"username\": \"${account.username}\",\"email\":\"${account.email}\",\"password\":\"${sha256.convert(utf8.encode(account.password))}\"}";
    }

    var response = await dio.post(url, data: jsonToSend);

    if (response.data.toString().contains("User signed up successfully")) {
      
      Fluttertoast.showToast(msg: "User created successfully");
      return true;
      
    } else {
      Fluttertoast.showToast(msg: "Error occured when creating user");
      return false;
    }
  }

  @override
  Future<bool> CheckIfAccountExist(String username) async {
    String url = "${_url}check_if_user_exists.php";
    String jsonToSend = "{\"account_username\":\"$username\"}";
    var response = await dio.post(url, data: jsonToSend);

    bool data = response.data.toString().contains("true");

    return data;
  }
}
