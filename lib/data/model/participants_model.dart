class ParticipantsModel {
  final String username;
  final String usertype;
  final String imageUrl;
  bool isSelected;
  ParticipantsModel({
    required this.username,
    required this.usertype,
    required this.isSelected,
    required this.imageUrl,
  });
}

List<ParticipantsModel> blockedUserlist = [
  ParticipantsModel(
      username: 'Guy Hawkins',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Ralph Edwards',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Cameron Williamson',
      usertype: 'Group',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Annette Black',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Eleanor Pena',
      usertype: 'MsgMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Eleanor Pena',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Albert Flores',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Arlene McCoy',
      usertype: 'Group',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Jenny Wilson',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/2773977/pexels-photo-2773977.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Kathryn Murphy',
      usertype: 'MsgMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  ParticipantsModel(
      username: 'Guy Hawkins',
      usertype: 'MsgMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/2918513/pexels-photo-2918513.jpeg?auto=compress&cs=tinysrgb&w=1600'),
];