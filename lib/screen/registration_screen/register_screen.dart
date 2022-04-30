import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:movie/auth/login.dart';
import 'package:movie/repository/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/registration_screen/registration_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late SharedPreferences logindata;
  late bool newUser;
  final formRegis = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: formRegis,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: regisInputEmail()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: regisInputPassword()),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white)),
                        onPressed: () {
                          final isValidForm =
                              formRegis.currentState!.validate();
                          if (isValidForm) {
                            final bool isValid =
                                EmailValidator.validate(txtRegisEmail.text);
                            if (isValid) {
                              authLogin(txtRegisEmail.text, txtRegisPass.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Email is not valid!')));
                              txtRegisPass.clear();
                            }
                          }
                        },
                        child: const Text(
                          'Sing Up',
                          style: TextStyle(color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void authLogin(String email, String password) async {
    final ava = await ProfileApi().getImageRandom();
    await AuthUser().register(email, password, ava.urls!.small!);
    txtRegisEmail.clear();
    txtRegisPass.clear();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Success!\nSilahkan Login')));
  }
}
