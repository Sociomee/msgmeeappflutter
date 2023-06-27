class BlockContact {
  final String imageUrl;
  final String title;
  final String subtitle;

  BlockContact(
      {required this.imageUrl, required this.title, required this.subtitle});
}

List<BlockContact> blockedList = [
  BlockContact(
      imageUrl:
          'https://images.pexels.com/photos/1547971/pexels-photo-1547971.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Theresa Webb',
      subtitle: 'theresa_test'),
  BlockContact(
      imageUrl:
          'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jacob Jones',
      subtitle: 'jacob_test'),
  BlockContact(
      imageUrl:
          'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Floyd Miles',
      subtitle: 'floyd_test'),
];