import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';

class ProfileWelcome extends StatelessWidget {
  const ProfileWelcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 40,
          ),
          _buildTitle(),
          SizedBox(
            height: 20,
          ),
          _buildLoginButton(context, width),
          _buildRegisterButton(context, width),
          _buildTouchId(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildTouchId() {
    return Column(
      children: [
        Text('Quick login with Touch ID'),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/images/touch_id.jpg",
          width: 80,
        ),
        SizedBox(
          height: 20,
        ),
        Text('Touch ID'),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          BlocProvider.of<ProfileBloc>(context).add(ProfileRegisterEvent());
        },
        child: _buildButton(width, 'Register', Colors.white),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          BlocProvider.of<ProfileBloc>(context).add(ProfileLoginEvent());
        },
        child: _buildButton(width, 'Login', Colors.blueGrey),
      ),
    );
  }

  Widget _buildButton(double width, String text, Color color) {
    return Container(
      width: width,
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.blueGrey, width: 2),
        boxShadow: [
          BoxShadow(
            color: color,
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          "Dicionário Português",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Brasil vs Portugal",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
