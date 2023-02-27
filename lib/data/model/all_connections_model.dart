// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllConnectionsModel {
  final String connectionName;
  final String imageUrl;
  final String connectionType;
  final bool isOnline;
  AllConnectionsModel({
    required this.connectionName,
    required this.imageUrl,
    required this.connectionType,
    required this.isOnline,
  });
}

List<AllConnectionsModel> dummyconnections = <AllConnectionsModel>[
  AllConnectionsModel(
    connectionName: 'Abriella Bond',
    imageUrl:
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'MsgMee',
    isOnline: true,
  ),
  AllConnectionsModel(
    connectionName: 'Azul Baldwin',
    imageUrl:
        'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'SocioMee',
    isOnline: true,
  ),
  AllConnectionsModel(
    connectionName: 'Abriella Bond',
    imageUrl:
        'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'MsgMee',
    isOnline: false,
  ),
  AllConnectionsModel(
    connectionName: 'Ava Wright',
    imageUrl:
        'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'SocioMee',
    isOnline: false,
  ),
  AllConnectionsModel(
    connectionName: 'Aila Wiseman',
    imageUrl:
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'MsgMee',
    isOnline: false,
  ),
  AllConnectionsModel(
    connectionName: 'Mariana Dickey',
    imageUrl:
        'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'SocioMee',
    isOnline: true,
  ),
  AllConnectionsModel(
    connectionName: 'Azul Baldwin',
    imageUrl:
        'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'MsgMee',
    isOnline: false,
  ),
  AllConnectionsModel(
    connectionName: 'Ava Wright',
    imageUrl:
        'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'SocioMee',
    isOnline: true,
  ),
  AllConnectionsModel(
    connectionName: 'Aila Wiseman',
    imageUrl:
        'https://images.pexels.com/photos/1547971/pexels-photo-1547971.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'MsgMee',
    isOnline: true,
  ),
  AllConnectionsModel(
    connectionName: 'Mariana Dickey',
    imageUrl:
        'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1600',
    connectionType: 'SocioMee',
    isOnline: false,
  ),
];
