// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignProvider extends ChangeNotifier {
  var url = Uri.https("go-auth-backend.onrender.com", "auth/sign-in");
  String action = "Sign In";

  final RegExp _emailPattern =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  String emailErrorText = "";
  String passwordErrorText = "";

  String? _isEmailValid(email) {
    if (email.isEmpty) {
      emailErrorText = "Please enter an Email";
      notifyListeners();
      return "";
    } else if (!_emailPattern.hasMatch(email)) {
      emailErrorText = "Please enter a valid email";
      notifyListeners();
      return "";
    } else {
      emailErrorText = "";
      notifyListeners();
      return null;
    }
  }

  String? _isPasswordValid(password) {
    if (password.isEmpty) {
      passwordErrorText = "Please enter a password";
      notifyListeners();
      return "";
    } else {
      passwordErrorText = "";
      notifyListeners();
      return null;
    }
  }

  bool validateLogin(String email, String password) {
    String? e = _isEmailValid(email);
    String? p = _isPasswordValid(password);
    if (e == null && p == null) {
      return true;
    } else {
      return false;
    }
  }

  signIn(BuildContext context, String email, String password) async {
    action = "Please wait...";
    http.Request request = http.Request("post", url);
    request.headers.clear();
    request.headers.addAll({"content-type": "application/json; charset=utf-8"});
    request.body =
        // '{"email": "olayinkacodes@gmail.com", "password": "testOlayinka"}';
        '{"email": "$email", "password": "$password"}';
    var response = await request.send();

    if (response.statusCode == 200) {
      action = "Continue";
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          dividerColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            decoration: ShapeDecoration(
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 40,
                    ),
                    Text(
                      "Sign in successful",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner();
                        action = "Sign In";
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Dismiss",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: const [
            Text(""),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          dividerColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            decoration: ShapeDecoration(
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 40,
                    ),
                    Text(
                      "Sign-in not successful",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner();
                        action = "Sign In";
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Dismiss",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: const [
            Text(""),
          ],
        ),
      );
      action = "Sign In";
    }
    notifyListeners();
  }
}
