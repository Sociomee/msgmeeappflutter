class PhoneModel {
  final String imageUrl;
  final String name;
  final int calltype;
  final String message;
  final String time;

  PhoneModel(this.imageUrl, this.name, this.calltype, this.message, this.time);
}

List<PhoneModel> dummyPhoneData = <PhoneModel>[
  PhoneModel(
      'https://images.pexels.com/photos/1454360/pexels-photo-1454360.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'Collage Group',
      0,
      'You missed 3 voice calls',
      '2 w ago'),
  PhoneModel(
      'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'Emile',
      1,
      'Today, 11:00',
      '2 w ago'),
  PhoneModel(
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'Razdar Hasan',
      2,
      'Last called 10m ago',
      '2 w ago'),
  PhoneModel(
      'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'Anika George',
      0,
      'Today, 11:00',
      '2 w ago'),
];
