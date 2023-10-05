import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/onboarding_data_model.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState.initial());

  void getOnboardingItem() {
    emit(state.copyWith(items: [
      OnboardingModel(
        title: 'Welcome to\nMsgMee',
        image: '',
        bgImage: 'assets/onboarding/onboard_bg1.png',
        textDesc: 'Connecting with friends in a secure, fast and reliable way.',
        index: 1,
      ),
      OnboardingModel(
        title: 'Empower Your\nVoice ',
        image: '',
        bgImage: 'assets/onboarding/onboard_bg1.png',
        textDesc: 'Engage with your friends,\nbuild relationships.',
        index: 2,
      ),
      OnboardingModel(
        title: 'Be The\nPresenter',
        image: '',
        bgImage: 'assets/onboarding/onboard_bg1.png',
        textDesc: 'Join MsgMee and become\npart of a growing community.',
        index: 3,
      ),
    ]));
  }

  getCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index + 1));
  }
}
