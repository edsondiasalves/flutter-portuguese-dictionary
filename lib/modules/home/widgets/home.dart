import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/model/model.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';

class Home extends StatelessWidget {
  const Home([key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Center(child: Text('Home')),
        ),
        body: Container(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeLoadedState) {
                return Container(
                  child: ListView(
                    children: state.articles
                        .map((article) => ArticlePaper(article: article))
                        .toList(),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class ArticlePaper extends StatelessWidget {
  final Article article;

  const ArticlePaper({this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitle(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(article.imageUrl),
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Text(article.title),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(article.content),
    );
  }
}
