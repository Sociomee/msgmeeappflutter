class NetworkDetailsModel {
  final String title;
  final String usage;
  NetworkDetailsModel({
    required this.title,
    required this.usage,
  });
}

List<NetworkDetailsModel> dataList = [
  NetworkDetailsModel(title: 'Sent', usage: '435'),
  NetworkDetailsModel(title: 'Received', usage: '156'),
  NetworkDetailsModel(title: 'Total size sent ', usage: '78.25 kb'),
  NetworkDetailsModel(title: 'Total size received', usage: '35.68 kb'),
];
List<NetworkDetailsModel> callsData = [
  NetworkDetailsModel(title: 'Outgoing calls', usage: '00'),
  NetworkDetailsModel(title: 'Incoming calls', usage: '20'),
  NetworkDetailsModel(title: 'Total size sent ', usage: '24 Mb'),
  NetworkDetailsModel(title: 'Total size received', usage: '35 Mb'),
];
