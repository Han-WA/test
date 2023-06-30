import 'package:blogapp/model/article_model.dart';
import 'package:blogapp/service/cubit/cubit/get_article_cubit.dart';
import 'package:blogapp/service/cubit/cubit/post_article_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleFormPage extends StatefulWidget {
  static const String routeName = '/articleformpage';
  const ArticleFormPage({super.key});

  @override
  State<ArticleFormPage> createState() => _ArticleFormPageState();
}

class _ArticleFormPageState extends State<ArticleFormPage> {
  String imglink = "";
  String title = "";
  String body = "";
  String date = "";

  late ArticleModel newArticle;

  FocusNode? node = null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _imglink() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: const InputDecoration(
        labelText: "Put Image Link Here",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Image link is required!";
        }
      },
      onSaved: (String? value) {
        imglink = value!;
      },
    );
  }

  Widget _title() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: const InputDecoration(
        labelText: "Article Title",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Title is required!";
        }
      },
      onSaved: (String? value) {
        title = value!;
      },
    );
  }

  Widget _body() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: "Write article here",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "body part is required!";
        }
      },
      onSaved: (String? value) {
        body = value!;
      },
    );
  }

  Widget _date() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: const InputDecoration(
        labelText: "Place Date Here",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Date is required!";
        }
      },
      onSaved: (String? value) {
        date = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Article Here"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<PostArticleCubit, PostArticleState>(
                listener: (context, state) {
                  if (state is PostArticleLoading) {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text("Loading"),
                      ),
                    );
                  } else if (state is PostArticleFail) {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Post Article Fail!"),
                        content: const Text("Don't know what is wrong."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Try Again"),
                          ),
                        ],
                      ),
                    );
                    setState(() {
                      imglink = "";
                      title = "";
                      body = "";
                      date = "";
                    });
                  } else if (state is PostArticleSuccess) {
                    Navigator.of(context).pop();
                    BlocProvider.of<GetArticleCubit>(context).getArticleData();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Artical Posted!"),
                        content: const Text("Congrat!!!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imglink(),
                        _title(),
                        _date(),
                        _body(),
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: const LinearGradient(
                              begin: Alignment(-0.95, 0.0),
                              end: Alignment(1.0, 0.0),
                              colors: [Color(0xff45F4FF), Color(0xff64b6ff)],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      actions: [
                                        Text(
                                            "Sorry, Your Article has not been created"),
                                      ],
                                    );
                                  },
                                );
                              }
                              _formKey.currentState!.save();

                              setState(() {
                                newArticle = ArticleModel(
                                    body: body,
                                    date: date,
                                    image: imglink,
                                    title: title);
                              });
                              BlocProvider.of<PostArticleCubit>(context)
                                  .postArticleData(newArticle);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor: Colors.transparent,
                              minimumSize: const Size(320, 50),
                            ),
                            child: const Center(
                              child: Text(
                                "Post Article",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
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
      ),
    );
  }
}
