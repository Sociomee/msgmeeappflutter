class UserModel {
  final String user;
  final String imageUrl;
  UserModel({
    required this.user,
    required this.imageUrl,
  });
}

final UserModel user = UserModel(
  user: 'John Doe',
  imageUrl:
      'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600',
);
