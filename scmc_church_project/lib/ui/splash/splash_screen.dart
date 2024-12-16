import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/bloc/splash_init/splash_init_bloc.dart';
import 'package:scmc_church_project/bloc/splash_init/splash_init_event.dart';
import 'package:scmc_church_project/bloc/splash_init/splash_init_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashInitBloc? splashInitBloc;

  @override
  void initState() {
    super.initState();
    // Access the BlocProvider after the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashInitBloc = BlocProvider.of<SplashInitBloc>(context);
      splashInitBloc?.add(InitFetchDataEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashInitBloc, SplashInitState>(
        builder: (context, state) {
          return Center(
            child: Container(
              color: Colors.amberAccent,
              child: Text(state.strData ?? "Loading..."),
            ),
          );
        },
      ),
    );
  }
}
