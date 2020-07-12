import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';

class Profile extends StatelessWidget {
  const Profile([key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                return Center(
                  child: Text(
                    'Initializing Profile...',
                    key: Key('Profile_Initializing'),
                  ),
                );
              } else if (state is ProfileLoadedState) {
                return Center(
                  child: Text(
                    'Profile Initialized',
                    key: Key('Profile_Initialized'),
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
