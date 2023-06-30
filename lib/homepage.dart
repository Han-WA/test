import 'package:blogapp/articleformpage.dart';
import 'package:blogapp/service/cubit/cubit/get_article_cubit.dart';
import 'package:blogapp/service/cubit/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Blog App"),
              ),
              ListTile(
                title: ElevatedButton(
                  child: Text("Post Article"),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ArticleFormPage.routeName);
                  },
                ),
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text("Read Article"),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Blog"),
        ),
        body: BlocBuilder<GetArticleCubit, GetArticleState>(
          builder: (context, state) {
            if (state is GetArticleSuccess) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemCount: state.article.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            thickness: 2,
                          ),
                          Image.network(
                            state.article[index].image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Text(state.article[index].title),
                          Text(state.article[index].body),
                        ],
                      ),
                    );
                  },
                ),
                onRefresh: () {
                  return Future.delayed(
                    Duration(seconds: 1),
                    () {
                      setState(() {
                        BlocProvider.of<GetArticleCubit>(context)
                            .getArticleData();
                      });
                    },
                  );
                },
              );
            } else if (state is GetArticleFail) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
