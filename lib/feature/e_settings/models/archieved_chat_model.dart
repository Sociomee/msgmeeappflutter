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

List<ArchievedChatModel> archievedChatList = [
  ArchievedChatModel(name: 'Guy Hawkins', size: '12.4 Mb', selected: true),
  ArchievedChatModel(name: 'Ralph Edwards', size: '25 Mb', selected: true),
  ArchievedChatModel(
      name: 'Cameron Williamson', size: '12.4 Mb', selected: true),
  ArchievedChatModel(name: 'Annette Black', size: '40 Mb', selected: true),
  ArchievedChatModel(name: 'Eleanor Pena', size: '120 Mb', selected: true),
  ArchievedChatModel(name: 'Esther Howard', size: '240 Mb', selected: true),
  ArchievedChatModel(name: 'Albert Flores', size: '10 Mb', selected: true),
  ArchievedChatModel(name: 'Arlene McCoy', size: '64 Mb', selected: true),
];
