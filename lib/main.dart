import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/a_onboarding/presentation/pages/splash_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/typing/cubit/typing_cubit.dart';
import 'package:msgmee/feature/e_settings/cubit/choose_language_cubit.dart';
import 'package:msgmee/repos/base_repo.dart';
import 'package:msgmee/theme/app_theme.dart';
import 'package:path/path.dart';
import 'common_cubits/connectivity_cubit.dart';
import 'common_cubits/reduce_number_cubit.dart';
import 'connectivity/socket_service.dart';
import 'data/sqlite_data_source/sqlite_helper.dart';
import 'feature/a_onboarding/cubit/onboarding/onboarding_cubit.dart';
import 'feature/b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import 'feature/b_auth/presentation/cubit/otp_send/otp_send_cubit.dart';
import 'feature/b_auth/presentation/cubit/otp_verify/otp_verify_cubit.dart';
import 'feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import 'feature/c_profile/presentation/cubit/select_group_cubit/select_group_cubit.dart';
import 'feature/c_profile/presentation/cubit/upload_profilepic/upload_profilepic_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/add_message/add_message_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/change_wallpaperview.dart';
import 'feature/c_social_chat/presentation/cubit/chat_selection_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/chat_theme/chat_theme_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/choose_image_wallpaper_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/choose_solid_color_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/get_contact/get_contact_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/msgmee_user_list/msgmee_user_list_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/reply_msg/reply_msg_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/search_mode/search_mode_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/set_chatbg/set_chatbg_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/show_attachment.dart';
import 'feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'feature/c_social_chat/presentation/cubit/show_emoji/show_emoji_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/sync_sociomee/sync_sociomee_cubit.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/show_loader/show_loader.dart';
import 'feature/c_social_chat/presentation/pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLiteHelper().initialize();
  //await SQLiteHelper().clearAndReinitializeDatabase();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.white, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));

  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider(create: (context)=> BaseRepo())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final botToastBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {

    SocketService().initSocket(); // Initialize the socket
    // Set a global listener
    
    SocketService().setListener((data) {
      print('Global Listener: $data');
      // Handle the data globally
    });
    
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ConnectivityCubit()),
            BlocProvider(create: (context) => OnboardingCubit()),
            BlocProvider(create: (context) => ShoweditbtnCubit()),
            BlocProvider(create: (context) => ShowContactTextField()),
            BlocProvider(create: (context) => ShowLoaderCubit()),
            BlocProvider(create: (context) => ShowAudioRecorder()),
            BlocProvider(create: (context) => ShowAttachment()),
            BlocProvider(create: (context) => TypingCubit()),
            BlocProvider(create: (context) => AddMessageCubit()),
            BlocProvider(create: (context) => SelectedchatCubit()),
            BlocProvider(create: (context) => ChatThemeCubit()),
            BlocProvider(create: (context) => ChooseSolidColorCubit()),
            BlocProvider(create: (context) => ChooseImageWallpaperCubit()),
            BlocProvider(create: (context) => SetChatbgCubit()),
            BlocProvider(create: (context) => ChangeWallPaperView()),
            BlocProvider(create: (context)=>NumberValidationCubit()),
            BlocProvider(create: (context) => OtpSendCubit()),
            BlocProvider(create: (context) => OtpVerifyCubit()),
            BlocProvider(create: (context) => ReduceNumberCubit()),
            BlocProvider(create: (context) => ReplyMsgCubit()),
            BlocProvider(create: (context) => SearchModeCubit()),
            BlocProvider(create: (context) => SelectionCubit()),
            BlocProvider(create: (context) => ShowEmojiCubit()),
            BlocProvider(create: (context) => ChooseLanguageCubit()),
            BlocProvider(create: (context) => MsgmeeUserListCubit()),
            BlocProvider(create: (context) => ContactCubit()),
            BlocProvider(create: (context) => SyncSociomeeCubit()),
            BlocProvider(create: (context) => GetUserdetailsCubit()),
            BlocProvider(create: (context) => SelectionGroupCubit()),
            BlocProvider(create: (context) => ContactCubit()),
            BlocProvider(create: (context) => UploadProfilepicCubit()),
            BlocProvider(create: (context) => ChatRoomsCubit()),
          ],
          child: MaterialApp(
            title: 'Msgmee App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
            builder: (context, child) {
              SocketService().setContext(context);
              context.read<BaseRepo>().init();
              child = botToastBuilder(context, child);
              return child;
            },
          ),
        );
      },
    );
  }
}
