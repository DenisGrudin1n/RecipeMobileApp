import 'package:get/get.dart';
import 'package:recipeapp/models/user.dart';
import 'package:recipeapp/services/auth_methods.dart';

class UserController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user.value;

  @override
  void onInit() {
    super.onInit();
    refreshUser();
  }

  Future<void> refreshUser() async {
    User? user = await _authMethods.getUserDetails();
    _user.value = user;
  }
}
