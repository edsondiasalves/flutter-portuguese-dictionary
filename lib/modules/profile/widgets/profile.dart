import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';

import '../profile.dart';

class Profile extends StatelessWidget {
  const Profile([key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(child: Text('Profile')),
        ),
        body: Container(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoginState) {
                return ProfileLogin();
              } else if (state is ProfileRegisterState) {
                return ProfileRegister();
              }
              return ProfileWelcome();
            },
          ),
        ),
      ),
    );
  }
}
