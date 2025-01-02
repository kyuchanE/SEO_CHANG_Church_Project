import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_bloc.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_event.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_state.dart';
import 'package:scmc_church_project/ui/splash/widget/default_splash_body_widget.dart';
import 'package:scmc_church_project/ui/splash/widget/error_splash_body_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashInitBloc? splashInitBloc;
  // TODO chan main.dart에서 화면 전환을 시도하는게 올바를것 같다.
  bool isEnterMainScreen = false;

  @override
  void initState() {
    super.initState();
    // Access the BlocProvider after the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashInitBloc = BlocProvider.of<SplashInitBloc>(context);
      // TODO chan test Firestore database connection
      splashInitBloc?.add(InitFetchDataEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashInitBloc, SplashInitState>(
        builder: (context, state) {
          return _splashBody(state.status);
        },
      ),
    );
  }

  /// 스플래시 화면 상태에 따른 화면 표시
  Widget _splashBody(SplashInitStatus status) {
    switch (status) {
      case SplashInitStatus.loading:
        return Center(
          child: Container(
            color: Colors.amberAccent,
            child: Text("Loading..."),
          ),
        );
      case SplashInitStatus.error:
        return errorSplashBody();
      default:
        return defaultSplashBody();
    }
  }
}
