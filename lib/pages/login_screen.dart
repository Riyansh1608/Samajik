import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: UI(),
    );
  }

  Widget UI() {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _logo(),
            _loginForm(),
            _loginButton(),
            _noAccount(),
          ],
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

  Widget email() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: "Email..."),
      onSaved: (_value) {
        setState(() {
          _email = _value;
        });
      },
      validator: (_value) {
        bool _result = _value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
        );
        return _result ? null : "Please enter a valid email";
      },
    );
  }

  Widget password() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: "Password..."),
      onSaved: (_value) {
        setState(() {
          _password = _value;
        });
      },
      validator: (_value) => _value!.length > 6
          ? null
          : "Please enter a password greater than ^ characters ",
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.40,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            email(),
            password(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.06,
      color: Colors.purple,
      onPressed: () {
        _loginUser();
      },
      child: const Text("Login",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
    );
  }

  Widget _noAccount() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/register'),
      child: const Text(
        "Don't have an account ?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  void _loginUser() {
    print(_loginFormKey.currentState!.validate());
    print(_email);
    print(_password);
    if (_loginFormKey.currentState!.validate()) {}
  }
}
