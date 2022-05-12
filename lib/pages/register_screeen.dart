import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(),
              _registerButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _logo() {
    return const Text(
      "Vartalaap",
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.06,
      color: Colors.purple,
      onPressed: () {},
      child: const Text("Register",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
    );
  }
}
