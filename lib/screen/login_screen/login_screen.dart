import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
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
                  Text(
                    'Nobarin',
                    style: Theme.of(context).textTheme.bodyText1,
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
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          // onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          final isValidForm =
                              formLogin.currentState!.validate();
                          if (isValidForm) {
                            final bool isValid =
                                EmailValidator.validate(txtEditEmail.text);
                            if (isValid) {
                              authLogin(txtEditEmail.text, txtEditPass.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Email is not valid!')));
                              txtEditPass.clear();
                            }
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.button,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //btn sign up
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          // onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            )),
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.button,
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
    if (id != null && !newUser) {
      context.read<ProfileProvider>().getProfileData(id);
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
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
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
      txtEditEmail.clear();
      txtEditPass.clear();
    } else {
      logindata.setBool('newUser', true);
      logindata.remove('idProfile');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email/Password salah atau belum terdaftar!')));
    }
  }
}
