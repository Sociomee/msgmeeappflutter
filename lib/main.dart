import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/presentation/onboarding/splash_screen.dart';
import 'package:msgmee/theme/app_theme.dart';
import 'presentation/authentication/cubit/number_validation/number_validation_cubit.dart';
import 'presentation/msgmee_screen/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NumberValidationCubit()),
            BlocProvider(create: (context) => ShoweditbtnCubit())
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData.light(),
            theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
