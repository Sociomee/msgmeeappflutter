// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardingDataModel {
  final String title;
  final String imageUrl;
  final int index;
  final String descriptionText;
  OnboardingDataModel({
    required this.title,
    required this.imageUrl,
    required this.index,
    required this.descriptionText,
  });
}

class OnboardingModel {
  final String image;
  final String bgImage;
  final String textDesc;
  final String title;
  final int index;
  OnboardingModel(
      {required this.title,
      required this.index,
      required this.bgImage,
      required this.image,
      required this.textDesc});
}

List<OnboardingDataModel> data = [
  OnboardingDataModel(
      title: 'Welcome to\nMsgMee',
      index: 1,
      imageUrl: 'assets/onboarding/onboarding1.svg',
      descriptionText:
          'Connecting with friends in a secure, fast and reliable way.'),
  OnboardingDataModel(
      title: 'Empower Your\nVoice ',
      index: 2,
      imageUrl: 'assets/onboarding/onboarding2.svg',
      descriptionText: 'Engage with your friends,\nbuild relationships.'),
  OnboardingDataModel(
      title: 'Be The\nPresenter',
      index: 3,
      imageUrl: 'assets/onboarding/onboarding3.svg',
      descriptionText: 'Join MsgMee and become\npart of a growing community.'),
];
