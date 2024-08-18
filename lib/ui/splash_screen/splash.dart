import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/ui/splash_screen/splash_bloc/splash_bloc.dart';
import 'package:mabrook/utility/auth_bloc/auth_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    var splashBloc = BlocProvider.of<SplashBloc>(context);
    splashBloc.add(LogPrefs());
    splashBloc.add(CheckVersionControl(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
              alignment: Alignment.bottomCenter,
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is AuthLoggedIn) {
                    print("state.config?.baseApiDetails: ${state.config?.baseApiDetails}");
                    return Text(state.version, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),).pOnly(bottom: 20);
                  }
                  return Container();
                }
              )
          )
        ],
      ),
    );
  }

}
