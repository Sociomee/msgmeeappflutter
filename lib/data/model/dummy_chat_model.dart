class ChatModel {
  final String imageUrl;
  final String name;
  final bool hasStory;
  final bool isOnline;
  final String time;
  final String message;
  final int unseenMessage;
  bool isMuted;
  ChatModel({
    required this.imageUrl,
    required this.name,
    required this.hasStory,
    required this.isOnline,
    required this.time,
    required this.message,
    required this.unseenMessage,
    this.isMuted = false,
  });
}

List<ChatModel> dummyData = <ChatModel>[
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Jocelyn Westervelt',
      hasStory: true,
      isOnline: true,
      time: 'now',
      message: 'typing..',
      unseenMessage: 2),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
    imageUrl:
        'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    name: 'Anika George',
    hasStory: false,
    isOnline: true,
    time: '4h ago',
    message: 'You missed a voice call',
    unseenMessage: 1,
    isMuted: true,
  ),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: true,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1564),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: 'yesterday',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
    imageUrl:
        'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    name: 'Anika George',
    hasStory: false,
    isOnline: true,
    time: '4h ago',
    message: 'You missed a voice call',
    unseenMessage: 1,
    isMuted: true,
  ),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: true,
      isOnline: true,
      time: 'yesterday',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
    imageUrl:
        'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    name: 'Anika George',
    hasStory: false,
    isOnline: true,
    time: '4h ago',
    message: 'You missed a voice call',
    unseenMessage: 1,
    isMuted: true,
  ),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
    imageUrl:
        'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    name: 'Anika George',
    hasStory: false,
    isOnline: true,
    time: '4h ago',
    message: 'You missed a voice call',
    unseenMessage: 1,
    isMuted: true,
  ),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
  ChatModel(
    imageUrl:
        'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    name: 'Anika George',
    hasStory: false,
    isOnline: true,
    time: '4h ago',
    message: 'You missed a voice call',
    unseenMessage: 1,
    isMuted: true,
  ),
  ChatModel(
      imageUrl:
          'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=1600',
      name: 'Razdar Hasan',
      hasStory: false,
      isOnline: true,
      time: '3m ago',
      message: 'Cool I will see you there',
      unseenMessage: 1),
];
