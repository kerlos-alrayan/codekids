import 'package:codekids/constants.dart';
import 'package:codekids/core/utils/app_router.dart';
import 'package:codekids/features/home/presentation/manger/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/auth/presentation/manger/sign_up_steps_cubit/sign_up_steps_cubit.dart';
import 'features/introduction/data/models/auth_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authViewModel = AuthViewModel();
  await authViewModel.init();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authViewModel),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavBarCubit()),
        BlocProvider(create: (context) => StepCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'CodeKids',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        ),
      ),
    );
  }
}
