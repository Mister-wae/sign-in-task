// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String text = "show";
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green,
            Colors.blue,
          ],
        ),
      ),
      child: Consumer<SignProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email address"),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          width: MediaQuery.sizeOf(context).width - 48,
                          height: 50,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  child: TextField(
                                    controller: widget._emailController,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "person1@gmail.com",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(149, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  provider.emailErrorText == ""
                      ? const SizedBox()
                      : Text(
                          provider.emailErrorText,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Password"),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          width: MediaQuery.sizeOf(context).width - 48,
                          height: 50,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  child: TextField(
                                    controller: widget._passwordController,
                                    obscureText: obscure,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "*********",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(149, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (text == "hide") {
                                          text = "show";
                                        } else {
                                          text = "hide";
                                        }
                                        obscure = !obscure;
                                      });
                                    },
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  provider.passwordErrorText == ""
                      ? const SizedBox()
                      : Text(
                          provider.passwordErrorText,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.sizeOf(context).width - 45,
                      decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 8, 58, 99),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Text(
                        provider.action,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    onTap: () async {
                      bool isCredentialValid;
                      isCredentialValid = provider.validateLogin(
                        widget._emailController.text,
                        widget._passwordController.text,
                      );
                      if (isCredentialValid == true) {
                        provider.signIn(
                          context,
                          widget._emailController.text,
                          widget._passwordController.text,
                        );
                      } else {}
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
