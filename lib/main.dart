import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/a_onboarding/presentation/pages/splash_screen.dart';
import 'package:msgmee/theme/app_theme.dart';
import 'feature/b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/add_message/add_message_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/chat_theme/chat_theme_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/show_attachment.dart';
import 'feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/show_loader/show_loader.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.white, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
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
            BlocProvider(create: (context) => ShowContactTextField()),
            BlocProvider(create: (context) => SyncMsgCubit()),
            BlocProvider(create: (context) => ShowLoaderCubit()),
            BlocProvider(create: (context) => ShowAudioRecorder()),
            BlocProvider(create: (context) => ShowAttachment()),
            BlocProvider(create: (context) => AddMessageCubit()),
            BlocProvider(create: (context) => SelectedchatCubit()),
            BlocProvider(create: (context) => ChatThemeCubit()),
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
