import 'package:smart_home/domain/model/account.dart';

abstract class LoginRepository {
  Future<bool> Login(String username, String password);
  Future<bool> SignUp(Account account);
  Future<bool> CheckIfAccountExist(String username);
}
