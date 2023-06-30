import "package:flutter/material.dart";

class EmailLogInPage extends StatefulWidget {
  static const String routeName = '/emailloginpage';

  const EmailLogInPage({super.key});

  @override
  State<EmailLogInPage> createState() => _EmailLogInPageState();
}

class _EmailLogInPageState extends State<EmailLogInPage> {
  String email = "";
  String password = "";

  FocusNode? node = null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _email() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: const InputDecoration(
        labelText: "Enter Email Password",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Email is required!";
        }
      },
      onSaved: (String? value) {
        email = value!;
      },
    );
  }

  Widget _password() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: const InputDecoration(
        labelText: "Enter Password",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "password is required!";
        }
      },
      onSaved: (String? value) {
        password = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _email(),
              _password(),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: Size(320, 50),
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
