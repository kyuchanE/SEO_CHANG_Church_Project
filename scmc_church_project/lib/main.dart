import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/injectable/configurations.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scmc_church_project/ui/main/main_screen.dart';
import 'package:scmc_church_project/ui/splash/splash_screen.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_state.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashInitBloc>(
          create: (context) => getIt<SplashInitBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<SplashInitBloc, SplashInitState>(
          builder: (context, state) {
            if (state.status == SplashInitStatus.success) {
              /// init data success
              return MainScreen();
            } else {
              /// init data loading or error
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
