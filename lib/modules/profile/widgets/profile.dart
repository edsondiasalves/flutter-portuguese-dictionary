import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) =>
              ProfileBloc()..add(ProfileInitializeEvent()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Profile')),
          ),
          body: Container(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return Center(child: Text('Initializing Profile...'));
                } else if (state is ProfileLoadedState) {
                  return Center(child: Text('Profile Initialized'));
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
