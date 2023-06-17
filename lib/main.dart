import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/a_onboarding/presentation/pages/splash_screen.dart';
import 'package:msgmee/theme/app_theme.dart';
import 'feature/b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NumberValidationCubit()),
            BlocProvider(create: (context) => ShoweditbtnCubit()),
            BlocProvider(create: (context) => ShowContactTextField())
          ],
          child: MaterialApp(
            title: 'Msgmee App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
