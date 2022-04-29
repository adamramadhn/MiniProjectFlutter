import 'package:flutter/material.dart';
import 'package:movie/auth/login.dart';
import 'package:movie/provider/profile_provider.dart';
import 'package:movie/screen/home_screen/home_screen.dart';
import 'package:movie/screen/registration_screen/register_screen.dart';
import 'package:movie/widgets/login_screen_widgets/login_screen_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences logindata;
  late bool newUser;
  final formLogin = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: formLogin,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nobarin',
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
                        child: inputEmail()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: inputPassword()),
                  const SizedBox(
                    height: 10,
                  ),
                  //btn sign in
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white)),
                        onPressed: () {
                          final isValidForm =
                              formLogin.currentState!.validate();
                          if (isValidForm) {
                            authLogin(txtEditEmail.text, txtEditPass.text);
                            txtEditEmail.clear();
                            txtEditPass.clear();
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //btn sign up
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white)),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            )),
                        child: const Text(
                          'Sign Up',
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

  void checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    newUser = logindata.getBool('newUser') ?? true;
    final id = logindata.getString('idProfile');
    if (id != null) {
      context.read<ProfileProvider>().getProfileData(id);
    }

    if (newUser == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())),
          (route) => false);
    }
  }

  void authLogin(String email, String password) async {
    logindata = await SharedPreferences.getInstance();
    final data = await AuthUser().login(email, password);
    if (email == data.email && password == data.password) {
      logindata.setBool('newUser', false);
      logindata.setString('idProfile', data.id!);
      context.read<ProfileProvider>().getProfileData(data.id!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    } else {
      logindata.setBool('newUser', true);
      logindata.remove('idProfile');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email/Password salah atau belum terdaftar!')));
    }
  }
}
