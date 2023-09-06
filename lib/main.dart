import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/a_onboarding/presentation/pages/splash_screen.dart';
import 'package:msgmee/feature/b_auth/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:msgmee/feature/e_settings/cubit/choose_language_cubit.dart';
import 'package:msgmee/theme/app_theme.dart';
import 'common_cubits/reduce_number_cubit.dart';
import 'feature/b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import 'feature/b_auth/presentation/cubit/otp_send/otp_send_cubit.dart';
import 'feature/b_auth/presentation/cubit/otp_verify/otp_verify_cubit.dart';
import 'feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import 'feature/c_profile/presentation/cubit/interest/interest_cubit.dart';
import 'feature/c_profile/presentation/cubit/update_profile/update_profile_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/add_message/add_message_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/change_wallpaperview.dart';
import 'feature/c_social_chat/presentation/cubit/chat_selection_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/chat_theme/chat_theme_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/chatheads/chathead_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/choose_image_wallpaper_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/choose_solid_color_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/get_contact/get_contact_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/msgmee_contact/msgmee_contact_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/reply_msg/reply_msg_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/search_mode/search_mode_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/set_chatbg/set_chatbg_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/show_attachment.dart';
import 'feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'feature/c_social_chat/presentation/cubit/show_emoji/show_emoji_cubit.dart';
import 'feature/c_social_chat/presentation/cubit/sycn_with_sociomee.dart';
import 'feature/c_social_chat/presentation/cubit/sync_sociomee/sync_sociomee_cubit.dart';
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
            BlocProvider(create: (context) => ChooseSolidColorCubit()),
            BlocProvider(create: (context) => ChooseImageWallpaperCubit()),
            BlocProvider(create: (context) => SetChatbgCubit()),
            BlocProvider(create: (context) => ChangeWallPaperView()),
            BlocProvider(create: (context) => SyncWithSociomee()),
            BlocProvider(create: (context) => OtpSendCubit()),
            BlocProvider(create: (context) => OtpVerifyCubit()),
            BlocProvider(create: (context) => ReduceNumberCubit()),
            BlocProvider(create: (context) => ReplyMsgCubit()),
            BlocProvider(create: (context) => SearchModeCubit()),
            BlocProvider(create: (context) => SelectionCubit()),
            BlocProvider(create: (context) => ShowEmojiCubit()),
            BlocProvider(create: (context) => ChooseLanguageCubit()),
            BlocProvider(create: (context) => MsgmeeContactCubit()),
            BlocProvider(create: (context) => ChatHeadCubit()),
            BlocProvider(create: (context) => GetContactCubit()),
            BlocProvider(create: (context) => SyncSociomeeCubit()),
            BlocProvider(create: (context) => UpdateUserCubit()),
            BlocProvider(create: (context) => GetUserdetailsCubit()),
            BlocProvider(create: (context) => UpdateProfileCubit()),
            BlocProvider(create: (context) => InterestCubit())
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
