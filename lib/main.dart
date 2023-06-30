import 'package:blogapp/articleformpage.dart';
import 'package:blogapp/login_emailpage.dart';
import 'package:blogapp/service/cubit/create%20new%20acc/post_newacc_cubit.dart';
import 'package:blogapp/service/cubit/cubit/get_article_cubit.dart';
import 'package:blogapp/service/cubit/cubit/post_article_cubit.dart';
import 'package:blogapp/service/cubit/locator.dart';
import 'package:blogapp/signuppage.dart';
import 'package:blogapp/welcomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  locator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetArticleCubit>(
          create: (_) => getIt.call(),
        ),
        BlocProvider<PostArticleCubit>(
          create: (_) => getIt.call(),
        ),
        BlocProvider<PostNewaccCubit>(
          create: (_) => getIt.call(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Blog App",
        routes: {
          "/": (context) => WelcomePage(),
          EmailLogInPage.routeName: (context) => EmailLogInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          ArticleFormPage.routeName: (context) => ArticleFormPage(),
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
