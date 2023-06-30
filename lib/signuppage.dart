import 'package:blogapp/homepage.dart';
import 'package:blogapp/service/cubit/create%20new%20acc/post_newacc_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signuppage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String sp_email = "";
  String sp_password = "";

  FocusNode? node = null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _email() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: const InputDecoration(
        labelText: "Enter Your Email Address",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Email is Required!";
        }
      },
      onSaved: (String? value) {
        sp_email = value!;
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
          return "Password is Required!";
        }
      },
      onSaved: (String? value) {
        sp_password = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("Please Sign Up Here"),
            BlocConsumer<PostNewaccCubit, PostNewaccState>(
              listener: (context, state) {
                if (state is PostNewaccLoading) {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      title: Text("Loading"),
                    ),
                  );
                } else if (state is PostNewaccFail) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      title: Text("Loading"),
                    ),
                  );
                } else if (state is PostNewaccSuccess) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Welcome to Blog_App"),
                      content: const Text("Your account has been created"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(HomePage.routeName);
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _email(),
                      _password(),
                      const SizedBox(
                        height: 20,
                      ),

                      //Sign Up Button
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  actions: [
                                    Text("Sorry, Your Acc was not created!"),
                                  ],
                                );
                              },
                            );
                          }
                          _formKey.currentState!.save();

                          BlocProvider.of<PostNewaccCubit>(context)
                              .postNewAccData(sp_email, sp_password);

                          setState(() {
                            sp_email = "";
                            sp_password = "";
                          });

                          //BLOC and Create acc
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: Size(320, 50),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
