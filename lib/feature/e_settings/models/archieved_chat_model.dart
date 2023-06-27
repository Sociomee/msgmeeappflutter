class ArchievedChatModel {
  final String name;
  final String size;
  bool selected;
  ArchievedChatModel({
    required this.name,
    required this.size,
    required this.selected,
  });
}

class SelectModel {
  final String name;
  final String size;
  final bool selected;
  SelectModel({
    required this.name,
    required this.size,
    required this.selected,
  });
}

List<SelectModel> selectAllchat = [
  SelectModel(name: 'Guy Hawkins', size: '12.4 Mb', selected: true),
  SelectModel(name: 'Ralph Edwards', size: '25 Mb', selected: true),
  SelectModel(name: 'Cameron Williamson', size: '12.4 Mb', selected: true),
  SelectModel(name: 'Annette Black', size: '40 Mb', selected: true),
  SelectModel(name: 'Eleanor Pena', size: '120 Mb', selected: true),
  SelectModel(name: 'Esther Howard', size: '240 Mb', selected: true),
  SelectModel(name: 'Albert Flores', size: '10 Mb', selected: true),
  SelectModel(name: 'Arlene McCoy', size: '64 Mb', selected: true),
];
List<ArchievedChatModel> archievedChatList = [
  ArchievedChatModel(name: 'Guy Hawkins', size: '12.4 Mb', selected: false),
  ArchievedChatModel(name: 'Ralph Edwards', size: '25 Mb', selected: false),
  ArchievedChatModel(
      name: 'Cameron Williamson', size: '12.4 Mb', selected: false),
  ArchievedChatModel(name: 'Annette Black', size: '40 Mb', selected: false),
  ArchievedChatModel(name: 'Eleanor Pena', size: '120 Mb', selected: false),
  ArchievedChatModel(name: 'Esther Howard', size: '240 Mb', selected: false),
  ArchievedChatModel(name: 'Albert Flores', size: '10 Mb', selected: false),
  ArchievedChatModel(name: 'Arlene McCoy', size: '64 Mb', selected: false),
];
