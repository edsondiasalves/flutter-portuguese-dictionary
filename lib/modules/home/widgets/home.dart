import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) =>
              HomeBloc()..add(HomeInitializeEvent()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Home')),
          ),
          body: Container(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return Center(child: Text('Initializing...'));
                } else if (state is HomeLoadedState) {
                  return Center(child: Text('Initialized'));
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}