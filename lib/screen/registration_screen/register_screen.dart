import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:movie/auth/login.dart';
import 'package:movie/repository/profile.dart';
import 'package:movie/widgets/container_opacity_widget/container_opacity_widget.dart';
import 'package:provider/provider.dart';
import '../../provider/connectivity/connection_provider.dart';
import '../../widgets/error_handling_widget/error_handle_widget.dart';
import '../../widgets/registration_screen/registration_widget.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formRegis = GlobalKey<FormState>();
  bool notConnected = false;
  @override
  void initState() {
    context.read<CheckConnectivityProvider>().initConnectivity();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<CheckConnectivityProvider>().initConnectivity();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CheckConnectivityProvider>(context).connectivityState;
    checkConnection();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1523154410-31a6b052652b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            errorBuilder:
                (BuildContext context, Object object, StackTrace? stackTrace) {
              return const ErrorHandleWidget();
            },
          ),
          if (notConnected)
            containerOpacityWidget(
                context, Colors.black, Colors.black, 0.8, 0.4),
          if (notConnected)
            const Center(
              child: Text('Please Check Your Connectivity..'),
            ),
          if (!notConnected)
            containerOpacityWidget(
                context, Colors.black, Colors.black, 0.8, 0.4),
          if (!notConnected)
            Container(
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
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: regisInputPassword()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: regisInputNama()),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: regisInputNoHp()),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.white)),
                              onPressed: () {
                                final isValidForm =
                                    formRegis.currentState!.validate();

                                if (isValidForm) {
                                  final bool isValid = EmailValidator.validate(
                                      txtRegisEmail.text);
                                  if (isValid &&
                                      Fzregex.hasMatch(txtRegisPass.text,
                                          FzPattern.passwordNormal1)) {
                                    authLogin(
                                        txtRegisEmail.text,
                                        txtRegisPass.text,
                                        txtRegisNama.text,
                                        txtRegisNohp.text);
                                  } else if (isValid == false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Email is not valid!')));
                                    txtRegisPass.clear();
                                  } else if (Fzregex.hasMatch(txtRegisPass.text,
                                          FzPattern.passwordNormal1) ==
                                      false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Password must contains at least 8 character, 1 letter and 1 Number')));
                                    // txtRegisPass.clear();
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
            ),
        ],
      )),
    );
  }

  void authLogin(
      String email, String password, String nama, String nohp) async {
    final ava = await ProfileApi().getImageRandom();
    await AuthUser().register(email, password, ava.urls!.small!, nama, nohp);
    txtRegisEmail.clear();
    txtRegisPass.clear();
    txtRegisNama.clear();
    txtRegisNohp.clear();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Success!\nSilahkan Login')));
  }

  checkConnection() {
    final _connectionStatus =
        Provider.of<CheckConnectivityProvider>(context).connectivityState;
    if (_connectionStatus != ConnectivityResult.none) {
      setState(() {
        notConnected = false;
      });
    } else {
      setState(() {
        notConnected = true;
      });
    }
  }
}
